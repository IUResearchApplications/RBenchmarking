solve_allocator <- function(runParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "B")

   s <- runParameters$dimensions[trialIndex]
   kernelParameters$A <- matrix(runParameters$rnorm(s*s), nrow=s, ncol=s)
   X <- matrix(runParameters$rnorm(s*s), nrow=s, ncol=s)
   kernelParameters$B <- kernelParameters$A %*% X
   return(kernelParameters)
}
   

solve_benchmark <- function(runParameters, kernelParameters) {
   timings <- runParameters$timing_function({X <- solve(kernelParameters$A, kernelParameters$B)})
   return(timings)
}
