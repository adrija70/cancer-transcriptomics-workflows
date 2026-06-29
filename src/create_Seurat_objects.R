library(Matrix)
library(Seurat)


dataset_dir <- "/mnt/d/Personal Projects/Bioinformatics Projects/Replicating MA Nieto Paper Figures/Snail data/GSE159478"


output_dir <- "results/seurat_objects"

dir.create(output_dir,
           recursive = TRUE,
           showWarnings = FALSE)



read_sample <- function(sample){

  matrix_file <- file.path(
    dataset_dir,
    paste0(sample,"_matrix.mtx"),
    paste0(sample,"_matrix.mtx")
  )

  genes_file <- file.path(
    dataset_dir,
    paste0(sample,"_genes.tsv"),
    paste0(sample,"_genes.tsv")
  )

  barcodes_file <- file.path(
    dataset_dir,
    paste0(sample,"_barcodes.tsv"),
    paste0(sample,"_barcodes.tsv")
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

  counts

}


create_object <- function(sample){

  counts <- read_sample(sample)

  obj <- CreateSeuratObject(

    counts = counts,

    project = sample,

    min.cells = 3,

    min.features = 200

  )

  obj$sample <- sample

  saveRDS(

    obj,

    file.path(

      output_dir,

      paste0(sample,".rds")

    )

  )

  cat(sample,
      "saved.",
      ncol(obj),
      "cells\n")

}

samples <- c(

"GSM4830541_T1",

"GSM4830542_T2",

"GSM4830543_T3",

"GSM4830544_T4"

)

lapply(samples, create_object)

cat("\nFinished creating Seurat objects.\n")