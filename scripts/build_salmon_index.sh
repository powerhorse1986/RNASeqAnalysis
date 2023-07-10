#! /bin/bash
# This script helped to build the index files of salmon

# Define the path to the reference genome
REF="/home/mali/study/Project/CAMSC_Coffman/reference_data/ref/Homo_sapiens.GRCh37.dna.primary_assembly.fa"

# Define the path to the index directory
INDEX="/home/mali/study/Project/CAMSC_Coffman/reference_data/salmonIndex_genome"

# Run the command
salmon index -t $REF -i $INDEX
