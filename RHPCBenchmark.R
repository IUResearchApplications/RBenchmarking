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
#' @section Top-level benchmark functions:
#' \code{\link{DenseMatrixBenchmark}}
#' \code{\link{SparseMatrixBenchmark}}
#'
#' @docType package
#' @name RHPCBenchmark
NULL
