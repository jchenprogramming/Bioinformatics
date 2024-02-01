#!/bin/bash

gtf_file="$1"
counts_file="$2"

for i in {1..10}; do
  REF="../../output_files/AFinalChrom${i}.txt"
  DICT="../../output_files/ACleanChrom${i}.txt"

  java RemoveDupes <<EOF
$REF
$DICT
EOF
done

for i in {1..10}; do
  REF="../../output_files/BFinalChrom${i}.txt"
  DICT="../../output_files/BCleanChrom${i}.txt"

  java RemoveDupes <<EOF
$REF
$DICT
EOF
done

for ((i=1; i<=10; i++))
do
    file="../../output_files/ACleanChrom${i}.txt"

    if [ -f "$file" ]; then
        head -n -1 "$file" > "../../output_files/AFinalChrom${i}_cut.txt"
    else
        echo "File $file not found."
    fi
done

for ((i=1; i<=10; i++))
do
    file="../../output_files/BCleanChrom${i}.txt"

    if [ -f "$file" ]; then
        head -n -1 "$file" > "../../output_files/BFinalChrom${i}_cut.txt"
    else
        echo "File $file not found."
    fi
done

for i in {1..10}; do
  cat -s "../../output_files/AFinalChrom${i}_cut.txt" "../../output_files/BFinalChrom${i}_cut.txt" > "../../output_files/CleanChrom${i}.txt"
done

cat -s ../../output_files/CleanChrom* > ../../output_files/ALLCleanChrom.txt

java Header

# Concatenate header.txt and ALLCleanChrom.txt, and remove blank lines from the output file
cat -s header.txt ../../output_files/ALLCleanChrom.txt > ../../output_files/final.sam
grep -v '^$' ../../output_files/final.sam > ../../output_files/final_no_blank_lines.sam

# Activate Python virtual environment
source pythonenv/bin/activate

# Run HTSeq count and QA scripts with the specified GTF file
python -m HTSeq.scripts.count -f sam -r pos -s no -i ID -t gene final_no_blank_lines.sam "$gtf_file" > "$counts_file"

# Deactivate the Python virtual environment
deactivate
