matvec_allocator <- function(runParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "b")
   s <- runParameters$dimension[trialIndex]
   kernelParameters$A <- matrix(runParameters$rnorm(s*s), nrow=s, ncol=s)
   kernelParameters$b <- matrix(runParameters$rnorm(s), nrow=s, ncol=1)
   return (kernelParameters)      
}


matvec_benchmark <- function(runParameters, kernelParameters) {
   timings <- runParameters$timing_function({
      C <- kernelParameters$A %*% kernelParameters$b
   })

   return (timings)
}
