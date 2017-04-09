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

#' This class specifies a dense matrix microbenchmark.
#' 
#' @name DenseMatrixMicrobenchmark
#' @field active a logical indicating whether the microbenchmark is to be
#'   executed (TRUE) or not (FALSE)
#' @field benchmarkName a character string that is the name of the
#'   microbenchmark
#' @field benchmarkDescription a character string describing the microbenchmark
#' @field csvResultsBaseFileName a character string that is the base of the file
#'   name the microbenchmark results will be written to
#' @field dimensionParameters an integer vector specifying the dimension
#'   parameters the microbenchmark uses to define the matrix dimensions to be
#'   tested with
#' @field numberOfTrials an integer vector specifying the number of performance
#'   trials conducted for each matrix to be tested.  Must be the same length as
#'   \code{dimensionParameters}.
#' @field numberOfWarmupTrials an integer vector specifying the number of warmup
#'   trials to be performed for each matrix to be tested
#' @field allocatorFunction the function that allocates and initializes input to
#'   the benchmark function
#' @field benchmarkFunction the benchmark function which executes the
#'   functionality to be timed
methods::setRefClass(
   "DenseMatrixMicrobenchmark",
   fields = list(
      active = "logical",
      benchmarkName = "character",
      benchmarkDescription = "character",
      csvResultsBaseFileName = "character",
      dimensionParameters = "integer",
      numberOfTrials = "integer",
      numberOfWarmupTrials = "integer",
      allocatorFunction = "function",
      benchmarkFunction = "function"
   )
)


#' This class specifies a sparse matrix microbenchmark.
#'
#' @name SparseMatrixMicrobenchmark
#' @field active A logical indicating whether the microbenchmark is to be
#'   executed (TRUE) or not (FALSE)
#' @field benchmarkName A character string that is the name of the
#'   microbenchmark
#' @field benchmarkDescription A character string describing the microbenchmark
#' @field matrixFileName A character string specifying the R data file
#'   containing the sparse matrix data
#' @field csvResultsBaseFileName A character string that is the base of the file
#'   name the microbenchmark results will be written to
#' @field matrixObjectName A character string specifying the name of the sparse
#'   matrix object that is input to the benchmark; the object must be stored in
#'   the R data file with name \code{matrixFileName}
#' @field numberOfRows An integer specifying the expected number of rows in the
#'   input sparse matrix
#' @field numberOfColumns An integer specifying the expected number of columns
#'   in the input sparse matrix
#' @field numberOfNonzeros An integer specifying the expected number of nonzeros
#'   in the input sparse matrix
#' @field numberOfTrials An integer vector specifying the number of performance
#'   trials conducted for each matrix to be tested.
#' @field numberOfWarmupTrials An integer vector specifying the number of warmup
#'   trials to be performed for each matrix to be tested
#' @field allocatorFunction The function that allocates and initializes input
#'   to the benchmark function
#' @field benchmarkFunction The benchmark function which executes the
#'   functionality to be timed
methods::setRefClass(
   "SparseMatrixMicrobenchmark",
   fields = list(
      active = "logical",
      benchmarkName = "character",
      benchmarkDescription = "character",
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


#' This class specifies a machine learning microbenchmark.
#'
#' @name MachineLearningMicrobenchmark
#' @field active A logical indicating whether the microbenchmark is to be
#'   executed (TRUE) or not (FALSE)
#' @field benchmarkName A character string that is the name of the
#'   microbenchmark
#' @field benchmarkDescription A character string describing the microbenchmark
#' @field dataFileName A character string specifying the R data file
#'   containing the data set to be performance tested with
#' @field csvResultsBaseFileName A character string that is the base of the file
#'   name the microbenchmark results will be written to
#' @field dataObjectName A character string specifying the name of the data
#'   object that is input to the benchmark; the object must be stored in
#'   the R data file with name \code{dataFileName}
#' @field numberOfTrials An integer specifying the number of performance
#'   trials conducted on the data set to be tested.
#' @field numberOfWarmupTrials An integer specifying the number of warmup
#'   trials to be conducted on the data set
#' @field allocatorFunction The function that allocates and initializes input
#'   to the benchmark function
#' @field benchmarkFunction The benchmark function which executes the
#'   functionality to be timed
methods::setRefClass(
   "MachineLearningMicrobenchmark",
   fields = list(
      active = "logical",
      benchmarkName = "character",
      benchmarkDescription = "character",
      dataFileName = "character",
      csvResultsBaseFileName = "character",
      dataObjectName = "character",
      numberOfTrials = "integer",
      numberOfWarmupTrials = "integer",
      allocatorFunction = "function",
      benchmarkFunction = "function"
   )
)


