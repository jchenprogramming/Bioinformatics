#!/bin/bash

gtf_file="$1"
counts_file="$2"

for i in {1..10}; do
  REF="AFinalChrom${i}.txt"
  DICT="ACleanChrom${i}.txt"

  java RemoveDupes <<EOF
$REF
$DICT
EOF
done

for i in {1..10}; do
  REF="BFinalChrom${i}.txt"
  DICT="BCleanChrom${i}.txt"

  java RemoveDupes <<EOF
$REF
$DICT
EOF
done

for ((i=1; i<=10; i++))
do
    file="ACleanChrom${i}.txt"

    if [ -f "$file" ]; then
        head -n -1 "$file" > "AFinalChrom${i}_cut.txt"
    else
        echo "File $file not found."
    fi
done

for ((i=1; i<=10; i++))
do
    file="BCleanChrom${i}.txt"

    if [ -f "$file" ]; then
        head -n -1 "$file" > "BFinalChrom${i}_cut.txt"
    else
        echo "File $file not found."
    fi
done

for i in {1..10}; do
  cat -s "AFinalChrom${i}_cut.txt" "BFinalChrom${i}_cut.txt" > "CleanChrom${i}.txt"
done

cat -s CleanChrom* > ALLCleanChrom.txt

java Header

# Concatenate header.txt and ALLCleanChrom.txt, and remove blank lines from the output file
cat -s header.txt ALLCleanChrom.txt > final.sam
grep -v '^$' final.sam > final_no_blank_lines.sam

# Activate Python virtual environment
source pythonenv/bin/activate

# Run HTSeq count and QA scripts with the specified GTF file
python -m HTSeq.scripts.count -f sam -r pos -s no -i ID -t gene final_no_blank_lines.sam "$gtf_file" > "$counts_file"

# Deactivate the Python virtual environment
deactivate
