#!/bin/bash

# Loop through each chromosome
for i in "$@"; do
    REF="BChrom${i}.txt"
    DICT="SNPChrom${i}.txt"
    OUTPUT="BFinalChrom${i}.txt"

    # Run Java program using here document
    java SamSearcher2 <<EOF
$REF
$DICT
$OUTPUT
EOF
done
