require(Matrix)
require(methods)

source("benchmarking_utils.R")
source("microbenchmark_matrix_kernel.R")
source("matrix_kernels_benchmark.R")
source("matrix_kernel.R")

args <- commandArgs(trailingOnly=TRUE)

if (length(args) != 2) {
   write("USAGE: matrix_kernels_driver runIdentifier resultsDirectory", stderr())
   quit(status=1)
}

runIdentifier <- args[1]
resultsDirectory <- args[2]

MatrixKernelBenchmark = setRefClass(
   "MatrixKernelBenchmark",
   fields = list(
      benchmarkName = "character",
      csvResultsBaseFileName = "character",
      dimensions = "integer",
      numberOfTrials = "integer",
      numberOfWarmupTrials = "integer",
      allocatorFunction = "function",
      benchmarkFunction = "function"
   )
)

matrix_kernels_benchmark(runIdentifier, resultsDirectory)
