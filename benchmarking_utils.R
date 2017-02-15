get_configurable_env_parameter <- function(configurableVariable) {
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


set_configurable_env_parameter <- function(configurableVariable, value) {
   # Get the name of the wanted environment varible from the
   # configurable environment variable.
   envVariable <- Sys.getenv(configurableVariable)

   if (envVariable == "") {
      write(sprintf("ERROR: Configurable environment variable '%s' is undefined", configurableVariable), stderr())
      quit(status=1)
   } else {
      args <- list(value)
      names(args) <- envVariable
      returnValues <- do.call(Sys.setenv, args)

      if (returnValues[1] == FALSE) {
         write(sprintf("ERROR: Environment variable '%s' was not set", envVariable), stderr())
         quit(status=1)
      }
   }
}


read_parameters <- function() {

   # For SLURM:
   # R_BENCH_NUM_THREADS_VARIABLE = MKL_NUM_THREADS
   # R_BENCH_OUTPUT_DIR_VARIABLE = SLURM_SUBMIT_DIR
   # R_BENCH_JOB_DESCRIPTOR_VARIABLE = SLURM_JOB_NAME
   # R_BENCH_TEST_SUITE_ID_VARIABLE = SLURM_JOB_ID

   # For PBS:
   # R_BENCH_NUM_THREADS_VARIABLE = MKL_NUM_THREADS
   # R_BENCH_OUTPUT_DIR_VARIABLE = PBS_O_WORKDIR
   # R_BENCH_JOB_DESCRIPTOR_VARIABLE = PBS_JOBNAME
   # R_BENCH_TEST_SUITE_ID_VARIABLE = PBS_JOBID

   numberOfThreads <- strtoi(get_configurable_env_parameter("R_BENCH_NUM_THREADS_VARIABLE")) 

   if (is.na(numberOfThreads)) {
      write("ERROR: Non-integer number of threads specified in environment", stderr())
      quit(status=1)
   }

   outputDirectoryStr <- get_configurable_env_parameter("R_BENCH_OUTPUT_DIR_VARIABLE")
   jobDescriptorStr <- get_configurable_env_parameter("R_BENCH_JOB_DESCRIPTOR_VARIABLE")
   #test_suite_job_id_str <- get_configurable_env_parameter("R_BENCH_TEST_SUITE_ID_VARIABLE")
   csvResultsFile <- paste(outputDirectoryStr, "/", jobDescriptorStr, ".csv", sep="")

   return (list("numberOfThreads" = numberOfThreads, "csvResultsFile" = csvResultsFile))
}
  

 

#
#setup_runs <- function(dimensions, numberOfTrials, numberOfWarmupTrials, csvResultsFile) {
#   runParameters <- list("numberOfDimension", "maximumNumberOfTrials", "runif", "rnorm")
#   runParameters$numberOfDimensions <- length(dimensions)
#   maxNumberOfTrials <- max(numberOfTrials)
#   
#   if (numberOfSizes != length(numberOfTrials)) {
#      write("ERROR: Length of numberOfTrials and dimensions arrays must be equal", stderr())
#      quit(status=1)
#   }
#
#   if (numberOfDimensions != length(numberOfWarmupTrials)) {
#      write("ERROR: Length of numberOfWarmupTrials and dimensions arrays must be equal", stderr())
#      quit(status=1)
#   }
#
#   times <- rep(0, maximumNumberOfRuns*numberOfDimenions);
#   averages <- rep(0, numberOfDimensions);
#   dim(times) <- c(maximumNumberOfTrials, numberOfDimensions)
#
#   Runif <- runif
#   Rnorm <- rnorm
#
#   if (csv_results_file != "" && !file.exists(csv_results_file)) {
#      cat("Dimension", "Avg. Wall Clock Time", "Number of Threads\n", file=csv_results_file, sep=",", append=FALSE)
#   }
#
#   return (list("num_sizes" = num_sizes, "max_runs" = max_runs, "times" = times, "averages" = averages, "Runif" = Runif, "Rnorm" = Rnorm))
#}


print_results <- function(benchmarkName, numberOfThreads, dimensions, numberOfSuccessfulTrials, trialTimes, averageWallClockTimes, standardDeviations) {
   numberOfDimensions <- length(dimensions)

   cat(  "---------------------------------------------------------------------------------\n")
   cat(sprintf("Timings summary for %s\n", benchmarkName))
   cat(  "---------------------------------------------------------------------------------\n")
   cat(sprintf("numberOfThreads=%s\n", numberOfThreads))
   cat(  "---------------------------------------------------------------------------------\n")
   cat(c("Dimension | Number of | Min Wall     | Max Wall     | Average      | Standard\n"))
   cat(c("          | Trials    | Time         | Time         | Wall Time    | deviation\n"))
   cat(  "---------------------------------------------------------------------------------\n")

   for (i in 1:numberOfDimensions) {
      if (numberOfSuccessfulTrials[i] > 0) {
         cat(sprintf("%-9d   %-9d   %-12.6e   %-12.6e   %-12.6e   %-12.6e\n", dimensions[i], numberOfSuccessfulTrials[i], min(trialTimes[1:numberOfSuccessfulTrials[i], i]), max(trialTimes[1:numberOfSuccessfulTrials[i], i]), averageWallClockTimes[i], standardDeviations[i]))
      }
   }

   cat(  "---------------------------------------------------------------------------------\n")

}


print_results_csv <- function(numberOfThreads, dimension, averageWallClockTime, standardDeviation, csvResultsFile) {
   if (csvResultsFile != "" && !file.exists(csvResultsFile)) {
      cat("Dimension", "Avg. Wall Clock Time", "Std. Dev", "Number of Threads\n", file=csvResultsFile, sep=",", append=FALSE)
   }

   if (csvResultsFile != "") {
      cat(sprintf("%d,%12.6e,%12.6e,%d\n", dimension, averageWallClockTime, standardDeviation, numberOfThreads), file=csvResultsFile, append=TRUE)
   }
}
   

compute_average_time<-function(num_runs, times) {
   return(mean(times[1:num_runs]))
}


compute_standard_deviation<-function(num_runs, times) {
   return(sqrt(var(times[1:num_runs])))
}
