#' RHPCBenchmark: A package for performance testing R functionality and common
#' packages relevant to high-performance computing
#'
#' The benchmarking is divided into two categories: dense matrix linear algebra
#' kernels and sparse matrix linear algebra kernels.  The HPC benchmark
#' performs microbenchmarking of compute-intensive linear algebra kernels
#' that can utilize optimized linear algebra libraries.  All of the dense linear
#' algebra kernels are implemented around BLAS or LAPACK interfaces.  The
#' sparse linear algebra kernels are members of the R Matrix library.
#'
#' For fast performance of the dense matrix kernels, it is crucial to link
#' the R programming environment with optimized BLAS and LAPACK libraries.
#' It is also important to have substantial amounts of memory (16GB minimum)
#' to run most of the microbenchmarks.  If any of the microbenchmarks fails
#' to run in a timely manner or fails due to memory constraints, the matrix
#' sizes and number of performance trials per matrix can be adjusted; see
#' the documentation for top-level benchmark functions and the microbenchmark
#' definition classes listed below for information on how to configure the
#' individual microbenchmarks.
#'
#' @section Top-level benchmark functions:
#' \describe{
#'    \item{\code{\link{DenseMatrixBenchmark}}}{Executes the dense matrix microbenchmarks}
#'    \item{\code{\link{SparseMatrixBenchmark}}}{Executes the sparse matrix microbenchmarks}
#' }
#'
#' @section Microbenchmark definition classes:
#' \describe{
#'    \item{\code{\link{DenseMatrixMicrobenchmark}}}{Specifies a dense matrix microbenchmark}
#'    \item{\code{\link{SparseMatrixMicrobenchmark}}}{Specifies a sparse matrix microbenchmark}
#' }
#' @docType package
#' @name RHPCBenchmark
NULL
