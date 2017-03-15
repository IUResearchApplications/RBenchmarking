################################################################################
# Copyright 2016 Indiana University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

CholeskyAllocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensionParameters[trialIndex]
   X <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   kernelParameters$A <- crossprod(X)
   return (kernelParameters)
}

CholeskyBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({C <- chol(kernelParameters$A)})
   return (timings)
}


CrossprodAllocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")   
   s <- benchmarkParameters$dimensionParameters[trialIndex]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return(kernelParameters)
}

CrossprodBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({C <- crossprod(kernelParameters$A)})
}


DeformtransAllocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensionParameters[trialIndex]

   if (s %% 2 != 0) {
      stop("deformtrans kernel matrix dimension must be a multiple of 2")
   }
      
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

DeformtransBenchmark <- function(benchmarkParameters, kernelParameters) {
   nr <- nrow(kernelParameters$A)
   nc <- ncol(kernelParameters$A)

   timings <- system.time({
      B <- t(kernelParameters$A);
      dim(B) <- c(nr/2, 2*nc);
      A <- t(B)
   })

   return(timings)
}


DeterminantAllocator <- function(benchmarkParameters, trialIndex) {
  # Create list of kernel parameters
  kernelParameters <- list("A")
  s <- benchmarkParameters$dimensionParameters[trialIndex]
  kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
  return (kernelParameters)
}  

DeterminantBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({d <- determinant(kernelParameters$A)})
   return(timings) 
}


EigenAllocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensionParameters[trialIndex]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

EigenBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
         E <- eigen(kernelParameters$A, symmetric=FALSE, only.values=FALSE)
      })
   return (timings)
}


LsfitAllocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "b")
   s <- benchmarkParameters$dimensionParameters[trialIndex]

   if (s %% 2 != 0) {
      stop("least squares fit kernel matrix dimension must be a multiple of 2")
   }

   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=2*s, ncol=s/2)
   kernelParameters$b <- matrix(RBenchmarkOptions$rnorm(2*s), nrow=2*s, ncol=1)
   return (kernelParameters)
}

LsfitBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      x <- lsfit(kernelParameters$A, kernelParameters$b, intercept=FALSE)
   })

   return (timings)
}


MatmatAllocator <- function(benchmarkParameters, trialIndex) {
  # Create list of kernel parameters
  kernelParameters <- list("A", "B")
  s <- benchmarkParameters$dimensionParameters[trialIndex]
  kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
  kernelParameters$B <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
  return(kernelParameters)
}

MatmatBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      C <- kernelParameters$A %*% kernelParameters$B
   })
   return (timings)
}


MatvecAllocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "b")
   s <- benchmarkParameters$dimensionParameters[trialIndex]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   kernelParameters$b <- matrix(RBenchmarkOptions$rnorm(s), nrow=s, ncol=1)
   return (kernelParameters)      
}

MatvecBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      C <- kernelParameters$A %*% kernelParameters$b
   })

   return (timings)
}


QrAllocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensionParameters[trialIndex]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

QrBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      qr_result <- qr(kernelParameters$A, LAPACK=TRUE)
   })
   return (timings)
}


SolveAllocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "B")

   s <- benchmarkParameters$dimensionParameters[trialIndex]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   X <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   kernelParameters$B <- kernelParameters$A %*% X
   return(kernelParameters)
}

SolveBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({X <- solve(kernelParameters$A, kernelParameters$B)})
   return(timings)
}


SvdAllocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensionParameters[trialIndex]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

SvdBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      svd_results <- svd(kernelParameters$A)
   })

   return (timings)
}


TransposeAllocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   s <- benchmarkParameters$dimensionParameters[trialIndex]
   kernelParameters$A <- matrix(RBenchmarkOptions$rnorm(s*s), nrow=s, ncol=s)
   return (kernelParameters)
}

TransposeBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({
      B <- t(kernelParameters$A)
   })

   return (timings)
}
