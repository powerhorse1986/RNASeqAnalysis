#! /bin/bash
# This script aligns the fastq files using tophat2. Then, gene counts are generated using htseq-count

# Define the path to the gtf file
GTF="/home/mali/study/Project/CAMSC_Coffman/reference_data/gtf/Homo_sapiens.GRCh37.87.gtf"

# Define the path to the index file
INDEX="/home/mali/study/Project/CAMSC_Coffman/reference_data/bowtie2Index/bowtie2Index"

# Use a while loop to do the work
while read -r LINE;
do
	echo "Processing $LINE"
	
	# Define the output directory.
	OUTPUT="/home/mali/study/Project/CAMSC_Coffman/results/tophat2/$LINE"
	
	# Define the paths to the fastq files
	READONE="/home/mali/study/Project/CAMSC_Coffman/raw_data/$LINE/*_1.fastq.gz"
	READTWO="/home/mali/study/Project/CAMSC_Coffman/raw_data/$LINE/*_2.fastq.gz"

	if [ ! -d $OUTPUT ]
	then
		mkdir -p $OUTPUT
	fi
	
	/home/mali/study/Project/CAMSC_Coffman/pipeline/tophat2/2.0.13/tophat2 \
	-p 16 \
	-G $GTF \
	-o $OUTPUT \
	--no-novel-juncs \
	$INDEX \
	$READONE \
	$READTWO

	# Index the bam file
	samtools index $OUTPUT/accepted_hits.bam

	# Generate the gene counts matrices using htseq-count
	echo "Counting $LINE"
	htseq-count \
	-f bam \
	-m union \
	-t exon \
	-i gene_id \
        $OUTPUT/accepted_hits.bam \
	$GTF \
	> $LINE.count
	mv $LINE.count /home/mali/study/Project/CAMSC_Coffman/results/tophat2/counts
done<srr_files_tophat.txt
