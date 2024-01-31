#!/bin/bash
#SBATCH --job-name=sam_search
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=8G
#SBATCH --time=12:00:00
#SBATCH --output=java_search-%j.out

cd /projects/cooper_research2/JacobC/DiffGeneAnalysis/VertPistil/Self/

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

cat -s header.txt ALLCleanChrom.txt > final.sam
grep -v '^$' final.sam > final_no_blank_lines.sam

cp final_no_blank_lines.sam /projects/cooper_research2/JacobC/HTSeqCounts/vertcross.sam
cd /projects/cooper_research2/JacobC/HTSeqCounts

source pythonenv/bin/activate

python -m HTSeq.scripts.count -f sam -r pos -s no -i ID -t gene vertcross.sam Sbicolor_454_v3.1.1.gene.gtf > vertcrosscounts.txt
python -m HTSeq.scripts.qa -t sam vertcross.sam

deactivate

