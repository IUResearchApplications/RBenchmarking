# Sparse matrix-vector multiplication definitions

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
