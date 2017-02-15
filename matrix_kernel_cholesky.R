cholesky_allocator <- function(runParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- runParameters$dimensions[trialIndex]
   X <- matrix(runParameters$rnorm(s*s), nrow=s, ncol=s)
   kernelParameters$A <- crossprod(X)
   return (kernelParameters)
}


cholesky_benchmark <- function(runParameters, kernelParameters) {
   timings <- runParameters$timing_function({C <- chol(kernelParameters$A)})
   return (timings)
}
