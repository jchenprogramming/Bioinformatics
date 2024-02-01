#!/bin/bash

# Loop through each chromosome
for i in "$@"; do
    REF="../../output_files/BChrom${i}.txt"
    DICT="../../output_files/SNPChrom${i}.txt"
    OUTPUT="../../output_files/BFinalChrom${i}.txt"

    # Run Java program using here document
    java SamSearcher2 <<EOF
$REF
$DICT
$OUTPUT
EOF
done
