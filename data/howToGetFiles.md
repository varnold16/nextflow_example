get sample *.fastq.gz-files from https://figshare.com/s/f5d63d8c265a05618137

download and unzip to 'data'-directory:
 - genome file (ftp://hgdownload.cse.ucsc.edu/goldenPath/mm10/chromosomes/chr1.fa.gz)
 - annotation file (ftp://ftp.ensembl.org/pub/release-98/gtf/mus_musculus/Mus_musculus.GRCm38.90.gtf.gz)


you can use:

### download
~/pathToFolder/data$ wget 'ftp://hgdownload.cse.ucsc.edu/goldenPath/mm10/chromosomes/chr1.fa.gz' -O chr1.fa.gz

~/pathToFolder/data$ gunzip data/chr1.fa.gz

~/pathToFolder/data$ wget 'ftp://ftp.ensembl.org/pub/release-98/gtf/mus_musculus/Mus_musculus.GRCm38.90.gtf.gz' -O Mus_musculus.GRCm38.90.gtf.gz

~/pathToFolder/data$ gunzip data/Mus_musculus.GRCm38.90.gtf.gz
