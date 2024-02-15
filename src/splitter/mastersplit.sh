#!/bin/bash

# Load necessary modules
module load samtools

# Convert BAM to SAM
samtools view -h -o "input.sam" "[INSERT '.BAM' SORTED FILE]"

# Run Java program to format VCF file
java Translator

# Run Java program to split VCF file
java ChromSplitter

# Run Java program to split SAM file
java SamSplitter

# Loop through each chromosome and execute the splitchrom.sh script
# Array to store background process IDs
bg_pids=()

# Loop through each chromosome and execute the splitchrom.sh script in the background
for i in {1..10}; do
    bash splitchrom.sh "Chrom${i}.txt" "AChrom${i}.txt" "BChrom${i}.txt" &
    # Store the background process ID
    bg_pids+=($!)
done

# Wait for all background processes to complete
for pid in "${bg_pids[@]}"; do
    wait "$pid"
done

# All background processes have completed
cd ..
cd searcher
bash samanalysis.sh
