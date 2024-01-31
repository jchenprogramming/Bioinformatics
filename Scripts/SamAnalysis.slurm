#!/bin/bash
#SBATCH --job-name=sam_search
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=8G
#SBATCH --time=48:00:00
#SBATCH --output=java_search-%j.out

cd /projects/cooper_research2/JacobC/DiffGeneAnalysis/VertPistil/

for i in {1..10}; do
  sbatch ASamRunner.slurm $i
done

for i in {1..10}; do
  sbatch BSamRunner.slurm $i
done

