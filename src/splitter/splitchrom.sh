#!/bin/bash

# Get command-line arguments
input_file=$2
output_file1=$3
output_file2=$4

# Run Java program to split the file
java FileSplitter "../../input_files/$input_file" "../../output_files/$output_file1" "../../output_files/$output_file2"

