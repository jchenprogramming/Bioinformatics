#!/bin/bash

# Load necessary modules
module load samtools

# Convert BAM to SAM
samtools view -h -o "vertpistil.sam" "15.rg.iap.sorted.bam"

# Run Java program to split VCF file
java ChromSplitter

# Run Java program to split SAM file
java SamSplitter

# Loop through each chromosome and execute the splitchrom.sh script
for i in {1..10}; do
    bash splitchrom.sh "Chrom${i}.txt" "AChrom${i}.txt" "BChrom${i}.txt"
done
