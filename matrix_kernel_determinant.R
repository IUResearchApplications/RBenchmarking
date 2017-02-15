determinant_allocator <- function(runParameters, trialIndex) {
  # Create list of kernel parameters
  kernelParameters <- list("A")
  s <- runParameters$dimensions[trialIndex]
  kernelParameters$A <- matrix(runParameters$rnorm(s*s), nrow=s, ncol=s)
  return (kernelParameters)
}  


determinant_benchmark <- function(runParameters, kernelParameters) {
   timings <- runParameters$timing_function({d <- determinant(kernelParameters$A)})
   return(timings) 
}


