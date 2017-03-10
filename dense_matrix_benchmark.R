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

DenseMatrixBenchmark <- function(runIdentifier, resultsDirectory,
	microbenchmarks = MatrixKernelsDefaultMicrobenchmarks()) {

   numberOfThreads <- strtoi(get_configurable_env_parameter("R_BENCH_NUM_THREADS_VARIABLE"))

   # Loop over all matrix kernel tests

   for (i in 1:length(microbenchmarks)) {
      if (microbenchmarks[[i]]$active) {
         microbenchmarkValue <- MicrobenchmarkMatrixKernel(microbenchmarks[[i]], numberOfThreads, resultsDirectory, runIdentifier)
         invisible(gc())
      }
   }

}


MatrixKernelsDefaultMicrobenchmarks <- function() {
   microbenchmarks <- list()

   # Define matrix kernel tests here

   # Cholesky factorization
   microbenchmarks[["cholesky"]] <- DenseMatrixMicrobenchmark$new(
      active = TRUE,
      benchmarkName = "Cholesky factorization",
      csvResultsBaseFileName = "cholesky",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = CholeskyAllocator,
      benchmarkFunction = CholeskyBenchmark
   )

   # matrix cross product
   microbenchmarks[["crossprod"]] <- DenseMatrixMicrobenchmark$new(
      active = TRUE,
      benchmarkName = "matrix cross product",
      csvResultsBaseFileName = "crossprod",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = CrossprodAllocator,
      benchmarkFunction = CrossprodBenchmark
   )

   # matrix determinant
   microbenchmarks[["determinant"]] <- DenseMatrixMicrobenchmark$new(
      active = TRUE,
      benchmarkName = "matrix determinant",
      csvResultsBaseFileName = "determinant",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = DeterminantAllocator,
      benchmarkFunction = DeterminantBenchmark
   )

   # eigendecomposition
   microbenchmarks[["eigen"]] <- DenseMatrixMicrobenchmark$new(
      active = TRUE,
      benchmarkName = "eigendecomposition",
      csvResultsBaseFileName = "eigendecomposition",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = EigenAllocator,
      benchmarkFunction = EigenBenchmark
   )

   # Linear solve with multiple right hand sides
   microbenchmarks[["solve"]] <- DenseMatrixMicrobenchmark$new(
      active = TRUE,
      benchmarkName = "linear solve with multiple r.h.s.",
      csvResultsBaseFileName = "solve",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = SolveAllocator,
      benchmarkFunction = SolveBenchmark
   )
   
   # Least squares fit with multiple right hand sides
   microbenchmarks[["lsfit"]] <- DenseMatrixMicrobenchmark$new(
      active = TRUE,
      benchmarkName = "least squares fit",
      csvResultsBaseFileName = "lsfit",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = LsfitAllocator,
      benchmarkFunction = LsfitBenchmark
   )

   # Matrix deformation and transpose
   microbenchmarks[["deformtrans"]] <- DenseMatrixMicrobenchmark$new(
      active = TRUE,
      benchmarkName = "matrix deformation and transpose",
      csvResultsBaseFileName = "deformtrans",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = DeformtransAllocator,
      benchmarkFunction = DeformtransBenchmark
   )

   # Matrix-matrix multiplication
   microbenchmarks[["matmat"]] <- DenseMatrixMicrobenchmark$new(
      active = TRUE,
      benchmarkName = "matrix-matrix multiplication",
      csvResultsBaseFileName = "matmat",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = MatmatAllocator,
      benchmarkFunction = MatmatBenchmark
   )

   # Matrix-vector multiplication
   microbenchmarks[["matvec"]] <- DenseMatrixMicrobenchmark$new(
      active = TRUE,
      benchmarkName = "matrix-vector multiplication",
      csvResultsBaseFileName = "matvec",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = MatvecAllocator,
      benchmarkFunction = MatvecBenchmark
   )

   # QR decomposition
   microbenchmarks[["qr"]] <- DenseMatrixMicrobenchmark$new(
      active = TRUE,
      benchmarkName = "QR decomposition",
      csvResultsBaseFileName = "qr",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = QrAllocator,
      benchmarkFunction = QrBenchmark
   )

   # Singular value decomposition
   microbenchmarks[["svd"]] <- DenseMatrixMicrobenchmark$new(
      active = TRUE,
      benchmarkName = "Singular value decomposition",
      csvResultsBaseFileName = "svd",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = SvdAllocator,
      benchmarkFunction = SvdBenchmark
   )

   # Matrix transpose
   microbenchmarks[["transpose"]] <- DenseMatrixMicrobenchmark$new(
      active = TRUE,
      benchmarkName = "matrix transpose",
      csvResultsBaseFileName = "transpose",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = TransposeAllocator,
      benchmarkFunction = TransposeBenchmark
   )

   return (microbenchmarks)
}
