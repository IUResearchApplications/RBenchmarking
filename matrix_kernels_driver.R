require(Matrix)

source("benchmarking_utils.R")
source("microbenchmark_matrix_kernel.R")
source("matrix_kernel_cholesky.R")
source("matrix_kernel_crossprod.R")
source("matrix_kernel_determinant.R")
source("matrix_kernel_eigen.R")
source("matrix_kernel_lsfit.R")
source("matrix_kernel_solve.R")
source("matrix_kernel_deformtrans.R")
source("matrix_kernel_matmat.R")
source("matrix_kernel_matvec.R")
source("matrix_kernel_qr.R")
source("matrix_kernel_svd.R")
source("matrix_kernel_transpose.R")

args <- commandArgs(trailingOnly=TRUE)

if (length(args) != 1) {
   write("ERROR: run identifier must be supplied as a command line argument", stderr())
   quit(status=1)
}

runIdentifier <- args[1]
numberOfThreads <- strtoi(get_configurable_env_parameter("R_BENCH_NUM_THREADS_VARIABLE"))

runParameters <- list("benchmarkName", "dimensions", "numberOfTrials", "numberOfWarmupTrials")
runParameters$rnorm <- rnorm
runParameters$timing_function <- system.time

# Matrix kernel tests begin here

# Cholesky factorization
runParameters$benchmarkName <- "Cholesky factorization"
runParameters$dimensions <- c(1000, 2000)
runParameters$numberOfTrials <- c(3, 3)
runParameters$numberOfWarmupTrials <- c(1, 1)
csvResultsFile <- sprintf("cholesky_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, cholesky_allocator, cholesky_benchmark)

# Matrix cross product
runParameters$benchmarkName <- "matrix cross product"
runParameters$dimensions <- c(1000, 2000)
runParameters$numberOfTrials <- c(3, 3)
runParameters$numberOfWarmupTrials <- c(1, 1)
csvResultsFile <- sprintf("crossprod_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, crossprod_allocator, crossprod_benchmark)

# Matrix determinant
runParameters$benchmarkName <- "matrix determinant"
runParameters$dimensions <- c(1000, 2000)
runParameters$numberOfTrials <- c(3, 3)
runParameters$numberOfWarmupTrials <- c(1, 1)
csvResultsFile <- sprintf("determinant_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, determinant_allocator, determinant_benchmark)

# Matrix determinant
runParameters$benchmarkName <- "eigendecomposition"
runParameters$dimensions <- c(1000, 2000)
runParameters$numberOfTrials <- c(3, 3)
runParameters$numberOfWarmupTrials <- c(1, 1)
csvResultsFile <- sprintf("eigen_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, eigen_allocator, eigen_benchmark)

# Linear solve with multiple right hand sides
runParameters$benchmarkName <- "linear solve with multiple r.h.s"
runParameters$dimensions <- c(1000, 2000)
runParameters$numberOfTrials <- c(3, 3)
runParameters$numberOfWarmupTrials <- c(1, 1)
csvResultsFile <- sprintf("solve_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, solve_allocator, solve_benchmark)

# Least squares fit with multiple right hand sides
runParameters$benchmarkName <- "least squares fit"
runParameters$dimensions <- c(1000, 2000)
runParameters$numberOfTrials <- c(3, 3)
runParameters$numberOfWarmupTrials <- c(1, 1)
csvResultsFile <- sprintf("lsfit_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, lsfit_allocator, lsfit_benchmark)

# Matrix deformation and transpose
runParameters$benchmarkName <- "matrix deformation and transpose"
runParameters$dimensions <- c(1000, 2000)
runParameters$numberOfTrials <- c(3, 3)
runParameters$numberOfWarmupTrials <- c(1, 1)
csvResultsFile <- sprintf("deformtrans_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, deformtrans_allocator, deformtrans_benchmark)

# Matrix-matrix multiplication
runParameters$benchmarkName <- "matrix-matrix multiplication"
runParameters$dimensions <- c(1000, 2000)
runParameters$numberOfTrials <- c(3, 3)
runParameters$numberOfWarmupTrials <- c(1, 1)
csvResultsFile <- sprintf("matmat_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, matmat_allocator, matmat_benchmark)

# Matrix-vector multiplication
runParameters$benchmarkName <- "matrix-vector multiplication"
runParameters$dimensions <- c(1000, 2000)
runParameters$numberOfTrials <- c(3, 3)
runParameters$numberOfWarmupTrials <- c(1, 1)
csvResultsFile <- sprintf("matvec_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, matvec_allocator, matvec_benchmark)

# QR decomposition
runParameters$benchmarkName <- "QR decomposition"
runParameters$dimensions <- c(1000, 2000)
runParameters$numberOfTrials <- c(3, 3)
runParameters$numberOfWarmupTrials <- c(1, 1)
csvResultsFile <- sprintf("qr_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, qr_allocator, qr_benchmark)

# SVD decomposition
runParameters$benchmarkName <- "SVD decomposition"
runParameters$dimensions <- c(1000, 2000)
runParameters$numberOfTrials <- c(3, 3)
runParameters$numberOfWarmupTrials <- c(1, 1)
csvResultsFile <- sprintf("svd_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, svd_allocator, svd_benchmark)

# Matrix transpose
runParameters$benchmarkName <- "matrix transpose"
runParameters$dimensions <- c(1000, 2000)
runParameters$numberOfTrials <- c(3, 3)
runParameters$numberOfWarmupTrials <- c(1, 1)
csvResultsFile <- sprintf("transpose_%s.csv", runIdentifier)

microbenchmarkValue <- microbenchmark_matrix_kernel(runParameters, numberOfThreads, csvResultsFile, transpose_allocator, transpose_benchmark)

