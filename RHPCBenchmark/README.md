This package performs microbenchmarking for determining the run time
performance of aspects of the R programming environment and packages relevant
to high-performance computation.  The benchmarks are divided into three
categories: dense matrix linear algebra kernels, sparse matrix linear algebra
kernels, and machine learning functionality.  The benchmark functions covering
the three categories are RunDenseMatrixBenchmark, RunSparseMatrixBenchmark,
RunMachineLearningBenchmark.  See the vignette for examples on how to call
these functions, and for many more introductory background about the package.
New benchmarks can be specified using the classes DenseMatrixMicrobenchmark,
SparseMatrixMicrobenchmark, and ClusteringMicrobenchmark; see the object
documentation for each of these classes for how new microbenchmarks can be 
constructed.  The companion data package 'RHPCBenchmarkData' contains the
sparse matrix files needed by the sparse matrix benchmarking package and
can be downloaded from https://github.com/IUResearchAnalytics/RBenchmarking/blob/master/RHPCBenchmarkData_0.1.0.0.tar.gz

Installation of the packages are trivial using install.packages on the package
files.

