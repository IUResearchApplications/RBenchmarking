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
devtools::load_all(pkg="RHPCBenchmarkData", export_all=FALSE)
devtools::load_all(pkg="RHPCBenchmark", export_all=FALSE)


GetSparseMatrixVectorTestMicrobenchmarks <- function() {
   microbenchmarks <- list()
   microbenchmarks[["matvec_laplacian7pt_100"]] <- methods::new(
      "SparseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "matvec_laplacian7pt_100",
      benchmarkDescription = "sparse matrix-vector mult. with 100x100x100 7-point Laplacian operator",
      matrixObjectName = "laplacian7pt_100",
      numberOfRows = as.integer(1000000),
      numberOfColumns = as.integer(1000000),
      numberOfNonzeros = as.integer(6940000),
      numberOfTrials = as.integer(c(2)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = SparseMatrixVectorAllocator,
      benchmarkFunction = SparseMatrixVectorBenchmark
   )

   microbenchmarks[["matvec_laplacian7pt_200"]] <- methods::new(
      "SparseMatrixMicrobenchmark",
      active = FALSE,
      benchmarkName = "matvec_laplacian7pt_200",
      benchmarkDescription = "Sparse matrix-vector mult. with 200x200x200 7-point Laplacian operator",
      matrixObjectName = "laplacian7pt_200",
      numberOfRows = as.integer(8000000),
      numberOfColumns = as.integer(8000000),
      numberOfNonzeros = as.integer(55760000),
      numberOfTrials = as.integer(c(2)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = SparseMatrixVectorAllocator,
      benchmarkFunction = SparseMatrixVectorBenchmark
   )   

   microbenchmarks[["matvec_ca2010"]] <- methods::new(
      "SparseMatrixMicrobenchmark",
      active = FALSE,
      benchmarkName = "matvec_ca2010",
      benchmarkDescription = "Sparse matrix-vector mult. with undirected weighted graph matrix ca2010 from the University of Florida Sparse Matrix Collection DIMACS10 matrix group",
      matrixObjectName = "ca2010",
      numberOfRows = as.integer(710145),
      numberOfColumns = as.integer(710145),
      numberOfNonzeros = as.integer(3489366),
      numberOfTrials = as.integer(c(2)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = SparseMatrixVectorAllocator,
      benchmarkFunction = SparseMatrixVectorBenchmark
   )

   return (microbenchmarks)
}


GetSparseCholeskyTestMicrobenchmarks <- function() {
   microbenchmarks <- list()
   microbenchmarks[["cholesky_ct20stif"]] <- methods::new(
      "SparseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "cholesky_ct20stif",
      benchmarkDescription = "Cholesky factorization of ct20stif matrix from University of Florida Sparse Matrix Collection Boeing group; CT20 engine block structural problem -- stiffness matrix, Boeing",
      matrixObjectName = "ct20stif",
      numberOfRows = as.integer(52329),
      numberOfColumns = as.integer(52329),
      numberOfNonzeros = as.integer(2600295),
      numberOfTrials = as.integer(c(2)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = SparseCholeskyAllocator,
      benchmarkFunction = SparseCholeskyBenchmark
   )

   microbenchmarks[["cholesky_Andrews"]] <- methods::new(
      "SparseMatrixMicrobenchmark",
      active = FALSE,
      benchmarkName = "cholesky_Andrews",
      benchmarkDescription = "Cholesky factorization of Andrews matrix from University of Florida Sparse Matrix Collection Andrews group; Eigenvalue problem from computer vision/graphics, Stuart Andrews, Brown Univ.",
      matrixObjectName = "Andrews",
      numberOfRows = as.integer(60000),
      numberOfColumns = as.integer(60000),
      numberOfNonzeros = as.integer(760154),
      numberOfTrials = as.integer(c(2)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = SparseCholeskyAllocator,
      benchmarkFunction = SparseCholeskyBenchmark
   )

   microbenchmarks[["cholesky_G3_circuit"]] <- methods::new(
      "SparseMatrixMicrobenchmark",
      active = FALSE,
      benchmarkName = "cholesky_G3_circuit",
      benchmarkDescription = "Cholesky factorization of G3_circuit matrix from University of Florida Sparse Matrix Collection AMD group; circuit simulation problem, Ufuk Okuyucu, AMD, Inc.",
      matrixObjectName = "G3_circuit",
      numberOfRows = as.integer(1585478),
      numberOfColumns = as.integer(1585478),
      numberOfNonzeros = as.integer(7660826),
      numberOfTrials = as.integer(c(2)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = SparseCholeskyAllocator,
      benchmarkFunction = SparseCholeskyBenchmark
   )

   return (microbenchmarks)
}


GetSparseLuTestMicrobenchmarks <- function() {
   microbenchmarks <- list()
   microbenchmarks[["lu_circuit5M_dc"]] <- methods::new(
      "SparseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "lu_circuit5M_dc",
      benchmarkDescription = "LU decomposition of circuit5M_dc matrix from University of Florida Sparse Matrix Collection Freescale group; Large circuit (DC analysis) K. Gullapalli, Freescale Semiconductor",
      matrixObjectName = "circuit5M_dc",
      numberOfRows = as.integer(3523317),
      numberOfColumns = as.integer(3523317),
      numberOfNonzeros = as.integer(14865409),
      numberOfTrials = as.integer(c(2)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = SparseLuAllocator,
      benchmarkFunction = SparseLuBenchmark
   )

   microbenchmarks[["lu_stomach"]] <- methods::new(
      "SparseMatrixMicrobenchmark",
      active = FALSE,
      benchmarkName = "lu_stomach",
      benchmarkDescription = "LU decomposition of stomach matrix from University of Florida Sparse Matrix Collection Norris group; S.Norris, Univ. Auckland. 3D electro-physical model of a duodenum",
      matrixObjectName = "stomach",
      numberOfRows = as.integer(213360),
      numberOfColumns = as.integer(213360),
      numberOfNonzeros = as.integer(3021648),
      numberOfTrials = as.integer(c(2)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = SparseLuAllocator,
      benchmarkFunction = SparseLuBenchmark
   )

   microbenchmarks[["lu_torso3"]] <- methods::new(
      "SparseMatrixMicrobenchmark",
      active = FALSE,
      benchmarkName = "lu_torso3",
      benchmarkDescription = "LU decomposition of torso3 matrix from University of Florida Sparse Matrix Collection Norris group; S.Norris, Univ Auckland. finite diff. electro-phys.  3D model of torso",
      matrixObjectName = "torso3",
      numberOfRows = as.integer(259156),
      numberOfColumns = as.integer(259156),
      numberOfNonzeros = as.integer(4429042),
      numberOfTrials = as.integer(c(2)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = SparseLuAllocator,
      benchmarkFunction = SparseLuBenchmark
   )

   return (microbenchmarks)
}


GetSparseQrTestMicrobenchmarks <- function() {
   microbenchmarks <- list()
   microbenchmarks[["qr_Maragal_6"]] <- methods::new(
      "SparseMatrixMicrobenchmark",
      active = TRUE,
      benchmarkName = "qr_Maragal_6",
      benchmarkDescription = "QR factorization of Maragal_6 matrix from University of Florida Sparse Matrix Collection NYPA group; rank deficient least squares problem, D. Maragal, NY Power Authority",
      matrixObjectName = "Maragal_6",
      numberOfRows = as.integer(21255),
      numberOfColumns = as.integer(10152),
      numberOfNonzeros = as.integer(537694),
      numberOfTrials = as.integer(c(2)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = SparseQrAllocator,
      benchmarkFunction = SparseQrBenchmark
   )

   microbenchmarks[["qr_landmark"]] <- methods::new(
      "SparseMatrixMicrobenchmark",
      active = FALSE,
      benchmarkName = "qr_landmark",
      benchmarkDescription = "QR factorization of landmark matrix from University of Florida Sparse Matrix Collection Pereyra group; Matrix from Victor Pereyra, Stanford University",
      matrixObjectName = "landmark",
      numberOfRows = as.integer(71952),
      numberOfColumns = as.integer(2704),
      numberOfNonzeros = as.integer(1146848),
      numberOfTrials = as.integer(c(2)),
      numberOfWarmupTrials = as.integer(c(1)),
      allocatorFunction = SparseQrAllocator,
      benchmarkFunction = SparseQrBenchmark
   )

   return (microbenchmarks)
}


args <- commandArgs(trailingOnly=TRUE)

if (length(args) != 2) {
   write("USAGE: sparse_matrix_driver runIdentifier resultsDirectory", stderr())
   quit(status=1)
}


runIdentifier <- args[1]
resultsDirectory <- args[2]

myMatvec <- GetSparseMatrixVectorTestMicrobenchmarks()

myCholesky <- GetSparseCholeskyTestMicrobenchmarks()

myLu <- GetSparseLuTestMicrobenchmarks()

myQr <- GetSparseQrTestMicrobenchmarks()

sparseMatrixResults <- RunSparseMatrixBenchmark(runIdentifier, resultsDirectory,
   matrixVectorMicrobenchmarks=myMatvec, choleskyMicrobenchmarks=myCholesky,
   luMicrobenchmarks=myLu, qrMicrobenchmarks=myQr)
dataFrameFileName <- file.path(resultsDirectory, "sparseMatrixResults.RData")
save(sparseMatrixResults, file=dataFrameFileName)
cat("Warnings (NULL, if none):\n")
warnings()
