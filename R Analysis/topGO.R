# Load the topGO library
library(topGO)

# Function to perform differential expression analysis using noiseq
performNoiseqDE <- function(mydata, conditions, outputFileName) {
  # Perform noiseq analysis
  result <- noiseq(mydata, factor = "Tissue", conditions = conditions, k = NULL, norm = "n", pnr = 0.2, nss = 5, v = 0.02, lc = 0, replicates = "no")
  
  # Extract differentially expressed genes
  result.deg <- degenes(result, q = 0.9, M = NULL)
  
  # Write the results to a file
  write.table(result.deg, file = outputFileName, sep = "\t", row.names = TRUE)
}

# Define conditions and filenames for differential expression analysis
conditionsList <- list(
  c("SbiPistil", "SbiSelf"),
  c("SbiPollen", "SbiSelf"),
  c("PluPistil", "PluSelf"),
  c("PluPollen", "PluSelf"),
  c("VertPistil", "VertSelf"),
  c("VertPollen", "VertSelf"),
  c("SbiPistil", "SbixPlu"),
  c("SbiPistil", "SbixVert")
)

outputFileNames <- c(
  "NEWsbipistilvspollenpistilDiffData.txt",
  "NEWsbipollenvspollenpistilDiffData.txt",
  "NEWplupistilvspollenpistilDiffData.txt",
  "NEWplupollenvspollenpistilDiffData.txt",
  "NEWvertpistilvspollenpistilDiffData.txt",
  "NEWvertpollenvspollenpistilDiffData.txt",
  "NEWsbipistilvspluDiffData.txt",
  "NEWsbipistilvsvertDiffData.txt"
)

# Perform differential expression analysis for each condition
for (i in seq_along(conditionsList)) {
  performNoiseqDE(mydata, conditionsList[[i]], outputFileNames[i])
}

# Function to perform topGO analysis
performTopGOAnalysis <- function(degenesResult, geneNames, outputFileName) {
  # Extract relevant gene list
  row_titles <- rownames(degenesResult)
  modified_row_titles <- substr(row_titles, 1, nchar(row_titles) - 5)
  row_titles <- modified_row_titles
  geneList <- factor(as.integer(geneNames %in% row_titles))
  names(geneList) <- geneNames
  
  # Create topGOdata object
  GOdata <- new("topGOdata", ontology = "BP", allGenes = geneList, annot = annFUN.gene2GO, gene2GO = geneID2GO)
  
  # Run Fisher's exact test
  resultFisher <- runTest(GOdata, algorithm = "classic", statistic = "fisher")
  
  # Run KS test
  resultKS <- runTest(GOdata, algorithm = "classic", statistic = "ks")
  resultKS.elim <- runTest(GOdata, algorithm = "elim", statistic = "ks")
  
  # Generate a table of results
  allRes <- GenTable(GOdata, classicFisher = resultFisher, classicKS = resultKS, elimKS = resultKS.elim, orderBy = "classicFisher", ranksOf = "classicFisher", topNodes = 1000)
  
  # Write the results to a file
  write.table(allRes, file = outputFileName, sep = "\t", row.names = FALSE)
}

# Perform topGO analysis for each differential expression result
for (i in seq_along(outputFileNames)) {
  degenesResult <- read.table(outputFileNames[i], header = TRUE, sep = "\t")
  performTopGOAnalysis(degenesResult, geneNames, paste("TopGO_", gsub("DiffData.txt", "", outputFileNames[i]), ".txt", sep = ""))
}
