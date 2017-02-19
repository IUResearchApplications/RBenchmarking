sparse_matrix_benchmark <- function(runIdentifier, matrixDirectory, resultsDirectory, microbenchmarks = sparse_matrix_default_tests()) {

   numberOfThreads <- strtoi(get_configurable_env_parameter("R_BENCH_NUM_THREADS_VARIABLE"))

   # Loop over all sparse matrix-vector multiplication benchmarks

   for (i in 1:length(microbenchmarks)) {
      # The matrices are read in to the global environment so that they only
      # have to be read from storage once.
      matrixFileName <- file.path(matrixDirectory, microbenchmarks[[i]]$matrixFileName)
      load(matrixFileName, envir = .GlobalEnv)
      microbenchmarkValue <- microbenchmark_sparse_matrix_kernel(microbenchmarks[[i]], numberOfThreads, resultsDirectory, runIdentifier)
      remove(list=c(microbenchmarks[[i]]$matrixObjectName), envir = .GlobalEnv)
      invisible(gc())
   }
}


sparse_matrix_vector_allocator <- function(runParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "x")
   kernelParameters$A <- get(runParameters$matrixObjectName)

   # Make sure expected matrix dimensions agree
   if (nrow(kernelParameters$A) != runParameters$numberOfRows[trialIndex]) {
      warning("Actual number of rows in sparse matrix does not match expected number of rows in numberOfRows")
   } else if (ncol(kernelParameters$A) != runParameters$numberOfColumns[trialIndex]) {
      warning("Actual number of columns in sparse matrix does not match expected number of columns in numberOfColumns")
   }

   s <- ncol(kernelParameters$A)
   kernelParameters$x <- matrix(rnorm(s), nrow=s, ncol=1)
   return (kernelParameters)
}


sparse_matrix_vector_benchmark <- function(runParameters, kernelParameters) {
   timings <- system.time({b <- kernelParameters$A %*% kernelParameters$x})
   return (timings)
}


sparse_matrix_default_tests <- function() {
   microbenchmarks <- list()
   microbenchmarks[["laplacian7pt_100"]] <- SparseMatrixBenchmark$new(
      benchmarkName = "Sparse matrix-vector multiplication with 100x100x100 7-point Laplacian operator",
      matrixFileName = "laplacian7pt_100_R",
      csvResultsBaseFileName = "laplacian7pt_100",
      matrixObjectName = "laplacian7pt_100",
      numberOfRows = as.integer(1000000),
      numberOfColumns = as.integer(1000000),
      numberOfTrials = as.integer(c(3)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = sparse_matrix_vector_allocator,
      benchmarkFunction = sparse_matrix_vector_benchmark
   )

   microbenchmarks[["laplacian7pt_200"]] <- SparseMatrixBenchmark$new(
      benchmarkName = "Sparse matrix-vector multiplication with 200x200x200 7-point Laplacian operator",
      matrixFileName = "laplacian7pt_200_R",
      csvResultsBaseFileName = "laplacian7pt_200",
      matrixObjectName = "laplacian7pt_200",
      numberOfRows = as.integer(8000000),
      numberOfColumns = as.integer(8000000),
      numberOfTrials = as.integer(c(3)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = sparse_matrix_vector_allocator,
      benchmarkFunction = sparse_matrix_vector_benchmark
   )   

   microbenchmarks[["ca2010"]] <- SparseMatrixBenchmark$new(
      benchmarkName = "Sparse matrix-vector multiplication with DIMACS10 ca2010 undirected graph matrix",
      matrixFileName = "ca2010_R",
      csvResultsBaseFileName = "ca2010",
      matrixObjectName = "ca2010",
      numberOfRows = as.integer(710145),
      numberOfColumns = as.integer(710145),
      numberOfTrials = as.integer(c(3)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = sparse_matrix_vector_allocator,
      benchmarkFunction = sparse_matrix_vector_benchmark
   )

   return (microbenchmarks)
}
