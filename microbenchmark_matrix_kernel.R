microbenchmark_matrix_kernel <- function(benchmarkParameters, numberOfThreads, resultsDirectory, runIdentifier) {
   cat(sprintf("Running microbenchmark: %s\n", benchmarkParameters$benchmarkName))
   allocator <- match.fun(benchmarkParameters$allocatorFunction)
   benchmark <- match.fun(benchmarkParameters$benchmarkFunction)

   dimensions <- benchmarkParameters$dimensions
   numberOfDimensions <- length(dimensions)
   numberOfTrials <- benchmarkParameters$numberOfTrials
   numberOfWarmupTrials <- benchmarkParameters$numberOfWarmupTrials
   benchmarkName <- benchmarkParameters$benchmarkName

   if (numberOfDimensions != length(numberOfTrials)) {
      errorStr <- sprintf("ERROR: Input checking failed for microbenchmark '%s'  -- length of numberOfTrials and dimensions arrays must be equal", benchmarkParameters$benchmarkName)
      write(errorStr, stderr())
      return(1)
   }

   if (numberOfDimensions != length(numberOfWarmupTrials)) {
      errorStr <- sprintf("ERROR: Input checking failed for microbenchmark '%s' -- length of numberOfWarmupTrials and dimensions arrays must be equal", benchmarkParameters$benchmarkName)
      write(errorStr, stderr())
      return(1)
   }
   
   maximumNumberOfTrials <- max(numberOfTrials)
   trialTimes <- rep(0, maximumNumberOfTrials*maximumNumberOfTrials)
   dim(trialTimes) <- c(maximumNumberOfTrials, maximumNumberOfTrials)
   averageWallClockTimes <- rep(0, numberOfDimensions)
   standardDeviations <- rep(0, numberOfDimensions)
   numberOfSuccessfulTrials <- rep(0, numberOfDimensions)

   for (j in 1:numberOfDimensions) {
      d <- dimensions[j]

      for (i in 1:(numberOfTrials[j]+numberOfWarmupTrials[j])) {
         cat(sprintf("Running iteration %d for dimension %d... ", i, d))

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
      averageWallClockTimes[j] <- compute_average_time(numberOfSuccessfulTrials[j], trialTimes[,j]) 
      standardDeviations[j] <- compute_standard_deviation(numberOfSuccessfulTrials[j], trialTimes[,j])
      print_matrix_kernel_results_csv(numberOfThreads, dimensions[j], averageWallClockTimes[j], standardDeviations[j], csvResultsFileName)
   }

   print_matrix_kernel_results(benchmarkName, numberOfThreads, dimensions, numberOfSuccessfulTrials, trialTimes, averageWallClockTimes, standardDeviations)

   return(0)
}
