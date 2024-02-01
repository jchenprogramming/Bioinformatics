# DiffSeqAnalysis

DSA is an assistive bioinformatics tool designed for RNA differential gene expression analyses here at the University of North Carolina Charlotte. With the help of HTSeq/NOISeq/topGO, the program utilizes data from RNA sequencing (SAM), single nucleotide polymorphisms (VCF), and gene features (GTF) to compare expression patterns between crossed species. 

# Features

- Distinguishes organism-specific RNA reads with identifying SNPs
- Counts the number of reads corresponding to a specific gene
- Runs statistical tests for Gene Ontology terms based on count data

# Inputs

For each species:
- RNA sequencing data in reads (SAM files)
- SNP data set with (VCF files)
- Reference gene feature data (GTF files)

# Outputs

For each species:
- New RNA-seq data set with distinguished reads (SAM)
- List of input genes and corresponding read counts
- Data table containing applicable Gene Ontology terms