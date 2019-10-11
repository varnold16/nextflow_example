# subread workflow with nextflow

### FOR DEMONSTRATION ONLY

author: vivienne arnold and ricarda erhart


## Instructions

 * install nexflow: '$ curl https://get.nextflow.io | bash; mv nextflow ~/bin; nextflow info'
   or with '$conda install nextflow'

 * make sure, that sample *.fastq.gz-files from
   https://figshare.com/s/f5d63d8c265a05618137 are in 'data'-directory

 * download and unzip to 'data'-directory:
   - genome file (ftp://hgdownload.cse.ucsc.edu/goldenPath/mm10/chromosomes/chr1.fa.gz)
   - annotation file (ftp://ftp.ensembl.org/pub/release-98/gtf/mus_musculus/Mus_musculus.GRCm38.90.gtf.gz)
 
 * run options:
   - standard: '$ nextflow run main.nf -resume'
   - with DAG: '$ nextflow run main.nf -with-dag flowchart.png' to obtain DAG
     (install graphviz with '$ sudo apt-get install graphviz')
