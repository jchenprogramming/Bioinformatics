#!/bin/bash

# Loop through each chromosome
for i in "$@"; do
    REF="AChrom${i}.txt"
    DICT="SNPChrom${i}.txt"
    OUTPUT="AFinalChrom${i}.txt"

    # Run Java program using here document
    java SamSearcher2 <<EOF
$REF
$DICT
$OUTPUT
EOF
done
