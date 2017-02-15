lsfit_allocator <- function(runParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "b")
   s <- runParameters$dimensions[trialIndex]

   if (s %% 2 != 0) {
      stop("least squares fit kernel matrix dimension must be a multiple of 2")
   }

   kernelParameters$A <- matrix(runParameters$rnorm(s*s), nrow=2*s, ncol=s/2)
   kernelParameters$b <- matrix(runParameters$rnorm(2*s), nrow=2*s, ncol=1)
   return (kernelParameters)
}


lsfit_benchmark <- function(runParameters, kernelParameters) {
   timings <- runParameters$timing_function({
      x <- lsfit(kernelParameters$A, kernelParameters$b, intercept=FALSE)
   })

   return (timings)
}
