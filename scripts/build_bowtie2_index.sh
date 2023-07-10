#! /bin/bash
# This script used to build the index for bowtie2

# Define the path to the input reference genome
REF="/home/mali/study/Project/CAMSC_Coffman/reference_data/ref/Homo_sapiens.GRCh37.dna.primary_assembly.fa"

# Define the path to the index directory
INDEX="/home/mali/study/Project/CAMSC_Coffman/reference_data/bowtie2Index"

# Run the command
bowtie2-build -f $REF $INDEX
