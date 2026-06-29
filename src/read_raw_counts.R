library(Matrix)

# Dataset location

dataset_dir <- "/mnt/d/Personal Projects/Bioinformatics Projects/Replicating MA Nieto Paper Figures/Snail data/GSE159478"

# Function to read one sample

read_sample <- function(sample){

  matrix_file <- file.path(
    dataset_dir,
    paste0(sample, "_matrix.mtx"),
    paste0(sample, "_matrix.mtx")
  )

  genes_file <- file.path(
    dataset_dir,
    paste0(sample, "_genes.tsv"),
    paste0(sample, "_genes.tsv")
  )

  barcodes_file <- file.path(
    dataset_dir,
    paste0(sample, "_barcodes.tsv"),
    paste0(sample, "_barcodes.tsv")
  )

  counts <- readMM(matrix_file)

  genes <- read.delim(
    genes_file,
    header = FALSE,
    stringsAsFactors = FALSE
  )

  barcodes <- read.delim(
    barcodes_file,
    header = FALSE,
    stringsAsFactors = FALSE
  )

  rownames(counts) <- genes[,1]
  colnames(counts) <- barcodes[,1]

  return(counts)
}

# Read all samples

T1 <- read_sample("GSM4830541_T1")

T2 <- read_sample("GSM4830542_T2")

T3 <- read_sample("GSM4830543_T3")

T4 <- read_sample("GSM4830544_T4")

# Print dimensions

cat("\n")

cat("T1:", dim(T1), "\n")

cat("T2:", dim(T2), "\n")

cat("T3:", dim(T3), "\n")

cat("T4:", dim(T4), "\n")