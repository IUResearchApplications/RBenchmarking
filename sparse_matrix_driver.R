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

require(Matrix)
require(methods)

source("benchmarking_utils.R")
source("microbenchmark_sparse_matrix_kernel.R")
source("sparse_matrix_kernels.R")
source("sparse_matrix_benchmark.R")

args <- commandArgs(trailingOnly=TRUE)

if (length(args) != 3) {
   write("USAGE: sparse_matrix_driver runIdentifier matrixDirectory resultsDirectory", stderr())
   quit(status=1)
}

RBenchmarkOptions <- list()
RBenchmarkOptions$rnorm <- rnorm

runIdentifier <- args[1]
matrixDirectory <- args[2]
resultsDirectory <- args[3]

SparseMatrixBenchmark = methods::setRefClass(
   "SparseMatrixBenchmark",
   fields = list(
      active = "logical",
      benchmarkName = "character",
      description = "character",
      matrixFileName = "character",
      csvResultsBaseFileName = "character",
      matrixObjectName = "character",
      numberOfRows = "integer",
      numberOfColumns = "integer",
      numberOfNonzeros = "integer",
      numberOfTrials = "integer",
      numberOfWarmupTrials = "integer",
      allocatorFunction = "function",
      benchmarkFunction = "function"
   )
)

sparse_matrix_benchmark(runIdentifier, matrixDirectory, resultsDirectory)

