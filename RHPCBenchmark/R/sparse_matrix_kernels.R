################################################################################
# Copyright 2016 Indiana University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

#' Allocates and initializes input to the matrix-vector multiplication sparse
#' matrix kernel
#'
#' \code{SparseMatrixVectorAllocator} allocates and initializes the sparse
#' matrix and vector that are inputs to the sparse matrix kernel for the
#' purposes of conducting a single performance trial with the
#' \code{SparseMatrixVectorMicrobenchmark} function.  The matrix and vector
#' are populated and returned in the \code{kernelParameters} list.
#'
#' @param benchmarkParameters an object of type
#'   \code{\link{SparseMatrixMicrobenchmark}} specifying various parameters
#'   needed to generate input to the sparse matrix kernel.
#' @param index an integer index indicating the dimensions of the matrix or
#'   vector data to be generated as input to the sparse matrix kernel.
#' @return a list containing the matrices or vectors to be input to the
#'   sparse matrix kernel for which a single performance trial is to be
#'   conducted.
SparseMatrixVectorAllocator <- function(benchmarkParameters, index) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "x")
   kernelParameters$A <- get(benchmarkParameters$matrixObjectName)

   # Make sure expected matrix dimensions agree
   if (nrow(kernelParameters$A) != benchmarkParameters$numberOfRows[index]) {
      warning("Actual number of rows in sparse matrix does not match expected number of rows in numberOfRows")
   } else if (ncol(kernelParameters$A) != benchmarkParameters$numberOfColumns[index]) {
      warning("Actual number of columns in sparse matrix does not match expected number of columns in numberOfColumns")
   }

   s <- ncol(kernelParameters$A)
   kernelParameters$x <- matrix(RBenchmarkOptions$rnorm(s), nrow=s, ncol=1)
   return (kernelParameters)
}

#' Conducts a single performance trial with the matrix-vector multiplication
#' sparse matrix kernel
#'
#' \code{SparseMatrixVectorMicrobenchmark} conducts a single performance trial
#' of the matrix-vector multiplication sparse matrix kernel for the matrix given
#' in the \code{kernelParameters} parameter.  The function times the single
#' function call \code{kernelParameters$A \%*\% kernelParameters$b}.
#'
#' @param benchmarkParameters an object of type
#'   \code{\link{SparseMatrixMicrobenchmark}} specifying various parameters
#'   for microbenchmarking the sparse matrix kernel
#' @param kernelParameters a list of matrices or vectors to be used as input to
#'   the sparse matrix kernel
#' @return a vector containing the user, system, and elapsed performance
#'   timings in that order
SparseMatrixVectorBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({b <- kernelParameters$A %*% kernelParameters$x})
   return (timings)
}


#' Allocates and initializes input to the Cholesky factorization sparse
#' matrix kernel
#'
#' \code{SparseCholeskyAllocator} allocates and initializes the sparse
#' matrix that is input to the sparse matrix kernel for the
#' purposes of conducting a single performance trial with the
#' \code{SparseCholeskyMicrobenchmark} function.  The matrix is populated
#' and returned in the \code{kernelParameters} list.
#'
#' @inheritParams SparseMatrixVectorAllocator
SparseCholeskyAllocator <- function(benchmarkParameters, index) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   kernelParameters$A <- get(benchmarkParameters$matrixObjectName)

   # Make sure expected matrix dimensions agree
   if (nrow(kernelParameters$A) != benchmarkParameters$numberOfRows[index]) {
      warning("Actual number of rows in sparse matrix does not match expected number of rows in numberOfRows")
   } else if (ncol(kernelParameters$A) != benchmarkParameters$numberOfColumns[index]) {
      warning("Actual number of columns in sparse matrix does not match expected number of columns in numberOfColumns")
   }

   return (kernelParameters)
}

#' Conducts a single performance trial with the Cholesky factorization
#' sparse matrix kernel
#'
#' \code{SparseMatrixVectorMicrobenchmark} conducts a single performance trial
#' of the Cholesky factorization sparse matrix kernel for the matrix given in
#' the \code{kernelParameters} parameter.  The function times the single
#' function call \code{kernelParameters$A \%*\% kernelParameters$b}.
#'
#' @param benchmarkParameters an object of type
#'   \code{\link{SparseMatrixMicrobenchmark}} specifying various parameters
#'   for microbenchmarking the sparse matrix kernel
#' @param kernelParameters a list of matrices or vectors to be used as input to
#'   the sparse matrix kernel
#' @return a vector containing the user, system, and elapsed performance
#'   timings in that order
#'
#' @inheritParams SparseMatrixVectorBenchmark
SparseCholeskyBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({b <- Cholesky(kernelParameters$A)})
   return (timings)
}


#' Allocates and initializes input to the LU factorization sparse matrix kernel
#'
#' \code{SparseLuAllocator} allocates and initializes the sparse matrix that is
#' input to the sparse matrix kernel for the purposes of conducting a single
#' performance trial with the \code{SparseCholeskyMicrobenchmark} function.  The
#' matrix is populated and returned in the \code{kernelParameters} list.
#'
#' @inheritParams SparseMatrixVectorAllocator
SparseLuAllocator <- function(benchmarkParameters, index) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   kernelParameters$A <- get(benchmarkParameters$matrixObjectName)

   # Make sure expected matrix dimensions agree
   if (nrow(kernelParameters$A) != benchmarkParameters$numberOfRows[index]) {
      warning("Actual number of rows in sparse matrix does not match expected number of rows in numberOfRows")
   } else if (ncol(kernelParameters$A) != benchmarkParameters$numberOfColumns[index]) {
      warning("Actual number of columns in sparse matrix does not match expected number of columns in numberOfColumns")
   }

   return (kernelParameters)
}

#' Conducts a single performance trial with the LU factorization sparse matrix
#' kernel
#'
#' \code{SparseMatrixVectorMicrobenchmark} conducts a single performance trial
#' of the Cholesky factorization sparse matrix kernel for the matrix given
#' in the \code{kernelParameters} parameter.  The function times the single
#' function
#' call \code{kernelParameters$A \%*\% kernelParameters$b}.
#'
#' @inheritParams SparseMatrixVectorBenchmark
SparseLuBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({b <- lu(kernelParameters$A)})
   return (timings)
}



#' Allocates and initializes input to the QR factorization sparse matrix kernel
#'
#' \code{SparseQrAllocator} allocates and initializes the sparse matrix that is
#' input to the sparse matrix kernel for the purposes of conducting a single
#' performance trial with the \code{SparseQrMicrobenchmark} function.  The
#' matrix is populated and returned in the \code{kernelParameters} list.
#'
#' @inheritParams SparseMatrixVectorAllocator
SparseQrAllocator <- function(benchmarkParameters, index) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   kernelParameters$A <- get(benchmarkParameters$matrixObjectName)

   # Make sure expected matrix dimensions agree
   if (nrow(kernelParameters$A) != benchmarkParameters$numberOfRows[index]) {
      warning("Actual number of rows in sparse matrix does not match expected number of rows in numberOfRows")
   } else if (ncol(kernelParameters$A) != benchmarkParameters$numberOfColumns[index]) {
      warning("Actual number of columns in sparse matrix does not match expected number of columns in numberOfColumns")
   }

   return (kernelParameters)
}

#' Conducts a single performance trial with the QR factorization sparse matrix
#' kernel
#'
#' \code{SparseQrVectorMicrobenchmark} conducts a single performance trial
#' of the QR factorization sparse matrix kernel for the matrix given
#' in the \code{kernelParameters} parameter.  The function times the single
#' function call \code{qr(kernelParameters$A)}.
#'
#' @inheritParams SparseMatrixVectorBenchmark
SparseQrBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({b <- qr(kernelParameters$A)})
   return (timings)
}
