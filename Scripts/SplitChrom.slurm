#!/bin/bash
#SBATCH --job-name=sam_search
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=8G
#SBATCH --time=48:00:00
#SBATCH --output=java_search-%j.out

cd /projects/cooper_research2/JacobC/DiffGeneAnalysis/VertPistil/

input_file=$1
output_file1=$2
output_file2=$3

# Run Java program to split the file
java FileSplitter "$input_file" "$output_file1" "$output_file2"
