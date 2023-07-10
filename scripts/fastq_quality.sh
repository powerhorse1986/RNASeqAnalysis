#! /bin/bash

# This script runs fastqc on all the fastq files

# Define the path to the fastq files
FASTQ="/home/mali/study/Project/CAMSC_Coffman/raw_data"

# Define the path to the fastqc files
FASTQC="/home/mali/study/Project/CAMSC_Coffman/results/fastqc"

# Use a while loop to do the work
while read -r LINE;
do
	echo $LINE
	
	if [ ! -d $FASTQC/$LINE ]
	then
		mkdir -p $FASTQC/$LINE
	fi

	/home/mali/Software/pipeline/FastQC/fastqc -t 16 $FASTQ/$LINE/*.fastq.gz
	mv $FASTQ/$LINE/*fastqc* $FASTQC/$LINE

done<srr_files.txt
