## Test environments
* local OS X 10.11.6 install, R 3.3.1, R 3.4.0
* CentOS Linux 7.3.1611, R 3.3.1
* mingw32, R 3.3.1

## R CMD check results
There were no ERRORs or WARNINGs

There were 2 NOTEs:
* checking CRAN incoming feasibility ... NOTE
  Maintainer: ‘James McCombs <jmccombs@iu.edu>’

  New submission

* Examples with CPU or elapsed time > 5s
  
  * Explanation:
    Some of the examples of how to use the benchmarks consume more than
    5 seconds because some are non-trivial examples and others run through
    several underlying microbenchmarks.  These run times are to be expected.

## Downstream dependencies
There are currently no downstream dependencies for this package.

## Notes on examples
* Examples were added for all three top-level functions and benchmark
  definitions in the `_kernels.R` files.
* All examples are labeled dontrun because several of them violate CRAN run
  time limit checks.
* The examples have been checked using R CMD check --as-cran --run-dontrun.
  `RunSparseMatrixBenchmark` are labeled `dontrun` because they depend on the
  companion data package
  [RHPCBenchmarkData](https://github.com/IUResearchAnalytics/RBenchmarking/blob/master/RHPCBenchmarkData_0.1.0.0.tar.gz)
  which is not available on CRAN due to its size.

Status of examples:
* `RunDenseMatrixBenchmark` examples execute normally
* `RunSparseMatrixBenchmark` examples marked as `dontrun`
* `RunMachineLearningBenchmark` examples execute normally
* Microbenchmarks in `dense_matrix_kernels.R` execute normally
* Microbenchmarks in `sparse_matrix_kernels.R` execute normally
* Microbenchmarks in `machine_learning_kernels.R` execute normally
