# Load the NOISeq library
library(NOISeq)

# Read count data from different files
file1 <- read.table("plupistil_counts.txt", header = FALSE, col.names = c("Gene", "Count1"), sep = "\t")
file2 <- read.table("plupollen_counts.txt", header = FALSE, col.names = c("Gene", "Count2"), sep = "\t")
file3 <- read.table("pluselfpollinated_counts.txt", header = FALSE, col.names = c("Gene", "Count3"), sep = "\t")
file4 <- read.table("sbipistil_counts.txt", header = FALSE, col.names = c("Gene", "Count4"), sep = "\t")
file5 <- read.table("sbipistilxplupollen_counts.txt", header = FALSE, col.names = c("Gene", "Count5"), sep = "\t")
file6 <- read.table("sbipistilxvertpollen_counts.txt", header = FALSE, col.names = c("Gene", "Count6"), sep = "\t")
file7 <- read.table("sbipollen_counts.txt", header = FALSE, col.names = c("Gene", "Count7"), sep = "\t")
file8 <- read.table("sbiselfpollinated_counts.txt", header = FALSE, col.names = c("Gene", "Count8"), sep = "\t")
file9 <- read.table("vertpistil_counts.txt", header = FALSE, col.names = c("Gene", "Count9"), sep = "\t")
file10 <- read.table("vertpollen_counts.txt", header = FALSE, col.names = c("Gene", "Count10"), sep = "\t")
file11 <- read.table("vertselfpollinated_counts.txt", header = FALSE, col.names = c("Gene", "Count11"), sep = "\t")

# Merge count data based on the "Gene" column
merged_data <- Reduce(function(x, y) merge(x, y, by = "Gene", all = TRUE), list(file1, file2, file3, file4, file5, file6, file7, file8, file9, file10, file11))
merged_data[is.na(merged_data)] <- 0
write.table(merged_data, file = "merged_output.txt", sep = "\t", row.names = FALSE)

# Read the merged data for further analysis
count_file <- "merged_output.txt"
count_data <- read.table(count_file, header = TRUE, row.names = 1, sep = "\t")

# Define metadata for samples
Tissue <- c(
  "PluPistil", "PluPollen", "PluSelf", "SbiPistil", "SbixPlu", "SbixVert", "SbiPollen", "SbiSelf", "VertPistil", "VertPollen", "VertSelf"
)

Treatment <- c(
  "NA", "NA", "Self", "NA", "Cross", "Cross", "NA", "Self", "NA", "NA", "Self"
)

Female <- c(
  "Plumosum", "NA", "Plumosum", "Sbicolor", "Sbicolor", "Sbicolor", "NA", "Sbicolor", "Verticiliflorum", "NA", "Verticiliflorum"
)

Male <- c(
  "NA", "Plumosum", "Plumosum", "NA", "Plumosum", "Verticiliflorum", "Sbicolor", "Sbicolor", "Verticiliflorum", "NA", "Verticiliflorum"
)

# Create a sample table
sampleTable = data.frame(Tissue = as.factor(Tissue),
                         Treatment = as.factor(Treatment),
                         Female = as.factor(Female),
                         Male = as.factor(Male))

# Create a NOISeq data object
mydata <- readData(data = count_data, factors = sampleTable)

# Perform NOISeq analysis for each condition
NEWsbipistilvspollenpistil <- noiseq(mydata, factor = "Tissue", conditions = c("SbiPistil", "SbiSelf"), k = NULL, norm = "n", replicates = "no")
NEWsbipollenvspollenpistil <- noiseq(mydata, factor = "Tissue", conditions = c("SbiPollen", "SbiSelf"), k = NULL, norm = "n", replicates = "no")
NEWplupistilvspollenpistil <- noiseq(mydata, factor = "Tissue", conditions = c("PluPistil", "PluSelf"), k = NULL, norm = "n", replicates = "no")
NEWplupollenvspollenpistil <- noiseq(mydata, factor = "Tissue", conditions = c("PluPollen", "PluSelf"), k = NULL, norm = "n", replicates = "no")
NEWvertpistilvspollenpistil <- noiseq(mydata, factor = "Tissue", conditions = c("VertPistil", "VertSelf"), k = NULL, norm = "n", replicates = "no")
NEWvertpollenvspollenpistil <- noiseq(mydata, factor = "Tissue", conditions = c("VertPollen", "VertSelf"), k = NULL, norm = "n", replicates = "no")
NEWsbipistilvsplu <- noiseq(mydata, factor = "Tissue", conditions = c("SbiPistil", "SbixPlu"), k = NULL, norm = "n", replicates = "no")
NEWplupollenvscross <- noiseq(mydata, factor = "Tissue", conditions = c("PluPollen", "SbixPlu"), k = NULL, norm = "n", replicates = "no")
NEWsbipistilvsvert <- noiseq(mydata, factor = "Tissue", conditions = c("VertPollen", "SbixVert"), k = NULL, norm = "n", replicates = "no")
NEWvertpollenvscross <- noiseq(mydata, factor = "Tissue", conditions = c("VertPollen", "SbixVert"), k = NULL, norm = "n", replicates = "no")

# Perform differential expression analysis for each condition
sbipistilvspollenpistil.deg = degenes(NEWsbipistilvspollenpistil, q = 0.9, M = NULL)
sbipollenvspollenpistil.deg = degenes(NEWsbipollenvspollenpistil, q = 0.9, M = NULL)
plupistilvspollenpistil.deg = degenes(NEWplupistilvspollenpistil, q = 0.9, M = NULL)
plupollenvspollenpistil.deg = degenes(NEWplupollenvspollenpistil, q = 0.9, M = NULL)
vertpistilvspollenpistil.deg = degenes(NEWvertpistilvspollenpistil, q = 0.9, M = NULL)
vertpollenvspollenpistil.deg = degenes(NEWvertpollenvspollenpistil, q = 0.9, M = NULL)
sbipistilvsplu.deg = degenes(NEWsbipistilvsplu, q = 0.9, M = NULL)
plupollenvscross.deg = degenes(NEWplupollenvscross, q = 0.9, M = NULL)
sbipistilvsvertcross.deg = degenes(NEWsbipistilvsvert, q = 0.9, M = NULL)
vertpollenvscross.deg = degenes(NEWvertpollenvscross, q = 0.9, M = NULL)

# Write the results to files
write.table(sbipistilvspollenpistil.deg, file = "NEWsbipistilvspollenpistilDiffData.txt", sep = "\t", row.names = TRUE)
write.table(sbipollenvspollenpistil.deg, file = "NEWsbipollenvspollenpistilDiffData.txt", sep = "\t", row.names = TRUE)
write.table(plupistilvspollenpistil.deg, file = "NEWplupistilvspollenpistilDiffData.txt", sep = "\t", row.names = TRUE)
write.table(plupollenvspollenpistil.deg, file = "NEWplupollenvspollenpistilDiffData.txt", sep = "\t", row.names = TRUE)
write.table(vertpistilvspollenpistil.deg, file = "NEWvertpistilvspollenpistilDiffData.txt", sep = "\t", row.names = TRUE)
write.table(vertpollenvspollenpistil.deg, file = "NEWvertpollenvspollenpistilDiffData.txt", sep = "\t", row.names = TRUE)
write.table(sbipistilvsplu.deg, file = "NEWsbipistilvspluDiffData.txt", sep = "\t", row.names = TRUE)
write.table(plupollenvscross.deg, file = "NEWplupollenvscrossDiffData.txt", sep = "\t", row.names = TRUE)
write.table(sbipistilvsvertcross.deg, file = "NEWsbipistilvsvertcrossDiffData.txt", sep = "\t", row.names = TRUE)
write.table(vertpollenvscross.deg, file = "NEWvertpollenvscrossDiffData.txt", sep = "\t", row.names = TRUE)
