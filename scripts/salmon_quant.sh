#! /bin/bash
# This file will generate gene quants using salmon

# Define the path to the salmon index
INDEX_PATH="/home/mali/study/Project/CAMSC_Coffman/reference_data/salmonIndex_transcript"

# Define the path to the reference genome
REF="/home/mali/study/Project/CAMSC_Coffman/reference_data/ref/Homo_sapiens.GRCh37.cdna.all.fa"

# Claim the path to the fastq files
FASTQ="/home/mali/study/Project/CAMSC_Coffman/raw_data"

# Check if this directory exist or not. If not, create one
if [ ! -d $INDEX_PATH ]
then
	echo "Create $INDEX_PATH"
	mkdir -p $INDEX_PATH
fi

# Generate salmon index
#salmon index -t $REF -i $INDEX_PATH

# Salmon quantification!!! Faster than STAR
while read -r LINE;
do
	echo "Quantifying $LINE"

	# Define the output path. And create one if the path does not exist
	OUT="/home/mali/study/Project/CAMSC_Coffman/results/salmon/$LINE"
	if [ ! -d $OUT ]
	then
		echo "Create $OUT"
		mkdir -p $OUT
	fi

	salmon quant \
	-i $INDEX_PATH \
	-l A \
	-1 $FASTQ/$LINE/*_1.fastq.gz \
	-2 $FASTQ/$LINE/*_2.fastq.gz \
	-p 16 \
	--validateMappings \
	-o $OUT 

done<srr_files.txt
