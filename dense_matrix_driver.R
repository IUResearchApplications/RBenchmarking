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
   write("USAGE: dense_matrix_driver runIdentifier resultsDirectory", stderr())
   quit(status=1)
}


RBenchmarkOptions <- list()
RBenchmarkOptions$rnorm <- rnorm

runIdentifier <- args[1]
resultsDirectory <- args[2]

#' This class specifies a dense matrix microbenchmark.
#' 
#' @name DenseMatrixMicroBenchmark
#' @export
#' @field active a logical indicating whether the microbenchmark is to be
#'   executed (TRUE) or not (FALSE)
#' @field benchmarkName a character string that is the name of the
#'   microbenchmark
#' @field csvResultsBaseFileName a character string that is the base of the file
#'   name to contain the microbenchmark results
#' @field dimensionParameters an integer vector specifying the dimension
#'   parameters the microbenchmark uses to define the matrix dimensions to be
#'   tested with
#' @field numberOfTrials an integer vector specifying the number of trials
#'   conducted for each matrix to be tested.  Must be the same length as
#'   \code{dimensionParameters}.
#' @field numberOfWarmupTrials an integer vector specifying the number of warmup
#'   trials to be performed for each matrix to be tested
#' @field allocatorFunction the function that allocates and initializes input to
#'   the benchmark function
#' @field benchmarkFunction the benchmark function which executes the
#'   functionality to be timed
DenseMatrixMicrobenchmark = methods::setRefClass(
   "DenseMatrixMicrobenchmark",
   fields = list(
      active = "logical",
      benchmarkName = "character",
      csvResultsBaseFileName = "character",
      dimensionParameters = "integer",
      numberOfTrials = "integer",
      numberOfWarmupTrials = "integer",
      allocatorFunction = "function",
      benchmarkFunction = "function"
   )
)


DenseMatrixBenchmark(runIdentifier, resultsDirectory)
