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
library(devtools)
devtools::load_all("RHPCBenchmark")


GetDenseMatrixTestMicrobenchmarks <- function() {
   microbenchmarks <- list()

   # Define matrix kernel tests here

   # Cholesky factorization
   microbenchmarks[["cholesky"]] <- methods::new(
      "DenseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "cholesky",
      benchmarkDescription = "Dense matrix Cholesky factorization",
      dimensionParameters = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = CholeskyAllocator,
      benchmarkFunction = CholeskyMicrobenchmark
   )

   # matrix cross product
   microbenchmarks[["crossprod"]] <- methods::new(
      "DenseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "crossprod",
      benchmarkDescription = "Dense matrix cross product",
      dimensionParameters = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = CrossprodAllocator,
      benchmarkFunction = CrossprodMicrobenchmark
   )

   # matrix determinant
   microbenchmarks[["determinant"]] <- methods::new(
      "DenseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "determinant",
      benchmarkDescription = "Dense matrix determinant",
      dimensionParameters = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = DeterminantAllocator,
      benchmarkFunction = DeterminantMicrobenchmark
   )

   # eigendecomposition
   microbenchmarks[["eigen"]] <- methods::new(
      "DenseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "eigendecomposition",
      benchmarkDescription = "Dense matrix eigendecomposition",
      dimensionParameters = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = EigenAllocator,
      benchmarkFunction = EigenMicrobenchmark
   )

   # Linear solve with multiple right hand sides
   microbenchmarks[["solve"]] <- methods::new(
      "DenseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "solve",
      benchmarkDescription = "Dense linear solve with multiple r.h.s.",
      dimensionParameters = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = SolveAllocator,
      benchmarkFunction = SolveMicrobenchmark
   )
   
   # Least squares fit
   microbenchmarks[["lsfit"]] <- methods::new(
      "DenseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "lsfit",
      benchmarkDescription = "Dense least squares fit",
      dimensionParameters = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = LsfitAllocator,
      benchmarkFunction = LsfitMicrobenchmark
   )

   # Matrix deformation and transpose
   microbenchmarks[["deformtrans"]] <- methods::new(
      "DenseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "deformtrans",
      benchmarkDescription = "Dense matrix deformation and transpose",
      dimensionParameters = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = DeformtransAllocator,
      benchmarkFunction = DeformtransMicrobenchmark
   )

   # Matrix transpose
   microbenchmarks[["transpose"]] <- methods::new(
      "DenseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "transpose",
      benchmarkDescription = "Dense matrix transpose",
      dimensionParameters = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = TransposeAllocator,
      benchmarkFunction = TransposeMicrobenchmark
   )

   # Matrix-matrix multiplication
   microbenchmarks[["matmat"]] <- methods::new(
      "DenseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "matmat",
      benchmarkDescription = "Dense matrix-matrix multiplication",
      dimensionParameters = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = MatmatAllocator,
      benchmarkFunction = MatmatMicrobenchmark
   )

   # Matrix-vector multiplication
   microbenchmarks[["matvec"]] <- methods::new(
      "DenseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "matvec",
      benchmarkDescription = "Dense matrix-vector multiplication",
      dimensionParameters = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = MatvecAllocator,
      benchmarkFunction = MatvecMicrobenchmark
   )

   # QR decomposition
   microbenchmarks[["qr"]] <- methods::new(
      "DenseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "qr",
      benchmarkDescription = "QR decomposition",
      dimensionParameters = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = QrAllocator,
      benchmarkFunction = QrMicrobenchmark
   )

   # Singular value decomposition
   microbenchmarks[["svd"]] <- methods::new(
      "DenseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "svd",
      benchmarkDescription = "Singular value decomposition",
      dimensionParameters = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = SvdAllocator,
      benchmarkFunction = SvdMicrobenchmark
   )

   return (microbenchmarks)
}


args <- commandArgs(trailingOnly=TRUE)

if (length(args) != 2) {
   write("USAGE: dense_matrix_driver runIdentifier resultsDirectory", stderr())
   quit(status=1)
}

runIdentifier <- args[1]
resultsDirectory <- args[2]

denseMatrixResults <- RunDenseMatrixBenchmark(runIdentifier, resultsDirectory, microbenchmarks=GetDenseMatrixTestMicrobenchmarks())
dataFrameFileName <- file.path(resultsDirectory, "denseMatrixResults.RData")
save(denseMatrixResults, file=dataFrameFileName)

# Display warnings
cat("Warnings (NULL if none):\n")
warnings()
