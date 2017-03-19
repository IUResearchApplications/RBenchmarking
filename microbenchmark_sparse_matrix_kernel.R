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

#' Performs microbenchmarking of a sparse matrix linear algebra kernel
#'
#' \code{MicrobenchmarkSparseMatrixKernel} performs microbenchmarking of a
#' sparse matrix linear algebra kernel for several matrix dimensions
#'
#' This function performs microbenchmarking of a sparse matrix linear algebra
#' kernel for several matrix dimensions and a given number of threads.  The
#' kernel to be performance tested, the matrix dimensions to be tested, and
#' other parameters specifying how the kernel is to be benchmarked are given in
#' the input object \code{benchmarkParameters} which is an instance of
#' the class \code{\link{SparseMatrixMicrobenchmark}}.  For each matrix
#' dimension to be tested, the run time performance of the kernel is averaged
#' over multiple runs.  The kernel can be executed with multiple threads if the
#' kernel supports multithreading.  See \code{\link{SparseMatrixMicrobenchmark}}
#' for more details on the benchmarking parameters.
#' 
#' @param numberOfThreads the number of threads the microbenchmark is being
#'   performed with.  The value is for informational purposes only and does not
#'   effect the number threads the kernel is executed with.
#' @param resultsDirectory a character string specifying the directory
#'   where all of the CSV performance results files will be saved
#' @param runIdentifier a character string specifying the suffix to be
#'   appended to the base of the file name of the output CSV format files
MicrobenchmarkSparseMatrixKernel <- function(benchmarkParameters, numberOfThreads, resultsDirectory, runIdentifier) {
   cat(sprintf("Running microbenchmark: %s\n", benchmarkParameters$benchmarkName))
   allocator <- match.fun(benchmarkParameters$allocatorFunction)
   benchmark <- match.fun(benchmarkParameters$benchmarkFunction)

   numberOfRows <- benchmarkParameters$numberOfRows
   numberOfColumns <- benchmarkParameters$numberOfColumns
   numberOfTrials <- benchmarkParameters$numberOfTrials
   numberOfWarmupTrials <- benchmarkParameters$numberOfWarmupTrials
   benchmarkName <- benchmarkParameters$benchmarkName

   if (length(numberOfRows) != length(numberOfTrials)) {
      errorStr <- sprintf("ERROR: Input checking failed for microbenchmark '%s'  -- lengths of numberOfTrials and numberOfRows arrays must be equal", benchmarkParameters$benchmarkName)
      write(errorStr, stderr())
      return(1)
   }

   if (length(numberOfColumns) != length(numberOfTrials)) {
      errorStr <- sprintf("ERROR: Input checking failed for microbenchmark '%s'  -- lengths of numberOfTrials and numberOfColumns arrays must be equal", benchmarkParameters$benchmarkName)
      write(errorStr, stderr())
      return(1)
   }

   if (length(numberOfTrials) != length(numberOfWarmupTrials)) {
      errorStr <- sprintf("ERROR: Input checking failed for microbenchmark '%s' -- lengths of numberOfTrials and numberOfWarmupTrials arrays must be equal", benchmarkParameters$benchmarkName)
      write(errorStr, stderr())
      return(1)
   }
   
   numberOfDimensions <- length(numberOfRows)
   maximumNumberOfTrials <- max(numberOfTrials)
   trialTimes <- rep(0, maximumNumberOfTrials*maximumNumberOfTrials)
   dim(trialTimes) <- c(maximumNumberOfTrials, maximumNumberOfTrials)
   averageWallClockTimes <- rep(0, numberOfDimensions)
   standardDeviations <- rep(0, numberOfDimensions)
   numberOfSuccessfulTrials <- rep(0, numberOfDimensions)

   for (j in 1:numberOfDimensions) {

      for (i in 1:(numberOfTrials[j]+numberOfWarmupTrials[j])) {
         cat(sprintf("Running iteration %d for matrix dimensions %d x %d...", i, numberOfRows[j], numberOfColumns[j]))

         tryCatchResult <- tryCatch({
            allocationSuccessful <- TRUE
            kernelParameters <- allocator(benchmarkParameters, j)
         }, warning = function(war) {
            msg <- sprintf("WARN: allocator threw a warning -- %s", war)
            write(msg, stderr())
         }, error = function(err) {
            allocationSuccessful <- FALSE
            msg <- sprintf("ERROR: allocator threw an error -- %s", err)
            write(msg, stderr())
         })

         if (!allocationSuccessful) {
            break;
         }

         tryCatchResult <- tryCatch({
            benchmarkSuccessful <- TRUE
            timings <- benchmark(benchmarkParameters, kernelParameters)
         }, warning = function(war) {
            msg <- sprintf("WARN: benchmark threw a warning -- %s", war)
            write(msg, stderr())
         }, error = function(err) {
            benchmarkSuccessful <- FALSE
            msg <- sprintf("ERROR: benchmark threw an error -- %s", err)
            write(msg, stderr())
         })
            
         if (!benchmarkSuccessful) {
            break;
         }

         if (i > numberOfWarmupTrials[j]) {
            numberOfSuccessfulTrials[j] <- numberOfSuccessfulTrials[j] + 1 
         }
       
         wallClockTime <- timings[3]

         remove(kernelParameters)
         invisible(gc())

         if (i > numberOfWarmupTrials[j]) {
            trialTimes[i-numberOfWarmupTrials[j], j] <- wallClockTime
         }

         cat(sprintf("done: %f(sec)\n", wallClockTime))
      }

      csvResultsFileName <- file.path(resultsDirectory, paste(benchmarkParameters$csvResultsBaseFileName, "_", runIdentifier, ".csv", sep=""))
      averageWallClockTimes[j] <- ComputeAverageTime(numberOfSuccessfulTrials[j], trialTimes[,j]) 
      standardDeviations[j] <- ComputeStandardDeviation(numberOfSuccessfulTrials[j], trialTimes[,j])
      WriteSparseMatrixPerformanceResultsCsv(numberOfThreads, numberOfRows[j], numberOfColumns[j], averageWallClockTimes[j], standardDeviations[j], csvResultsFileName)
   }

   PrintSparseMatrixMicrobenchmarkResults(benchmarkName, numberOfThreads, numberOfRows, numberOfColumns, numberOfSuccessfulTrials, trialTimes, averageWallClockTimes, standardDeviations)

   return(0)
}
