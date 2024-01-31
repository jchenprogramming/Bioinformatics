#!/bin/bash
#SBATCH --job-name=sam_search
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=8G
#SBATCH --time=72:00:00
#SBATCH --output=java_search-%j.out

cd /projects/cooper_research2/JacobC/DiffGeneAnalysis/VertPistil/

i="$1"
REF="AChrom${i}.txt"
DICT="SNPChrom${i}.txt"
OUTPUT="AFinalChrom${i}.txt"

java SamSearcher2 <<EOF
$REF
$DICT
$OUTPUT
EOF
done
