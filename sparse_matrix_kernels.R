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

sparse_matrix_vector_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "x")
   kernelParameters$A <- get(benchmarkParameters$matrixObjectName)

   # Make sure expected matrix dimensions agree
   if (nrow(kernelParameters$A) != benchmarkParameters$numberOfRows[trialIndex]) {
      warning("Actual number of rows in sparse matrix does not match expected number of rows in numberOfRows")
   } else if (ncol(kernelParameters$A) != benchmarkParameters$numberOfColumns[trialIndex]) {
      warning("Actual number of columns in sparse matrix does not match expected number of columns in numberOfColumns")
   }

   s <- ncol(kernelParameters$A)
   kernelParameters$x <- matrix(RBenchmarkOptions$rnorm(s), nrow=s, ncol=1)
   return (kernelParameters)
}

sparse_matrix_vector_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({b <- kernelParameters$A %*% kernelParameters$x})
   return (timings)
}


# Sparse Cholesky factorization definitions

sparse_cholesky_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   kernelParameters$A <- get(benchmarkParameters$matrixObjectName)

   # Make sure expected matrix dimensions agree
   if (nrow(kernelParameters$A) != benchmarkParameters$numberOfRows[trialIndex]) {
      warning("Actual number of rows in sparse matrix does not match expected number of rows in numberOfRows")
   } else if (ncol(kernelParameters$A) != benchmarkParameters$numberOfColumns[trialIndex]) {
      warning("Actual number of columns in sparse matrix does not match expected number of columns in numberOfColumns")
   }

   return (kernelParameters)
}

sparse_cholesky_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({b <- Cholesky(kernelParameters$A)})
   return (timings)
}


# Sparse LU factorization definitions

sparse_lu_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   kernelParameters$A <- get(benchmarkParameters$matrixObjectName)

   # Make sure expected matrix dimensions agree
   if (nrow(kernelParameters$A) != benchmarkParameters$numberOfRows[trialIndex]) {
      warning("Actual number of rows in sparse matrix does not match expected number of rows in numberOfRows")
   } else if (ncol(kernelParameters$A) != benchmarkParameters$numberOfColumns[trialIndex]) {
      warning("Actual number of columns in sparse matrix does not match expected number of columns in numberOfColumns")
   }

   return (kernelParameters)
}

sparse_lu_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({b <- lu(kernelParameters$A)})
   return (timings)
}


# Sparse QR factorization definitions

sparse_qr_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   kernelParameters$A <- get(benchmarkParameters$matrixObjectName)

   # Make sure expected matrix dimensions agree
   if (nrow(kernelParameters$A) != benchmarkParameters$numberOfRows[trialIndex]) {
      warning("Actual number of rows in sparse matrix does not match expected number of rows in numberOfRows")
   } else if (ncol(kernelParameters$A) != benchmarkParameters$numberOfColumns[trialIndex]) {
      warning("Actual number of columns in sparse matrix does not match expected number of columns in numberOfColumns")
   }

   return (kernelParameters)
}

sparse_qr_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({b <- qr(kernelParameters$A)})
   return (timings)
}
