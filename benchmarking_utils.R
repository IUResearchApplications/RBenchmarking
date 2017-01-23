get_configurable_env_parameter<-function(configurable_variable) {
   # Get the name of the wanted environment varible from the
   # configurable environment variable.
   env_variable <- Sys.getenv(configurable_variable)

   if (env_variable == "") {
      write(sprintf("ERROR: Configurable environment variable '%s' was not set", configurable_variable), stderr())
      quit(status=1)
   } else {
      value <- Sys.getenv(env_variable)

      if (value == "") {
         write(sprintf("ERROR: Environment variable '%s' was not set", env_variable), stderr())
         quit(status=1)
      }
   }

   return(value)
}


read_parameters<-function() {

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

   num_threads <- strtoi(get_configurable_env_parameter("R_BENCH_NUM_THREADS_VARIABLE")) 

   if (is.na(num_threads)) {
      write("ERROR: Non-integer number of threads specified in environment", stderr())
      quit(status=1)
   }

   output_directory_str <- get_configurable_env_parameter("R_BENCH_OUTPUT_DIR_VARIABLE")
   job_descriptor_str <- get_configurable_env_parameter("R_BENCH_JOB_DESCRIPTOR_VARIABLE")
   #test_suite_job_id_str <- get_configurable_env_parameter("R_BENCH_TEST_SUITE_ID_VARIABLE")
   csv_results_file <- paste(output_directory_str, "/", job_descriptor_str, ".csv", sep="")

   return (list("num_threads" = num_threads, "csv_results_file" = csv_results_file))
}
  

 

setup_runs<-function(sizes, num_runs, num_warmup_runs, csv_results_file) {
   num_sizes <- length(sizes)
   max_runs <- max(num_runs)
   
   if (num_sizes != length(num_runs)) {
      write("ERROR: Length of num_runs and sizes arrays must be equal", stderr())
      quit(status=1)
   }

   if (num_sizes != length(num_warmup_runs)) {
      write("ERROR: Length of num_warmup_runs and sizes arrays must be equal", stderr())
      quit(status=1)
   }

   times <- rep(0, max_runs*num_sizes);
   averages <- rep(0, num_sizes);
   dim(times) <- c(max_runs, num_sizes)

   Runif <- rMWC1019       # The fast uniform number generator
   a <- rMWC1019(10, new.start=TRUE, seed=492166)  # Init. the generator
   Rnorm <- rziggurat      # The fast normal number generator
   b <- rziggurat(10, new.start=TRUE)      # Init. the generator
   remove("a", "b")
   #options(object.size=100000000)

   if (csv_results_file != "" && !file.exists(csv_results_file)) {
      cat("Dimension", "Avg. Wall Clock Time", "Number of Threads\n", file=csv_results_file, sep=",", append=FALSE)
   }

   return (list("num_sizes" = num_sizes, "max_runs" = max_runs, "times" = times, "averages" = averages, "Runif" = Runif, "Rnorm" = Rnorm))
}


print_results<-function(benchmark_name, sizes, num_runs, averages) {
   num_sizes <- length(sizes)
   omp_num_threads <- Sys.getenv("OMP_NUM_THREADS")
   mkl_num_threads <- Sys.getenv("MKL_NUM_THREADS")

   cat(  "-----------------------------------------------------------------------\n")
   cat(sprintf("Timings summary for %s\n", benchmark_name))
   cat(  "-----------------------------------------------------------------------\n")
   cat(sprintf("OMP_NUM_THREADS=%s, MKL_NUM_THREADS=%s\n", omp_num_threads, mkl_num_threads))
   cat(  "-----------------------------------------------------------------------\n")
   cat(c("Dimension | Number of Runs | Min Time     | Max Time     | Average Time\n"))
   cat(  "-----------------------------------------------------------------------\n")

   for (i in 1:num_sizes) {
      cat(sprintf("%-10d  %-14d   %-12.6e   %-12.6e   %-12.6e\n", sizes[i], num_runs[i], min(times[1:num_runs[i], i]), max(times[1:num_runs[i], i]), averages[i]))
   }

   cat(  "-----------------------------------------------------------------------\n")

}


print_results_csv<-function(dimension, avg_wall_time, num_threads, csv_results_file) {
   if (csv_results_file != "") {
      cat(sprintf("%d,%12.6e,%d\n", dimension, avg_wall_time, num_threads), file=csv_results_file, append=TRUE)
   }
}
   

compute_average_times<-function(num_runs, times) {
   l <- length(num_runs)
   averages <- rep(0, l)

   for (i in 1:num_sizes) {
      averages[i] <- mean(times[1:num_runs[i], i])
   }

   return(averages)
}


compute_average_time<-function(num_runs, times) {
   return(mean(times[1:num_runs]))
}
