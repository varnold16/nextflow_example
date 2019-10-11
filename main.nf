/* FOR DEMONSTRATION ONLY: subread workflow with nextflow
 * author: vivienne arnold and ricarda erhart
 * -> please read README.md for preliminaries
 */

/** VARIABLES **/
DATA_DIR = "$baseDir/data/"
GENOME = DATA_DIR+"chr1.fa"
GINDEX=GENOME+'.index'
GINDEX_READS=GINDEX+'.reads'
ANNOT = DATA_DIR+"Mus_musculus.GRCm38.90.gtf"
params.SAMPLES = DATA_DIR+"SRR15524*.fastq.gz"
SAMPLE_FILES = Channel.fromPath(params.SAMPLES)
params.ALIGNDIR = "$baseDir/align_results"
params.COUNTDIR = "$baseDir/count_results"

/** TOOLS **/

// conda environment file

CONDA_ENV= "$baseDir/conda-env.yaml"

// index
INDEX_TOOL='subread-buildindex'

// alignment
ALIGN_TOOL='subread-align'
ALIGN_DIR='$baseDir/align/'
A_THREADS=1

// counting
FEAT_TOOL='featureCounts'
COUNTS_DIR='$baseDir/counts/'
C_THREADS=1

/** LOG INFO **/

log.info """\
         R N A S E Q   P I P E L I N E    
         =============================
          a demonstration of nextflow
         created by Ricarda & Vivienne
                in October 2019
         =============================
         """
         .stripIndent()

/** WORKFLOW **/

// building index for alignment
process buildindexGenome {
    conda CONDA_ENV
    input: GENOME
    output: val GINDEX into INDEXREAD_FILE 
    """ 
    ${INDEX_TOOL} -o ${GINDEX} ${GENOME}
    """
}

// align the reads
process alignReads {
    conda CONDA_ENV
    publishDir params.ALIGNDIR, mode: 'copy'
    input:
    each SAMPLE from SAMPLE_FILES
    val GINDEX from INDEXREAD_FILE
    output:
    file "${SAMPLE.baseName}.bam" into BAM_FILES
    file "${SAMPLE.baseName}.bam.indel.vcf" into VCF_FILES
    """
    ${ALIGN_TOOL} -t 0 -T ${A_THREADS} -i ${GINDEX} --gzFASTQinput -r ${SAMPLE} -o ${SAMPLE.baseName}.bam
    """
}

// counting the features
process countFeatures {
    conda CONDA_ENV
    publishDir params.COUNTDIR, mode: 'copy'
    input: each BAM_FILE from BAM_FILES
    output:
    file "${BAM_FILE.baseName}.counts" into COUNT_FILES
    file "${BAM_FILE.baseName}.counts.summary" into COUNT_FILES_SUMMARY
    """
    ${FEAT_TOOL} $BAM_FILE -T ${C_THREADS} -a ${ANNOT} -F 'GTF' -o ${BAM_FILE.baseName}.counts
    """
}

COUNT_FILES.println { "Sample $it.baseName is finished." }

workflow.onComplete { 
	println "${ workflow.success ? 'Done!' : 'Oops .. something went wrong' }"
}
