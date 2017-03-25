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

#' Allocates and initializes input to the Cholesky factorization dense matrix
#' kernel
#'
#' \code{CholeskyAllocator} allocates and populates the input to the
#' Cholesky factorization dense matrix kernel for the purposes of conducting a
#' single performance trial with the \code{CholeskyMicrobenchmark} function.
#' The matrices or vectors corresponding to the \code{index} parameter must be
#' allocated, populated and returned in the \code{kernelParameters} list.
#'
#' @param benchmarkParameters an object of type
#'   \code{\link{DenseMatrixMicrobenchmark}} specifying various parameters
#'   needed to generate input to the dense matrix kernel.
#' @param index an integer index indicating the dimensions of the matrix or
#'   vector data to be generated as input to the dense matrix kernel.
#' @return a list containing the matrices or vectors to be input to the
#'   dense matrix kernel for which a single performance trial is to be
#'   conducted.
CholeskyAllocator <- function(benchmarkParameters, index) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensionParameters[index]
   X <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   kernelParameters$A <- crossprod(X)
   return (kernelParameters)
}

#' Conducts a single performance trial with the Cholesky factorization dense
#' matrix kernel
#'
#' \code{CholeskyMicrobenchmark} conducts a single performance trial of the
#' Cholesky factorization dense matrix kernel for the matrix given in the
#' \code{kernelParameters} parameter.  The function times the single function
#' call \code{chol(kernelParameters$A)}.
#'
#' @param benchmarkParameters an object of type
#'   \code{\link{DenseMatrixMicrobenchmark}} specifying various parameters
#'   for microbenchmarking the dense matrix kernel
#' @param kernelParameters a list of matrices or vectors to be used as input to
#'   the dense matrix kernel
#' @return a vector containing the user, system, and elapsed performance
#'   timings in that order
CholeskyMicrobenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({C <- chol(kernelParameters$A)})
   return (timings)
}


#' Allocates and populates input to the matrix cross product dense matrix kernel
#'
#' \code{CrossprodAllocator} allocates and populates the input to the
#' matrix cross product dense matrix kernel for the purposes of conducting a
#' single performance trial with the \code{CrossprodMicrobenchmark} function.
#' The matrices or vectors corresponding to the \code{index} parameter must be
#' allocated, initialized and returned in the \code{kernelParameters} list.
#'
#' @inheritParams CholeskyAllocator
CrossprodAllocator <- function(benchmarkParameters, index) {
   # Create list of kernel parameters
   kernelParameters <- list("A")   
   s <- benchmarkParameters$dimensionParameters[index]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return(kernelParameters)
}

#' Conducts a single performance trial with the matrix cross product dense
#' matrix kernel
#'
#' \code{CrossprodMicrobenchmark} conducts a single performance trial of the
#' matrix cross product dense matrix kernel for the matrix given in the
#' \code{kernelParameters} parameter.  The function times the single function
#' call \code{crossprod(kernelParameters$A)}.
#'
#' @inheritParams CholeskyMicrobenchmark
CrossprodMicrobenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({C <- crossprod(kernelParameters$A)})
}


#' Allocates and populates input to the matrix deformation and transpose dense
#' matrix kernel
#'
#' \code{DeformtransAllocator} allocates and populates the input to the
#' matrix deformation and transpose dense matrix kernel for the purposes of
#' conducting a single performance trial with the
#' \code{DeformtransMicrobenchmark} function.  The matrices or vectors
#' corresponding to the \code{index} parameter must be allocated, initialized
#' and returned in the \code{kernelParameters} list.
#'
#' @inheritParams CholeskyAllocator
DeformtransAllocator <- function(benchmarkParameters, index) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensionParameters[index]

   if (s %% 2 != 0) {
      stop("deformtrans kernel matrix dimension must be a multiple of 2")
   }
      
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

#' Conducts a single performance trial with the matrix deformation and transpose
#' dense matrix kernel
#'
#' \code{DeformtransMicrobenchmark} conducts a single performance trial of the
#' matrix deformation and transpose dense matrix kernel for the matrix given in
#' the \code{kernelParameters} parameter.  The function times the transposition
#' of the input matrix, resizing of the input matrix, and transposition of the
#' resized matrix.
#'
#' @inheritParams CholeskyMicrobenchmark
DeformtransMicrobenchmark <- function(benchmarkParameters, kernelParameters) {
   nr <- nrow(kernelParameters$A)
   nc <- ncol(kernelParameters$A)

   timings <- system.time({
      B <- t(kernelParameters$A);
      dim(B) <- c(nr/2, 2*nc);
      A <- t(B)
   })

   return(timings)
}


#' Allocates and populates input to the matrix determinant dense matrix kernel
#'
#' \code{DeterminantAllocator} allocates and populates the input to the
#' matrix determinant dense matrix kernel for the purposes of conducting a
#' single performance trial with the \code{DeterminantMicrobenchmark} function.
#' The matrices or vectors corresponding to the \code{index} parameter must be
#' allocated, initialized and returned in the \code{kernelParameters} list.
#'
#' @inheritParams CholeskyAllocator
DeterminantAllocator <- function(benchmarkParameters, index) {
  # Create list of kernel parameters
  kernelParameters <- list("A")
  s <- benchmarkParameters$dimensionParameters[index]
  kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
  return (kernelParameters)
}  

#' Conducts a single performance trial with the matrix determinant dense
#' matrix kernel
#'
#' \code{DeterminantMicrobenchmark} conducts a single performance trial of the
#' dense matrix determinant dense matrix kernel for the matrix given in the
#' \code{kernelParameters} parameter.  The function times the single function
#' call \code{determinant(kernelParameters$A)}.
#'
#' @inheritParams CholeskyMicrobenchmark
DeterminantMicrobenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({d <- determinant(kernelParameters$A)})
   return(timings) 
}


#' Allocates and populates input to the matrix eigendecomposition kernel
#'
#' \code{EigenAllocator} allocates and populates the input to the
#' matrix eigendecomposition dense matrix kernel for the purposes of conducting
#' a single performance trial with the \code{EigenMicrobenchmark} function.  The
#' matrices or vectors corresponding to the \code{index} parameter must be
#' allocated, initialized and returned in the \code{kernelParameters} list.
#'
#' @inheritParams CholeskyAllocator
EigenAllocator <- function(benchmarkParameters, index) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensionParameters[index]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

#' Conducts a single performance trial with the matrix eigendecomposition dense
#' matrix kernel
#'
#' \code{EigenMicrobenchmark} conducts a single performance trial of the
#' matrix eigendecomposition dense matrix kernel for the matrix given in the
#' \code{kernelParameters} parameter.  The function times the single function
#' call \code{eigen(kernelParameters$A, symmetric=FALSE, only.values=FALSE)}.
#'
#' @inheritParams CholeskyMicrobenchmark
EigenMicrobenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
         E <- eigen(kernelParameters$A, symmetric=FALSE, only.values=FALSE)
      })
   return (timings)
}


#' Allocates and populates input to the matrix least squares fit dense matrix
#' kernel
#'
#' \code{LsfitAllocator} allocates and populates the input to the
#' matrix least squares fit dense matrix kernel for the purposes of conducting
#" a single performance trial with the \code{LsfitMicrobenchmark} function.  The
#' matrices or vectors corresponding to the \code{index} parameter must be
#' allocated, initialized and returned in the \code{kernelParameters} list.
#'
#' @inheritParams CholeskyAllocator
LsfitAllocator <- function(benchmarkParameters, index) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "b")
   s <- benchmarkParameters$dimensionParameters[index]

   if (s %% 2 != 0) {
      stop("least squares fit kernel matrix dimension must be a multiple of 2")
   }

   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=2*s, ncol=s/2)
   kernelParameters$b <- matrix(RBenchmarkOptions$rnorm(2*s), nrow=2*s, ncol=1)
   return (kernelParameters)
}

#' Conducts a single performance trial with the matrix least squares fit dense
#' matrix kernel
#'
#' \code{LsfitMicrobenchmark} conducts a single performance trial of the
#' matrix least squares fit dense matrix kernel for the matrix given in the
#' \code{kernelParameters} parameter.  The function times the single function
#' call \code{lsfit(kernelParameters$A, kernelParameters$b, intercept=FALSE)}.
#'
#' @inheritParams CholeskyMicrobenchmark
LsfitMicrobenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      x <- stats::lsfit(kernelParameters$A, kernelParameters$b, intercept=FALSE)
   })

   return (timings)
}


#' Allocates and populates input to the matrix-matrix multiplication dense
#' matrix kernel
#'
#' \code{MatmatAllocator} allocates and populates the input to the
#' matrix-matrix multiplication dense matrix kernel for the purposes of
#' conducting a single performance trial with the \code{MatmatMicrobenchmark}
#' function.  The matrices or vectors corresponding to the \code{index}
#' parameter must be allocated, initialized and returned in the
#' \code{kernelParameters} list.
#'
#' @inheritParams CholeskyAllocator
MatmatAllocator <- function(benchmarkParameters, index) {
  # Create list of kernel parameters
  kernelParameters <- list("A", "B")
  s <- benchmarkParameters$dimensionParameters[index]
  kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
  kernelParameters$B <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
  return(kernelParameters)
}

#' Conducts a single performance trial with the matrix-matrix multiplication
#' dense matrix kernel
#'
#' \code{MatmatMicrobenchmark} conducts a single performance trial of the
#' matrix-matrix multiplication dense matrix kernel for the matrix given in the
#' \code{kernelParameters} parameter.  The function times the single function
#' call \code{kernelParameters$A \%*\% kernelParameters$B}.
#'
#' @inheritParams CholeskyMicrobenchmark
MatmatMicrobenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      C <- kernelParameters$A %*% kernelParameters$B
   })
   return (timings)
}


#' Allocates and populates input to the matrix-vector multiplication dense
#' matrix kernel
#'
#' \code{MatvecAllocator} allocates and populates the input to the
#' matrix-vector multiplication dense matrix kernel for the purposes of
#' conducting a single performance trial with the \code{MatvecMicrobenchmark}
#' function.  The matrices or vectors corresponding to the \code{index}
#' parameter must be allocated, initialized and returned in the
#' \code{kernelParameters} list.
#'
#' @inheritParams CholeskyAllocator
MatvecAllocator <- function(benchmarkParameters, index) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "b")
   s <- benchmarkParameters$dimensionParameters[index]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   kernelParameters$b <- matrix(RBenchmarkOptions$rnorm(s), nrow=s, ncol=1)
   return (kernelParameters)      
}

#' Conducts a single performance trial with the matrix-vector multiplication
#' dense matrix kernel
#'
#' \code{MatvecMicrobenchmark} conducts a single performance trial of the
#' matrix-vector multiplication dense matrix kernel for the matrix given in the
#' \code{kernelParameters} parameter.  The function times the single function
#' call \code{kernelParameters$A \%*\% kernelParameters$b}.
#'
#' @inheritParams CholeskyMicrobenchmark
MatvecMicrobenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      C <- kernelParameters$A %*% kernelParameters$b
   })

   return (timings)
}


#' Allocates and populates input to the QR factorization dense matrix kernel
#'
#' \code{QrAllocator} allocates and populates the input to the
#' QR factorization dense matrix kernel for the purposes of
#' conducting a single performance trial with the \code{QrMicrobenchmark}
#' function.  The matrices or vectors corresponding to the \code{index}
#' parameter must be allocated, initialized and returned in the
#' \code{kernelParameters} list.
#'
#' @inheritParams CholeskyAllocator
QrAllocator <- function(benchmarkParameters, index) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensionParameters[index]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

#' Conducts a single performance trial with the QR factorization dense matrix
#' kernel
#'
#' \code{QrMicrobenchmark} conducts a single performance trial of the
#' QR factorization dense matrix kernel for the matrix given in the
#' \code{kernelParameters} parameter.  The function times the single function
#' call \code{qr(kernelParameters$A, LAPACK=TRUE)}.
#'
#' @inheritParams CholeskyMicrobenchmark
QrMicrobenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      qr_result <- qr(kernelParameters$A, LAPACK=TRUE)
   })
   return (timings)
}


#' Allocates and populates input to the dense matrix kernel for computing the
#' solution to a system of linear equations with multiple right-hand sides
#'
#' \code{SolveAllocator} allocates and populates the input to the
#' solve kernel for the purposes of conducting a single performance trial with
#' the \code{QrMicrobenchmark} function.  The matrices or vectors corresponding
#' to the \code{index} parameter must be allocated, initialized and returned in
#' the \code{kernelParameters} list.
#'
#' @inheritParams CholeskyAllocator
SolveAllocator <- function(benchmarkParameters, index) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "B")

   s <- benchmarkParameters$dimensionParameters[index]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   X <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   kernelParameters$B <- kernelParameters$A %*% X
   return(kernelParameters)
}

#' Conducts a single performance trial with the dense matrix kernel for
#' computing the solution to a system of linear equations with multiple
#' right-hand sides
#'
#' \code{SolveMicrobenchmark} conducts a single performance trial of the
#' solve dense matrix kernel for the matrix given in the
#' \code{kernelParameters} parameter.  The function times the single function
#' call \code{solve(kernelParameters$A, kernelParameters$B, LAPACK=TRUE)}.
#'
#' @inheritParams CholeskyMicrobenchmark
SolveMicrobenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({X <- solve(kernelParameters$A, kernelParameters$B)})
   return(timings)
}


#' Allocates and populates input to the singular value decomposition (SVD) dense
#' matrix kernel
#'
#' \code{SvdAllocator} allocates and populates the input to the
#' SVD dense matrix kernel for the purposes of conducting a single performance
#' trial with the \code{SvdMicrobenchmark} function.  The matrices or vectors
#' corresponding to the \code{index} parameter must be allocated, initialized
#' and returned in the \code{kernelParameters} list.
#'
#' @inheritParams CholeskyAllocator
SvdAllocator <- function(benchmarkParameters, index) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensionParameters[index]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

#' Conducts a single performance trial with the singular value decomposition
#' (SVD) dense matrix kernel
#'
#' \code{SvdMicrobenchmark} conducts a single performance trial of the
#' SVD dense matrix kernel for the matrix given in the \code{kernelParameters}
#' parameter.  The function times the single function call
#' \code{svd(kernelParameters$A)}.
#'
#' @inheritParams CholeskyMicrobenchmark
SvdMicrobenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      svd_results <- svd(kernelParameters$A)
   })

   return (timings)
}


#' Allocates and populates input to the matrix transpose dense matrix kernel
#'
#' \code{TransposeAllocator} allocates and populates the input to the
#' transpose dense matrix kernel for the purposes of conducting a single
#' performance trial with the \code{TransposeMicrobenchmark} function.  The
#' matrices or vectors corresponding to the \code{index} parameter must be
#' allocated, initialized and returned in the \code{kernelParameters} list.
#'
#' @inheritParams CholeskyAllocator
TransposeAllocator <- function(benchmarkParameters, index) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensionParameters[index]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

#' Conducts a single performance trial with the matrix transpose dense matrix
#' kernel
#'
#' \code{TransposeMicrobenchmark} conducts a single performance trial of the
#' SVD dense matrix kernel for the matrix given in the \code{kernelParameters}
#' parameter.  The function times the single function call
#' \code{svd(transposeParameters$A)}.
#'
#' @inheritParams CholeskyMicrobenchmark
TransposeMicrobenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      B <- t(kernelParameters$A)
   })

   return (timings)
}
