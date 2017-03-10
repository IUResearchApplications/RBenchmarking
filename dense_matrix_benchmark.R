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

dense_matrix_benchmark <- function(runIdentifier, resultsDirectory, microbenchmarks = matrix_kernels_default_tests()) {

   numberOfThreads <- strtoi(get_configurable_env_parameter("R_BENCH_NUM_THREADS_VARIABLE"))

   # Loop over all matrix kernel tests

   for (i in 1:length(microbenchmarks)) {
      if (microbenchmarks[[i]]$active) {
         microbenchmarkValue <- microbenchmark_matrix_kernel(microbenchmarks[[i]], numberOfThreads, resultsDirectory, runIdentifier)
         invisible(gc())
      }
   }

}


matrix_kernels_default_tests <- function() {
   microbenchmarks <- list()

   # Define matrix kernel tests here

   # Cholesky factorization
   microbenchmarks[["cholesky"]] <- DenseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "Cholesky factorization",
      csvResultsBaseFileName = "cholesky",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = cholesky_allocator,
      benchmarkFunction = cholesky_benchmark
   )

   # matrix cross product
   microbenchmarks[["crossprod"]] <- DenseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "matrix cross product",
      csvResultsBaseFileName = "crossprod",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = crossprod_allocator,
      benchmarkFunction = crossprod_benchmark
   )

   # matrix determinant
   microbenchmarks[["determinant"]] <- DenseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "matrix determinant",
      csvResultsBaseFileName = "determinant",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = determinant_allocator,
      benchmarkFunction = determinant_benchmark
   )

   # eigendecomposition
   microbenchmarks[["eigen"]] <- DenseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "eigendecomposition",
      csvResultsBaseFileName = "eigendecomposition",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = eigen_allocator,
      benchmarkFunction = eigen_benchmark
   )

   # Linear solve with multiple right hand sides
   microbenchmarks[["solve"]] <- DenseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "linear solve with multiple r.h.s.",
      csvResultsBaseFileName = "solve",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = solve_allocator,
      benchmarkFunction = solve_benchmark
   )
   
   # Least squares fit with multiple right hand sides
   microbenchmarks[["lsfit"]] <- DenseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "least squares fit",
      csvResultsBaseFileName = "lsfit",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = lsfit_allocator,
      benchmarkFunction = lsfit_benchmark
   )

   # Matrix deformation and transpose
   microbenchmarks[["deformtrans"]] <- DenseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "matrix deformation and transpose",
      csvResultsBaseFileName = "deformtrans",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = deformtrans_allocator,
      benchmarkFunction = deformtrans_benchmark
   )

   # Matrix-matrix multiplication
   microbenchmarks[["matmat"]] <- DenseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "matrix-matrix multiplication",
      csvResultsBaseFileName = "matmat",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = matmat_allocator,
      benchmarkFunction = matmat_benchmark
   )

   # Matrix-vector multiplication
   microbenchmarks[["matvec"]] <- DenseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "matrix-vector multiplication",
      csvResultsBaseFileName = "matvec",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = matvec_allocator,
      benchmarkFunction = matvec_benchmark
   )

   # QR decomposition
   microbenchmarks[["qr"]] <- DenseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "QR decomposition",
      csvResultsBaseFileName = "qr",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = qr_allocator,
      benchmarkFunction = qr_benchmark
   )

   # Singular value decomposition
   microbenchmarks[["svd"]] <- DenseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "Singular value decomposition",
      csvResultsBaseFileName = "svd",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = svd_allocator,
      benchmarkFunction = svd_benchmark
   )

   # Matrix transpose
   microbenchmarks[["transpose"]] <- DenseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "matrix transpose",
      csvResultsBaseFileName = "transpose",
      dimensions = as.integer(c(1000, 2000)),
      numberOfTrials = as.integer(c(3, 3)),
      numberOfWarmupTrials = as.integer(c(1, 1)),
      allocatorFunction = transpose_allocator,
      benchmarkFunction = transpose_benchmark
   )

   return (microbenchmarks)
}
