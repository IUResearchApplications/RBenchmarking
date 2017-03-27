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

GetConfigurableEnvParameter <- function(configurableVariable) {
   # Get the name of the wanted environment varible from the
   # configurable environment variable.
   envVariable <- Sys.getenv(configurableVariable)

   if (envVariable == "") {
      write(sprintf("ERROR: Configurable environment variable '%s' is undefined", configurableVariable), stderr())
      quit(status=1)
   } else {
      value <- Sys.getenv(envVariable)

      if (value == "") {
         write(sprintf("ERROR: Environment variable '%s' is undefined", envVariable), stderr())
         quit(status=1)
      }
   }

   return(value)
}


#set_configurable_env_parameter <- function(configurableVariable, value) {
#   # Set the name of an environment varible through a reference to a
#   # configurable environment variable.
#   envVariable <- Sys.getenv(configurableVariable)
#
#   if (envVariable == "") {
#      write(sprintf("ERROR: Configurable environment variable '%s' is undefined", configurableVariable), stderr())
#      quit(status=1)
#   } else {
#      args <- list(value)
#      names(args) <- envVariable
#      returnValues <- do.call(Sys.setenv, args)
#
#      if (returnValues[1] == FALSE) {
#         write(sprintf("ERROR: Environment variable '%s' was not set", envVariable), stderr())
#         quit(status=1)
#      }
#   }
#}


#read_parameters <- function() {
#
#   # For SLURM:
#   # R_BENCH_NUM_THREADS_VARIABLE = MKL_NUM_THREADS
#   # R_BENCH_OUTPUT_DIR_VARIABLE = SLURM_SUBMIT_DIR
#   # R_BENCH_JOB_DESCRIPTOR_VARIABLE = SLURM_JOB_NAME
#   # R_BENCH_TEST_SUITE_ID_VARIABLE = SLURM_JOB_ID
#
#   # For PBS:
#   # R_BENCH_NUM_THREADS_VARIABLE = MKL_NUM_THREADS
#   # R_BENCH_OUTPUT_DIR_VARIABLE = PBS_O_WORKDIR
#   # R_BENCH_JOB_DESCRIPTOR_VARIABLE = PBS_JOBNAME
#   # R_BENCH_TEST_SUITE_ID_VARIABLE = PBS_JOBID
#
#   numberOfThreads <- strtoi(get_configurable_env_parameter("R_BENCH_NUM_THREADS_VARIABLE")) 
#
#   if (is.na(numberOfThreads)) {
#      write("ERROR: Non-integer number of threads specified in environment", stderr())
#      quit(status=1)
#   }
#
#   outputDirectoryStr <- get_configurable_env_parameter("R_BENCH_OUTPUT_DIR_VARIABLE")
#   jobDescriptorStr <- get_configurable_env_parameter("R_BENCH_JOB_DESCRIPTOR_VARIABLE")
#   #test_suite_job_id_str <- get_configurable_env_parameter("R_BENCH_TEST_SUITE_ID_VARIABLE")
#   csvResultsFile <- paste(outputDirectoryStr, "/", jobDescriptorStr, ".csv", sep="")
#
#   return (list("numberOfThreads" = numberOfThreads, "csvResultsFile" = csvResultsFile))
#}
  

#' Prints results of a dense matrix microbenchmark 
#'
#' \code{PrintDenseMatrixMicrobenchmarkResults} prints performance results for a
#' dense matrix microbenchmark to standard output in a format that is easily
#' human readable
#' 
#' This function prints the performance results obtained by a dense matrix
#' microbenchmark for matrices of various dimensions.  The results include
#' summary statistics for each matrix tested.  The summary statistics
#' include the minimum, maximum, average, and standard deviation of the wall
#' clock times obtained by the performance trials with respect to each matrix
#' tested.
#'
#' @param benchmarkName character string specifying the name of the
#'   microbenchmark
#' @param numberOfThreads the number of threads all of the performance trials
#'   were conducted with
#' @param dimensionParameters an integer vector specifying the dimension
#'   parameters the microbenchmark uses to define the matrix dimensions to be
#'   tested with; length is assumed to be greater than zero
#' @param numberOfSuccessfulTrials an integer vector specifying the number of
#'   performance trials that were successfully performed for each matrix tested
#' @param trialTimes a real matrix with each column containing the run times
#'   of all of the successful performance trials associated with a particular
#'   matrix.  The number of valid entries in each column are specified by the
#'   entries in the \code{numberOfSuccessfulTrials} vector
#' @param averageWallClockTimes a vector of average wall clock times computed
#'   for each matrix tested during the performance trials
#' @param standardDeviations a vector of standard deviations of the wall clock
#'   times obtained for each matrix tested during the performance trials
PrintDenseMatrixMicrobenchmarkResults <- function(benchmarkName,
      numberOfThreads, dimensionParameters, numberOfSuccessfulTrials,
      trialTimes, averageWallClockTimes, standardDeviations) {
   numberOfDimensions <- length(dimensionParameters)

   cat(  "---------------------------------------------------------------------------------\n")
   cat(sprintf("Timings summary for benchmark%s\n", benchmarkName))
   cat(  "---------------------------------------------------------------------------------\n")
   cat(sprintf("numberOfThreads=%s\n", numberOfThreads))
   cat(  "---------------------------------------------------------------------------------\n")
   cat(c("N | Number of | Min Wall     | Max Wall     | Average      | Standard\n"))
   cat(c("          | Trials    | Time         | Time         | Wall Time    | deviation\n"))
   cat(  "---------------------------------------------------------------------------------\n")

   for (i in 1:numberOfDimensions) {
      if (numberOfSuccessfulTrials[i] > 0) {
         cat(sprintf("%-9d   %-9d   %-12.6e   %-12.6e   %-12.6e   %-12.6e\n", dimensionParameters[i], numberOfSuccessfulTrials[i], min(trialTimes[1:numberOfSuccessfulTrials[i], i]), max(trialTimes[1:numberOfSuccessfulTrials[i], i]), averageWallClockTimes[i], standardDeviations[i]))
      } else {
         cat("There were no successful performance trials for this microbenchmark.\n")
         cat("Please look for warnings or errors prior to this report.\n")
      }
   }

   cat(  "---------------------------------------------------------------------------------\n\n")

}


#' Prints results of a sparse matrix microbenchmark 
#'
#' \code{PrintSparseMatrixMicrobenchmarkResults} prints performance results for
#' a sparse matrix microbenchmark to standard output in a format that is easily
#' human readable
#' 
#' This function prints the performance results obtained by a sparse matrix
#' microbenchmark for matrices of various dimensions.  The results include
#' summary statistics for each matrix tested.  The summary statistics
#' include the minimum, maximum, average, and standard deviation of the wall
#' clock times obtained by the performance trials with respect to each matrix
#' tested.
#'
#' @param benchmarkName character string specifying the name of the
#'   microbenchmark
#' @param numberOfThreads the number of threads all of the performance trials
#'   were conducted with
#' @param numberOfRows the number of expected rows in the matrix; assumed to
#'   be greater than zero
#' @param numberOfColumns the number of expected columns in the matrix; assumed
#'   to be greater than zero
#' @param numberOfSuccessfulTrials an integer vector specifying the number of
#'   performance trials that were successfully performed for each matrix tested
#' @param trialTimes a real matrix with each column containing the run times
#'   of all of the successful performance trials associated with a particular
#'   matrix.  The number of valid entries in each column are specified by the
#'   entries in the \code{numberOfSuccessfulTrials} vector
#' @param averageWallClockTimes a vector of average wall clock times computed
#'   for each matrix tested during the performance trials
#' @param standardDeviations a vector of standard deviations of the wall clock
#'   times obtained for each matrix tested during the performance trials
PrintSparseMatrixMicrobenchmarkResults <- function(benchmarkName,
     numberOfThreads, numberOfRows, numberOfColumns, numberOfSuccessfulTrials,
     trialTimes, averageWallClockTimes, standardDeviations) {

   cat(  "------------------------------------------------------------------------------------------------\n")
   cat(sprintf("Timings summary for %s\n", benchmarkName))
   cat(  "------------------------------------------------------------------------------------------------\n")
   cat(sprintf("numberOfThreads=%s\n", numberOfThreads))
   cat(  "------------------------------------------------------------------------------------------------\n")
   cat(c("Number of | Number of | Number of    | Min Wall     | Max Wall     | Average      | Standard\n"))
   cat(c("Rows      | Columns   | Trials       | Time         | Time         | Wall Time    | deviation\n"))
   cat(  "------------------------------------------------------------------------------------------------\n")

   for (i in 1:length(numberOfRows)) {
      if (numberOfSuccessfulTrials[i] > 0) {
         cat(sprintf("%-9d   %-9d   %-12d   %-12.6e   %-12.6e   %-12.6e   %-12.6e\n", numberOfRows, numberOfColumns, numberOfSuccessfulTrials[i], min(trialTimes[1:numberOfSuccessfulTrials[i], i]), max(trialTimes[1:numberOfSuccessfulTrials[i], i]), averageWallClockTimes[i], standardDeviations[i]))
      } else {
         cat("There were no successful performance trials for this microbenchmark.\n")
         cat("Please look for warnings or errors prior to this report.\n")
      }
   }

   cat(  "------------------------------------------------------------------------------------------------\n\n")
}


#' Appends dense matrix performance test results to a file in CSV format
#'
#' \code{WriteDenseMatrixPerformanceResultsCsv} appends performance results
#' for a single dense matrix performance test to a CSV file
#' 
#' This function appends the performance results obtained by a single dense
#' matrix performance test conducted for a specific microbenchmark and matrix.
#' Thede for the matrix tested.  If the CSV file does not exist, header
#' information is printed on the first line to describe the subsequent entries.
#' Each entry consists of the dimension parameter used to specify the dimensions
#' of the matrix, the average of the wall clock times obtained for the
#' performance trials, the standard deviation of the performance trial wall
#' clock times, and the number of threads the performance trials conducted with.
#'
#' @param numberOfThreads the number of threads all of the performance trials
#'   were conducted with
#' @param dimensionParameter an integer vector specifying the dimension
#'   parameter the microbenchmark uses to define the dimension of the test
#'   matrix
#' @param averageWallClockTime average wall clock time computed for the matrix
#'   tested during the performance trials
#' @param standardDeviation standard deviation of the wall clock times obtained
#'   for the performance trials
#' @param csvResultsFile the CSV results file the performance result will be
#'   appended to
WriteDenseMatrixPerformanceResultsCsv <- function(numberOfThreads,
      dimensionParameter, averageWallClockTime, standardDeviation,
      csvResultsFile) {
   if (csvResultsFile != "" && !file.exists(csvResultsFile)) {
      cat("Dimension", "Avg. Wall Clock Time", "Std. Dev", "Number of Threads\n", file=csvResultsFile, sep=",", append=FALSE)
   }

   if (csvResultsFile != "") {
      cat(sprintf("%d,%12.6e,%12.6e,%d\n", dimensionParameter, averageWallClockTime, standardDeviation, numberOfThreads), file=csvResultsFile, append=TRUE)
   }
}


#' Appends sparse matrix performance test results to a file in CSV format
#'
#' \code{WriteSparseMatrixPerformanceResultsCsv} appends performance results
#' for a single sparse matrix performance test to a CSV file.
#' 
#' This function appends the performance results obtained by a single sparse
#' matrix performance test conducted for a specific microbenchmark and matrix.
#' If the CSV file does not exist, header information is printed on the first
#' line to describe the subsequent entries.  Each entry consists of the
#' dimension parameter used to specify the dimensions of the matrix, the
#' average of the wall clock times obtained for the performance trials, the
#' standard deviation of the performance trial wall clock times, and the number
#' of threads the performance trials conducted with.
#'
#' @param numberOfThreads the number of threads all of the performance trials
#'   were conducted with
#' @param numberOfRows the number of rows in the matrix
#' @param numberOfColumns the number of columns in the matrix
#' @param averageWallClockTime average wall clock time computed for the matrix
#'   tested during the performance trials
#' @param standardDeviation standard deviation of the wall clock times obtained
#'   for the performance trials
#' @param csvResultsFile the CSV results file the performance result will be
#'   appended to
WriteSparseMatrixPerformanceResultsCsv <- function(numberOfThreads, numberOfRows, numberOfColumns, averageWallClockTime, standardDeviation, csvResultsFile) {
   if (csvResultsFile != "" && !file.exists(csvResultsFile)) {
      cat("Num. Rows", "Num. Cols", "Avg. Wall Clock Time", "Std. Dev", "Number of Threads\n", file=csvResultsFile, sep=",", append=FALSE)
   }

   if (csvResultsFile != "") {
      cat(sprintf("%d,%d,%12.6e,%12.6e,%d\n", numberOfRows, numberOfColumns, averageWallClockTime, standardDeviation, numberOfThreads), file=csvResultsFile, append=TRUE)
   }
}
   

#' Computes the average of a vector of performance trial times
#'
#' \code{ComputeAverageTime} computes the average of a vector of performance
#'   trial times.  The average is computed only over the first
#'   \code{numberOfSuccessfulTrials} elements of the \code{times} vector.
#'
#' @param numberOfSuccessfulTrials the number of successful performance trials
#'   to be averaged over 
#' @param times a vector of wall clock times for the performance trials
ComputeAverageTime<-function(numberOfSuccessfulTrials, times) {
   return(mean(times[1:numberOfSuccessfulTrials]))
}


#' Computes the standard deviation of a vector of performance trial times
#'
#' \code{ComputeStandardDeviation} computes the standard deviation of a vector
#'   of performance trial times.  The standard deviation is computed only over
#'   the first \code{numberOfSuccessfulTrials} elements of the \code{times}
#'   vector.
#'
#' @param numberOfSuccessfulTrials the number of successful performance trials
#'   over which the standard deviation will be computed
#' @param times a vector of wall clock times for the performance trials
ComputeStandardDeviation<-function(numberOfSuccessfulTrials, times) {
   return(sqrt(stats::var(times[1:numberOfSuccessfulTrials])))
}
