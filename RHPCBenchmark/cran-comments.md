## Test environments
* local OS X 10.11.6 install, R 3.3.1, R 3.4.0
* CentOS Linux 7.3.1611, R 3.3.1
* mingw32, R 3.3.1

## R CMD check results
There were no ERRORs or WARNINGs

There was 1 NOTE:
* checking CRAN incoming feasibility ... NOTE
  Maintainer: ‘James McCombs <jmccombs@iu.edu>’

  New submission

## Downstream dependencies
There are currently no downstream dependencies for this package.

## Notes on examples
Examples were added for all three top-level functions.  The examples for
`RunSparseMatrixBenchmark` are labeled `dontrun` because they depend on the
companion data package
[RHPCBenchmarkData](https://github.com/IUResearchAnalytics/RBenchmarking/blob/master/RHPCBenchmarkData_0.1.0.0.tar.gz)
which is not available on CRAN due to its size.

Status of examples:
* `RunDenseMatrixBenchmark` examples execute normally
* `RunSparseMatrixBenchmark` examples marked as `dontrun`
* `RunMachineLearningBenchmark` examples execute normally
