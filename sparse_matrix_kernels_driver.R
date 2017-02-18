require(Matrix)

source("benchmarking_utils.R")
source("microbenchmark_sparse_matrix_kernel.R")
source("sparse_matrix_kernel_matvec.R")

args <- commandArgs(trailingOnly=TRUE)

if (length(args) != 2) {
   write("ERROR: run identifier and matrix directory must be supplied as command line arguments", stderr())
   quit(status=1)
}

runIdentifier <- args[1]
matrixDirectory <- args[2]
numberOfThreads <- strtoi(get_configurable_env_parameter("R_BENCH_NUM_THREADS_VARIABLE"))

runParameters <- list("benchmarkName", "dimensions", "numberOfTrials", "numberOfWarmupTrials", "rnorm", "timing_function")
runParameters$rnorm <- rnorm
runParameters$timing_function <- system.time

# Sparse matrix kernel tests begin here

# Sparse matrix-vector multiplication with seven-point Laplacian on three-
# dimensional domain of size 100x100x100

matrixFileName <- file.path(matrixDirectory, "laplacian7pt_100_R")
load(matrixFileName)
runParameters$benchmarkName <- "Sparse matrix-vector multiplication with 100x100x100 7-point Laplacian operator"
runParameters$numberOfRows <- c(nrow(laplacian7pt_100))
runParameters$numberOfColumns <- c(ncol(laplacian7pt_100))
runParameters$numberOfTrials <- c(3)
runParameters$numberOfWarmupTrials <- c(1)
csvResultsFile <- sprintf("laplacian7pt_100_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_sparse_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, laplacian7pt_100_allocator, laplacian7pt_100_benchmark)
remove(laplacian7pt_100)
invisible(gc())

# Sparse matrix-vector multiplication with seven-point Laplacian on three-
# dimensional domain of size 200x200x200

matrixFileName <- file.path(matrixDirectory, "laplacian7pt_200_R")
load(matrixFileName)
runParameters$benchmarkName <- "Sparse matrix-vector multiplication with 200x200x200 7-point Laplacian operator"
runParameters$numberOfRows <- c(nrow(laplacian7pt_200))
runParameters$numberOfColumns <- c(ncol(laplacian7pt_200))
runParameters$numberOfTrials <- c(3)
runParameters$numberOfWarmupTrials <- c(1)
csvResultsFile <- sprintf("laplacian7pt_200_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_sparse_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, laplacian7pt_200_allocator, laplacian7pt_200_benchmark)
remove(laplacian7pt_200)
invisible(gc())


# Sparse matrix-vector multiplication with DIMACS10 undirected weighted graph
# of dimension 710145x710145 downloaded from University of Florida Sparse
# Matrix Collection

matrixFileName <- file.path(matrixDirectory, "ca2010_R")
load(matrixFileName)
runParameters$benchmarkName <- "Sparse matrix-vector multiplication with DIMACS10 ca2010 undirected graph matrix"
runParameters$numberOfRows <- c(nrow(ca2010))
runParameters$numberOfColumns <- c(ncol(ca2010))
runParameters$numberOfTrials <- c(3)
runParameters$numberOfWarmupTrials <- c(1)
csvResultsFile <- sprintf("ca2010_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_sparse_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, ca2010_allocator, ca2010_benchmark)
remove(ca2010)
invisible(gc())

