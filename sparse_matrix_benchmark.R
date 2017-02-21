sparse_matrix_benchmark <- function(
   runIdentifier, matrixDirectory, resultsDirectory,
   matrix_vector_tests = sparse_matrix_vector_multiplication_default_tests(),
   cholesky_factorization_tests = sparse_cholesky_factorization_default_tests(),
   lu_factorization_tests = sparse_lu_factorization_default_tests(),
   qr_factorization_tests = sparse_qr_factorization_default_tests()) {

   numberOfThreads <- strtoi(get_configurable_env_parameter("R_BENCH_NUM_THREADS_VARIABLE"))

   # Loop over all sparse matrix-vector multiplication tests

   for (i in 1:length(matrix_vector_tests)) {
      if (matrix_vector_tests[[i]]$active) {
         # The matrices are read in to the global environment so that they only
         # have to be read from storage once.
         matrixFileName <- file.path(matrixDirectory, matrix_vector_tests[[i]]$matrixFileName)
         load(matrixFileName, envir = .GlobalEnv)
         returnValue <- microbenchmark_sparse_matrix_kernel(matrix_vector_tests[[i]], numberOfThreads, resultsDirectory, runIdentifier)
         remove(list=c(matrix_vector_tests[[i]]$matrixObjectName), envir = .GlobalEnv)
         invisible(gc())
      }
   }


   # Loop over all sparse Cholesky factorization tests

   for (i in 1:length(cholesky_factorization_tests)) {
      if (cholesky_factorization_tests[[i]]$active) {
         # The matrices are read in to the global environment so that they only
         # have to be read from storage once.
         matrixFileName <- file.path(matrixDirectory, cholesky_factorization_tests[[i]]$matrixFileName)
         load(matrixFileName, envir = .GlobalEnv)
         returnValue <- microbenchmark_sparse_matrix_kernel(cholesky_factorization_tests[[i]], numberOfThreads, resultsDirectory, runIdentifier)
         remove(list=c(cholesky_factorization_tests[[i]]$matrixObjectName), envir = .GlobalEnv)
         invisible(gc())
      }
   }


   # Loop over all sparse QR factorization tests

   for (i in 1:length(qr_factorization_tests)) {
      if (qr_factorization_tests[[i]]$active) {
         # The matrices are read in to the global environment so that they only
         # have to be read from storage once.
         matrixFileName <- file.path(matrixDirectory, qr_factorization_tests[[i]]$matrixFileName)
         load(matrixFileName, envir = .GlobalEnv)
         returnValue <- microbenchmark_sparse_matrix_kernel(qr_factorization_tests[[i]], numberOfThreads, resultsDirectory, runIdentifier)
         remove(list=c(qr_factorization_tests[[i]]$matrixObjectName), envir = .GlobalEnv)
         invisible(gc())
      }
   }

}


# Sparse matrix-vector multiplication definitions

sparse_matrix_vector_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A", "x")
   kernelParameters$A <- get(benchmarkParameters$matrixObjectName)

   # Make sure expected matrix dimensions agree
   if (nrow(kernelParameters$A) != benchmarkParameters$numberOfRows[trialIndex]) {
      warning("Actual number of rows in sparse matrix does not match expected number of rows in numberOfRows")
   } else if (ncol(kernelParameters$A) != benchmarkParameters$numberOfColumns[trialIndex]) {
      warning("Actual number of columns in sparse matrix does not match expected number of columns in numberOfColumns")
   }

   s <- ncol(kernelParameters$A)
   kernelParameters$x <- matrix(rnorm(s), nrow=s, ncol=1)
   return (kernelParameters)
}

sparse_matrix_vector_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({b <- kernelParameters$A %*% kernelParameters$x})
   return (timings)
}


# Sparse Cholesky factorization definitions

sparse_cholesky_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   kernelParameters$A <- get(benchmarkParameters$matrixObjectName)

   # Make sure expected matrix dimensions agree
   if (nrow(kernelParameters$A) != benchmarkParameters$numberOfRows[trialIndex]) {
      warning("Actual number of rows in sparse matrix does not match expected number of rows in numberOfRows")
   } else if (ncol(kernelParameters$A) != benchmarkParameters$numberOfColumns[trialIndex]) {
      warning("Actual number of columns in sparse matrix does not match expected number of columns in numberOfColumns")
   }

   return (kernelParameters)
}

sparse_cholesky_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({b <- Cholesky(kernelParameters$A)})
   return (timings)
}


# Sparse LU factorization definitions

sparse_lu_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   kernelParameters$A <- get(benchmarkParameters$matrixObjectName)

   # Make sure expected matrix dimensions agree
   if (nrow(kernelParameters$A) != benchmarkParameters$numberOfRows[trialIndex]) {
      warning("Actual number of rows in sparse matrix does not match expected number of rows in numberOfRows")
   } else if (ncol(kernelParameters$A) != benchmarkParameters$numberOfColumns[trialIndex]) {
      warning("Actual number of columns in sparse matrix does not match expected number of columns in numberOfColumns")
   }

   return (kernelParameters)
}

sparse_lu_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({b <- lu(kernelParameters$A)})
   return (timings)
}


# Sparse QR factorization definitions

sparse_qr_allocator <- function(benchmarkParameters, trialIndex) {
   # Create list of kernel parameters
   kernelParameters <- list("A")
   kernelParameters$A <- get(benchmarkParameters$matrixObjectName)

   # Make sure expected matrix dimensions agree
   if (nrow(kernelParameters$A) != benchmarkParameters$numberOfRows[trialIndex]) {
      warning("Actual number of rows in sparse matrix does not match expected number of rows in numberOfRows")
   } else if (ncol(kernelParameters$A) != benchmarkParameters$numberOfColumns[trialIndex]) {
      warning("Actual number of columns in sparse matrix does not match expected number of columns in numberOfColumns")
   }

   return (kernelParameters)
}

sparse_qr_benchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({b <- qr(kernelParameters$A)})
   return (timings)
}



sparse_matrix_vector_multiplication_default_tests <- function() {
   microbenchmarks <- list()
   microbenchmarks[["laplacian7pt_100"]] <- SparseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "sparse matrix-vector mult. with 100x100x100 7-point Laplacian operator",
      description = "Sparse matrix-vector multiplication with 100x100x100 7-point Laplacian operator",
      matrixFileName = "laplacian7pt_100_R",
      csvResultsBaseFileName = "matvec_laplacian7pt_100",
      matrixObjectName = "laplacian7pt_100",
      numberOfRows = as.integer(1000000),
      numberOfColumns = as.integer(1000000),
      numberOfNonzeros = as.integer(6940000),
      numberOfTrials = as.integer(c(3)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = sparse_matrix_vector_allocator,
      benchmarkFunction = sparse_matrix_vector_benchmark
   )

   microbenchmarks[["laplacian7pt_200"]] <- SparseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "sparse matrix-vector mult. with 200x200x200 7-point Laplacian operator",
      description = "Sparse matrix-vector multiplication with 200x200x200 7-point Laplacian operator",
      matrixFileName = "laplacian7pt_200_R",
      csvResultsBaseFileName = "matvec_laplacian7pt_200",
      matrixObjectName = "laplacian7pt_200",
      numberOfRows = as.integer(8000000),
      numberOfColumns = as.integer(8000000),
      numberOfNonzeros = as.integer(55760000),
      numberOfTrials = as.integer(c(3)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = sparse_matrix_vector_allocator,
      benchmarkFunction = sparse_matrix_vector_benchmark
   )   

   microbenchmarks[["ca2010"]] <- SparseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "sparse matrix-vector mult. with DIMACS10/ca2010 undirected graph matrix",
      description = "Sparse matrix-vector mult. with undirected weighted graph matrix ca2010 from the University of Florida Sparse Matrix Collection DIMACS10 matrix group",
      matrixFileName = "ca2010_R",
      csvResultsBaseFileName = "matvec_ca2010",
      matrixObjectName = "ca2010",
      numberOfRows = as.integer(710145),
      numberOfColumns = as.integer(710145),
      numberOfNonzeros = as.integer(3489366),
      numberOfTrials = as.integer(c(3)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = sparse_matrix_vector_allocator,
      benchmarkFunction = sparse_matrix_vector_benchmark
   )

   return (microbenchmarks)
}


sparse_cholesky_factorization_default_tests <- function() {
   microbenchmarks <- list()
   microbenchmarks[["ct20stif"]] <- SparseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "sparse Cholesky factorization of Boeing/ct20stif structural problem matrix",
      description = "Cholesky factorization of ct20stif matrix from University of Florida Sparse Matrix Collection Boeing group; CT20 engine block -- stiffness matrix, Boeing",
      matrixFileName = "ct20stif_R",
      csvResultsBaseFileName = "cholesky_ct20stif",
      matrixObjectName = "ct20stif",
      numberOfRows = as.integer(52329),
      numberOfColumns = as.integer(52329),
      numberOfNonzeros = as.integer(2600295),
      numberOfTrials = as.integer(c(3)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = sparse_cholesky_allocator,
      benchmarkFunction = sparse_cholesky_benchmark
   )

   microbenchmarks[["Andrews"]] <- SparseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "sparse Cholesky factorization of Andrews/Andrews computer graphics vision problem matrix",
      description = "Cholesky factorization of Andrews matrix from University of Florida Sparse Matrix Collection Andrews group; Eigenvalue problem, Stuart Andrews, Brown Univ.",
      matrixFileName = "Andrews_R",
      csvResultsBaseFileName = "cholesky_Andrews",
      matrixObjectName = "Andrews",
      numberOfRows = as.integer(60000),
      numberOfColumns = as.integer(60000),
      numberOfNonzeros = as.integer(760154),
      numberOfTrials = as.integer(c(3)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = sparse_cholesky_allocator,
      benchmarkFunction = sparse_cholesky_benchmark
   )

   microbenchmarks[["G3_circuit"]] <- SparseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "sparse Cholesky factorization of AMD/G3_circuit circuit simulation problem matrix",
      description = "Cholesky factorization of G3_circuit matrix from University of Florida Sparse Matrix Collection AMD group; circuit simulation problem, Ufuk Okuyucu, AMD, Inc.",
      matrixFileName = "G3_circuit_R",
      csvResultsBaseFileName = "cholesky_G3_circuit",
      matrixObjectName = "G3_circuit",
      numberOfRows = as.integer(1585478),
      numberOfColumns = as.integer(1585478),
      numberOfNonzeros = as.integer(7660826),
      numberOfTrials = as.integer(c(3)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = sparse_cholesky_allocator,
      benchmarkFunction = sparse_cholesky_benchmark
   )

   return (microbenchmarks)
}


sparse_lu_factorization_default_tests <- function() {
   microbenchmarks <- list()
   microbenchmarks[["circuit5M_dc"]] <- SparseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "sparse LU decomposition of Freescale/circuit5M_dc circuit simulation problem matrix",
      description = "LU decomposition of circuit5M_dc matrix from University of Florida Sparse Matrix Collection Freescale group; Large circuit (DC analysis) K. Gullapalli, Freescale Semiconductor",
      matrixFileName = "circuit5M_dc_R",
      csvResultsBaseFileName = "lu_circuit5M_dc",
      matrixObjectName = "circuit5M_dc",
      numberOfRows = as.integer(3523317),
      numberOfColumns = as.integer(3523317),
      numberOfNonzeros = as.integer(14865409),
      numberOfTrials = as.integer(c(3)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = sparse_lu_allocator,
      benchmarkFunction = sparse_lu_benchmark
   )

   microbenchmarks[["stomach"]] <- SparseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "sparse LU decomposition of Norris/stomach 2D/3D problem matrix",
      description = "LU decomposition of stomach matrix from University of Florida Sparse Matrix Collection Norris group; S.Norris, Univ. Auckland. 3D electro-physical model of a duodenum",
      matrixFileName = "stomach_R",
      csvResultsBaseFileName = "lu_stomach",
      matrixObjectName = "stomach",
      numberOfRows = as.integer(213360),
      numberOfColumns = as.integer(213360),
      numberOfNonzeros = as.integer(3021648),
      numberOfTrials = as.integer(c(3)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = sparse_lu_allocator,
      benchmarkFunction = sparse_lu_benchmark
   )

   microbenchmarks[["torso3"]] <- SparseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "sparse LU decomposition of Norris/torso3 2D/3D problem matrix",
      description = "LU decomposition of torso3 matrix from University of Florida Sparse Matrix Collection Norris group; S.Norris, Univ Auckland. finite diff. electro-phys.  3D model of torso",
      matrixFileName = "torso3_R",
      csvResultsBaseFileName = "lu_torso3",
      matrixObjectName = "torso3",
      numberOfRows = as.integer(259156),
      numberOfColumns = as.integer(259156),
      numberOfNonzeros = as.integer(4429042),
      numberOfTrials = as.integer(c(3)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = sparse_lu_allocator,
      benchmarkFunction = sparse_lu_benchmark
   )

   return (microbenchmarks)
}


sparse_qr_factorization_default_tests <- function() {
   microbenchmarks <- list()
   microbenchmarks[["Maragal_6"]] <- SparseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "sparse QR factorization of NYPA/Maragal_6 least squares problem matrix",
      description = "QR factorization of Maragal_6 matrix from University of Florida Sparse Matrix Collection NYPA group; rank deficient least squares problem, D. Maragal, NY Power Authority",
      matrixFileName = "Maragal_6",
      csvResultsBaseFileName = "qr_Maragal_6",
      matrixObjectName = "Maragal_6",
      numberOfRows = as.integer(21255),
      numberOfColumns = as.integer(10152),
      numberOfNonzeros = as.integer(537694),
      numberOfTrials = as.integer(c(3)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = sparse_qr_allocator,
      benchmarkFunction = sparse_qr_benchmark
   )

   microbenchmarks[["landmark"]] <- SparseMatrixBenchmark$new(
      active = TRUE,
      benchmarkName = "sparse QR factorization of Pereyra/landmark least squares problem matrix",
      description = "QR factorization of landmark matrix from University of Florida Sparse Matrix Collection Pereyra group; Matrix from Victor Pereyra, Stanford University",
      matrixFileName = "landmark_R",
      csvResultsBaseFileName = "qr_landmark",
      matrixObjectName = "landmark",
      numberOfRows = as.integer(71952),
      numberOfColumns = as.integer(2704),
      numberOfNonzeros = as.integer(1146848),
      numberOfTrials = as.integer(c(3)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = sparse_qr_allocator,
      benchmarkFunction = sparse_qr_benchmark
   )

   return (microbenchmarks)
}
