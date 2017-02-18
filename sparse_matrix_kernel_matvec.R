laplacian7pt_100_allocator <- function(runParameters, trialIndex) {
   # Create list of kernel parameters
   s <- ncol(laplacian7pt_100)
   kernelParameters <- list("A", "x", "numberOfRows", "numberOfColumns")
   kernelParameters$A <- laplacian7pt_100
   kernelParameters$x <- matrix(rnorm(s), nrow=s, ncol=1)
   kernelParameters$numberOfRows <- nrow(laplacian7pt_100)
   kernelParameters$numberOfColumns <- ncol(laplacian7pt_100)
   return (kernelParameters)
}


laplacian7pt_100_benchmark <- function(runParameters, kernelParameters) {
   timings <- runParameters$timing_function({b <- kernelParameters$A %*% kernelParameters$x})
   return (timings)
}


laplacian7pt_200_allocator <- function(runParameters, trialIndex) {
   # Create list of kernel parameters
   s <- ncol(laplacian7pt_200)
   kernelParameters <- list("A", "x", "numberOfRows", "numberOfColumns")
   kernelParameters$A <- laplacian7pt_200
   kernelParameters$x <- matrix(rnorm(s), nrow=s, ncol=1)
   kernelParameters$numberOfRows <- nrow(laplacian7pt_200)
   kernelParameters$numberOfColumns <- ncol(laplacian7pt_200)
   return (kernelParameters)
}


laplacian7pt_200_benchmark <- function(runParameters, kernelParameters) {
   timings <- runParameters$timing_function({b <- kernelParameters$A %*% kernelParameters$x})
   return (timings)
}


ca2010_allocator <- function(runParameters, trialIndex) {
   # Create list of kernel parameters
   s <- ncol(ca2010)
   kernelParameters <- list("A", "x", "numberOfRows", "numberOfColumns")
   kernelParameters$A <- ca2010
   kernelParameters$x <- matrix(rnorm(s), nrow=s, ncol=1)
   kernelParameters$numberOfRows <- nrow(ca2010)
   kernelParameters$numberOfColumns <- ncol(ca2010)
   return (kernelParameters)
}


ca2010_benchmark <- function(runParameters, kernelParameters) {
   timings <- runParameters$timing_function({b <- kernelParameters$A %*% kernelParameters$x})
   return (timings)
}

