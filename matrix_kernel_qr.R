qr_allocator <- function(runParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- runParameters$dimension[trialIndex]
   kernelParameters$A <- matrix(runParameters$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}


qr_benchmark <- function(runParameters, kernelParameters) {
   timings <- runParameters$timing_function({
      qr_result <- qr(kernelParameters$A, LAPACK=TRUE)
   })
   return (timings)
}
