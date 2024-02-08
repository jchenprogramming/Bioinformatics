# DiffSeqAnalysis

DSA is an assistive bioinformatics tool designed for RNA differential gene expression analyses here at the University of North Carolina Charlotte. With the help of HTSeq/NOISeq/topGO, the program utilizes data from RNA sequencing (SAM), single nucleotide polymorphisms (VCF), and gene features (GTF) to compare expression patterns between crossed species. The goal of this tool is to distinguish the activated genes during cross-species breeding and streamline the differences in expressed mechanics.

# Features

- Distinguishes organism-specific RNA reads with identifying SNPs
- Counts the number of reads corresponding to a specific gene
- Runs statistical tests for Gene Ontology terms based on count data

## Inputs

For each species:
- RNA sequencing data in reads (SAM files)
- SNP data set with (VCF files)
- Reference gene feature data (GTF files)

## Outputs

For each species:
- New RNA-seq data set with distinguished reads (SAM)
- List of input genes and corresponding read counts
- Data table containing applicable Gene Ontology terms

## Read Identification Basics

The read identification step of the analysis involves a search algorithm pipeline. Sorted by position, invdividual SNPs are pulled from the VCF file and mapped to the corresponding reads in the SAM file, which are then tagged and added into a new filtered SAM file. This process iterates until all SNPs have been analyzed against all reads. To improve efficiency, computation pathways are initially divided down by chromosome and reassembled on the back end.

![IMG_0184](https://github.com/jchenprogramming/Bioinformatics/assets/157077133/9aa9500f-4037-44d9-8d38-b4179e4ad725)

# Citations

Alexa A, Rahnenfuhrer J (2023). topGO: Enrichment Analysis for Gene Ontology. doi:10.18129/B9.bioc.topGO, R package version 2.54.0, https://bioconductor.org/packages/topGO.

Putri et al. Analysing high-throughput sequencing data in Python with HTSeq 2.0. Bioinformatics, btac166, https://doi.org/10.1093/bioinformatics/btac166 (2022).

Tarazona S, Garcia-Alcalde F, Dopazo J, Ferrer A, Conesa A (2011). “Differential expression in RNA-seq: a matter of depth.” Genome Research, 21(12), 4436.

Tarazona S, Furio-Tari P, Turra D, Pietro AD, Nueda MJ, Ferrer A, Conesa A (2015). “Data quality aware analysis of differential expression in RNA-seq with NOISeq R/Bioc package.” Nucleic Acids Research, 43(21), e140.
