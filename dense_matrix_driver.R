require(Matrix)
require(methods)

source("benchmarking_utils.R")
source("microbenchmark_matrix_kernel.R")
source("dense_matrix_kernels.R")
source("dense_matrix_benchmark.R")

args <- commandArgs(trailingOnly=TRUE)

if (length(args) != 2) {
   write("USAGE: matrix_kernels_driver runIdentifier resultsDirectory", stderr())
   quit(status=1)
}

RBenchmarkOptions <- list()
RBenchmarkOptions$rnorm <- rnorm

runIdentifier <- args[1]
resultsDirectory <- args[2]

DenseMatrixBenchmark = setRefClass(
   "DenseMatrixBenchmark",
   fields = list(
      active = "logical",
      benchmarkName = "character",
      csvResultsBaseFileName = "character",
      dimensions = "integer",
      numberOfTrials = "integer",
      numberOfWarmupTrials = "integer",
      allocatorFunction = "function",
      benchmarkFunction = "function"
   )
)

dense_matrix_benchmark(runIdentifier, resultsDirectory)
