#!/bin/bash
#SBATCH --job-name=sam_search
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=8G
#SBATCH --time=48:00:00
#SBATCH --output=java_search-%j.out

cd /projects/cooper_research2/JacobC/DiffGeneAnalysis/VertPistil/

module load samtools
samtools view -h -o vertpistil.sam 15.rg.iap.sorted.bam

javac ChromSplitter
java SamSplitter

for i in {1..10}; do
    sbatch SplitChrom.slurm "Chrom${i}.txt" "AChrom${i}.txt" "BChrom${i}.txt"
done
