require(Matrix)         # Optimized matrix operations
require(SuppDists)      # Optimized random number generators
require(methods)

benchmark_utils_path <- Sys.getenv("R_BENCHMARK_UTILS")
source(paste(benchmark_utils_path, "benchmarking_utils.R", sep="/"))
params<-read_parameters()

num_threads <- params$num_threads
csv_results_file <- params$csv_results_file

benchmark_name <- "matrix determinant"
# The crossprod routine requires about (N^3) operations
sizes <- c(40000)
#sizes <- c(1000, 2000, 4000, 8000, 10000, 15000, 20000, 30000)

if (num_threads == 1) {
   num_runs <- c(3)       # Number of times the tests are executed for each size
   #num_runs <- c(3, 3, 3, 3, 3, 3, 2, 2)       # Number of times the tests are executed for each size
   num_warmup_runs <- c(1)
   #num_warmup_runs <- c(1, 1, 1, 1, 0, 0, 0, 0)
} else {
   num_runs <- c(8)       # Number of times the tests are executed for each size
   #num_runs <- c(8, 8, 8, 8, 8, 8, 8, 8)       # Number of times the tests are executed for each size
   num_warmup_runs <- c(1)
   #num_warmup_runs <- c(1, 1, 1, 1, 1, 1, 1, 1)
}


run_params <- setup_runs(sizes, num_runs, num_warmup_runs, csv_results_file)

num_sizes <- run_params$num_sizes
max_runs <- run_params$max_runs
times <- run_params$times
averages <- run_params$averages
Runif <- run_params$Runif
Rnorm <- run_params$Rnorm


a <- 0; d <- 0
for (j in 1:num_sizes) {
   s <- sizes[j]

   for (i in 1:(num_runs[j]+num_warmup_runs[j])) {
      cat(sprintf("Running iteration %d for size %d... ", i, s))
      a <- matrix(Rnorm(s*s), nrow=s, ncol=s)

      timing <- system.time({
         d <- determinant(a)
      })[3]

      remove("a", "d")
      invisible(gc())

      if (i > num_warmup_runs[j]) {
         times[i-num_warmup_runs[j], j] <- timing
      }

      cat(sprintf("done: %f(sec)\n", timing))
   }

   averages[j] <- compute_average_time(num_runs[j], times[,j])
   print_results_csv(sizes[j], averages[j], num_threads, csv_results_file)

}

print_results(benchmark_name, sizes, num_runs, averages)
