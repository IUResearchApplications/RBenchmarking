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

source("./RHPCBenchmark/R/benchmarking_utils.R")
source("./RHPCBenchmark/R/microbenchmark_sparse_matrix_kernel.R")
source("./RHPCBenchmark/R/sparse_matrix_kernels.R")
source("./RHPCBenchmark/R/sparse_matrix_benchmark.R")

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

#' This class specifies a sparse matrix microbenchmark.
#'
#' @name SparseMatrixMicroBenchmark
#' @export
#' @field active A logical indicating whether the microbenchmark is to be
#'   executed (TRUE) or not (FALSE)
#' @field benchmarkName A character string that is the name of the
#'   microbenchmark
#' @field description A character string describing the benchmark
#' @field matrixFileName A character string specifying the R data file
#'   containing the sparse matrix data
#' @field csvResultsBaseFileName A character string that is the base of the file
#'   name to contain the microbenchmark results
#' @field matrixObjectName A character string specifying the name of the sparse
#'   matrix object that is input to the benchmark; the object must be stored in
#'   the R data file with name \code{matrixFileName}
#' @field numberOfRows An integer specifying the expected number of rows in the
#'   input sparse matrix
#' @field numberOfColumns An integer specifying the expected number of columns
#'   in the input sparse matrix
#' @field numberOfNonzeros An integer specifying the expected number of nonzeros
#'   in the input sparse matrix
#' @field numberOfTrials An integer vector specifying the number of trials
#'   conducted for each matrix to be tested. Must be the same length as
#'   \code{diensions}.
#' @field numberOfWarmupTrials An integer vector specifying the number of warmup
#'   trials to be performed for each matrix to be tested
#' @field allocatorFunction The function that allocates and initializes input
#'   to the benchmark function
#' @field benchmarkFunction The benchmark function which executes the
#'   functionality to be timed
SparseMatrixMicrobenchmark = methods::setRefClass(
   "SparseMatrixMicrobenchmark",
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


SparseMatrixBenchmark(runIdentifier, matrixDirectory, resultsDirectory)

