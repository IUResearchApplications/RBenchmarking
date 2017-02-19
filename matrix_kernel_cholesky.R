cholesky_allocator <- function(runParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- runParameters$dimensions[trialIndex]
   X <- matrix(rnorm(s*s), nrow=s, ncol=s)
   kernelParameters$A <- crossprod(X)
   return (kernelParameters)
}


cholesky_benchmark <- function(runParameters, kernelParameters) {
   timings <- system.time({C <- chol(kernelParameters$A)})
   return (timings)
}
