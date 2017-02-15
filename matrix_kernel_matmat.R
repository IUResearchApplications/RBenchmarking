matmat_allocator <- function(runParameters, trialIndex) {
  # Create list of kernel parameters
  kernelParameters <- list("A", "B")
  s <- runParameters$dimensions[trialIndex]
  kernelParameters$A <- matrix(runParameters$rnorm(s*s), nrow=s, ncol=s)
  kernelParameters$B <- matrix(runParameters$rnorm(s*s), nrow=s, ncol=s)
  return(kernelParameters)
}
      

matmat_benchmark <- function(runParameters, kernelParameters) {
   timings <- runParameters$timing_function({
      C <- kernelParameters$A %*% kernelParameters$B
   })
   return (timings)
}
