
dataset_dir <- "/mnt/d/Personal Projects/Bioinformatics Projects/Replicating MA Nieto Paper Figures/Snail data/GSE159478"



if (!dir.exists(dataset_dir)) {
  stop("Dataset directory not found.")
}


cat("Dataset directory found.\n")




files <- list.files(
  dataset_dir,
  recursive = TRUE,
  full.names = TRUE
)

cat("Number of entries found:", length(files), "\n\n")

print(files)



cat("File types present\n")


extensions <- tools::file_ext(files)

print(table(extensions))

cat("\nInspection complete.\n")