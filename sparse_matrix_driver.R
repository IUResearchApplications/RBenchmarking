require(Matrix)
require(methods)

source("benchmarking_utils.R")
source("sparse_matrix_benchmark.R")
source("microbenchmark_sparse_matrix_kernel.R")

args <- commandArgs(trailingOnly=TRUE)

if (length(args) != 3) {
   write("USAGE: sparse_matrix_driver runIdentifier matrixDirectory resultsDirectory", stderr())
   quit(status=1)
}

runIdentifier <- args[1]
matrixDirectory <- args[2]
resultsDirectory <- args[3]

SparseMatrixBenchmark = setRefClass(
   "SparseMatrixBenchmark",
   fields = list(
      benchmarkName = "character",
      matrixFileName = "character",
      csvResultsBaseFileName = "character",
      matrixObjectName = "character",
      numberOfRows = "integer",
      numberOfColumns = "integer",
      numberOfTrials = "integer",
      numberOfWarmupTrials = "integer",
      allocatorFunction = "function",
      benchmarkFunction = "function"
   )
)

sparse_matrix_benchmark(runIdentifier, matrixDirectory, resultsDirectory)

