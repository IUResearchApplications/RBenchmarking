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
source("microbenchmark_matrix_kernel.R")
source("dense_matrix_kernels.R")
source("dense_matrix_benchmark.R")

args <- commandArgs(trailingOnly=TRUE)

if (length(args) != 2) {
   write("USAGE: matrix_kernels_driver runIdentifier resultsDirectory", stderr())
   quit(status=1)
}

RBenchmarkOptions <- list()
RBenchmarkOptions$rnorm <- rnorm

runIdentifier <- args[1]
resultsDirectory <- args[2]

DenseMatrixMicrobenchmark = methods::setRefClass(
   "DenseMatrixBenchmark",
   fields = list(
      active = "logical",
      benchmarkName = "character",
      csvResultsBaseFileName = "character",
      dimensions = "integer",
      numberOfTrials = "integer",
      numberOfWarmupTrials = "integer",
      allocatorFunction = "function",
      benchmarkFunction = "function"
   )
)

DenseMatrixBenchmark(runIdentifier, resultsDirectory)
