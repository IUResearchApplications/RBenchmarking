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

devtools::load_all(pkg="RHPCBenchmark", export_all=FALSE)

Sys.setenv(R_BENCH_NUM_THREADS_VARIABLE="MKL_NUM_THREADS")
Sys.setenv(MKL_NUM_THREADS="1")

runIdentifier <- "windows1"
resultsDirectory <- "./windowsSparse"

myMatvec <- SparseMatrixVectorDefaultMicrobenchmarks()

myCholesky <- SparseCholeskyDefaultMicrobenchmarks()
myCholesky <- NULL
#myCholesky[["ct20stif"]]$active <- FALSE
#myCholesky[["Andrews"]]$active <- FALSE
#myCholesky[["G3_circuit"]]$active <- FALSE

myLu <- SparseLuDefaultMicrobenchmarks()
myLu <- NULL
#myLu[["circuit5M_dc"]]$active <- FALSE
#myLu[["stomach"]]$active <- FALSE
#myLu[["torso3"]]$active <- FALSE

myQr <- SparseQrDefaultMicrobenchmarks()
myQr <- NULL
#myQr[["Maragal_6"]]$active <- FALSE
#myQr[["landmark"]]$active <- FALSE

sparseMatrixResults <- SparseMatrixBenchmark(runIdentifier, resultsDirectory,
   matrixVectorMicrobenchmarks=myMatvec, choleskyMicrobenchmarks=myCholesky,
   luMicrobenchmarks=myLu, qrMicrobenchmarks=myQr)
dataFrameFileName <- file.path(resultsDirectory, "sparseMatrixResults.RData")
save(sparseMatrixResults, file=dataFrameFileName)
cat("Warnings (NULL, if none):\n")
warnings()
