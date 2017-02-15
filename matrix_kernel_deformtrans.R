deformtrans_allocator <- function(runParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- runParameters$dimensions[trialIndex]

   if (s %% 2 != 0) {
      stop("deformtrans kernel matrix dimension must be a multiple of 2")
   }
      
   kernelParameters$A <- matrix(runParameters$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}


deformtrans_benchmark <- function(runParameters, kernelParameters) {
   nr <- nrow(kernelParameters$A)
   nc <- ncol(kernelParameters$A)

   timings <- runParameters$timing_function({
      B <- t(kernelParameters$A);
      dim(B) <- c(nr/2, 2*nc);
      A <- t(B)
   })

   return(timings)
}
