transpose_allocator <- function(runParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- runParameters$dimension[trialIndex]
   kernelParameters$A <- matrix(runParameters$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

transpose_benchmark <- function(runParameters, kernelParameters) {
   timings <- runParameters$timing_function({
      B <- t(kernelParameters$A)
   })

   return (timings)
}
