cholesky_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensions[trialIndex]
   X <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   kernelParameters$A <- crossprod(X)
   return (kernelParameters)
}

cholesky_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({C <- chol(kernelParameters$A)})
   return (timings)
}


crossprod_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")   
   s <- benchmarkParameters$dimensions[trialIndex]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return(kernelParameters)
}

crossprod_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({C <- crossprod(kernelParameters$A)})
}


deformtrans_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensions[trialIndex]

   if (s %% 2 != 0) {
      stop("deformtrans kernel matrix dimension must be a multiple of 2")
   }
      
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

deformtrans_benchmark <- function(benchmarkParameters, kernelParameters) {
   nr <- nrow(kernelParameters$A)
   nc <- ncol(kernelParameters$A)

   timings <- system.time({
      B <- t(kernelParameters$A);
      dim(B) <- c(nr/2, 2*nc);
      A <- t(B)
   })

   return(timings)
}


determinant_allocator <- function(benchmarkParameters, trialIndex) {
  # Create list of kernel parameters
  kernelParameters <- list("A")
  s <- benchmarkParameters$dimensions[trialIndex]
  kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
  return (kernelParameters)
}  

determinant_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({d <- determinant(kernelParameters$A)})
   return(timings) 
}


eigen_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensions[trialIndex]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

eigen_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
         E <- eigen(kernelParameters$A, symmetric=FALSE, only.values=FALSE)
      })
   return (timings)
}


lsfit_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "b")
   s <- benchmarkParameters$dimensions[trialIndex]

   if (s %% 2 != 0) {
      stop("least squares fit kernel matrix dimension must be a multiple of 2")
   }

   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=2*s, ncol=s/2)
   kernelParameters$b <- matrix(RBenchmarkOptions$rnorm(2*s), nrow=2*s, ncol=1)
   return (kernelParameters)
}

lsfit_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      x <- lsfit(kernelParameters$A, kernelParameters$b, intercept=FALSE)
   })

   return (timings)
}


matmat_allocator <- function(benchmarkParameters, trialIndex) {
  # Create list of kernel parameters
  kernelParameters <- list("A", "B")
  s <- benchmarkParameters$dimensions[trialIndex]
  kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
  kernelParameters$B <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
  return(kernelParameters)
}

matmat_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      C <- kernelParameters$A %*% kernelParameters$B
   })
   return (timings)
}


matvec_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "b")
   s <- benchmarkParameters$dimensions[trialIndex]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   kernelParameters$b <- matrix(RBenchmarkOptions$rnorm(s), nrow=s, ncol=1)
   return (kernelParameters)      
}

matvec_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      C <- kernelParameters$A %*% kernelParameters$b
   })

   return (timings)
}


qr_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensions[trialIndex]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

qr_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      qr_result <- qr(kernelParameters$A, LAPACK=TRUE)
   })
   return (timings)
}


solve_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "B")

   s <- benchmarkParameters$dimensions[trialIndex]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   X <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   kernelParameters$B <- kernelParameters$A %*% X
   return(kernelParameters)
}

solve_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({X <- solve(kernelParameters$A, kernelParameters$B)})
   return(timings)
}


svd_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensions[trialIndex]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

svd_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      svd_results <- svd(kernelParameters$A)
   })

   return (timings)
}


transpose_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensions[trialIndex]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

transpose_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      B <- t(kernelParameters$A)
   })

   return (timings)
}
