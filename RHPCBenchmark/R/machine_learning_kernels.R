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

#' Allocates and initializes input to the machine learning microbenchmarks
#'
#' \code{ClusteringAllocator} allocates and initializes the data sets that are
#' inputs to clustering microbenchmarks for the purposes of conducting a single
#' performance trial with the \code{ClusteringMicrobenchmark} function.  The
#' data set is populated and returned in the \code{kernelParameters} list.
#'
#' @param benchmarkParameters an object of type
#'   \code{\link{MachineLearningMicrobenchmark}} specifying various parameters
#'   needed to generate input for the machine learning microbenchmark.
#' @return a list containing the data objects to be input to the
#'   clustering microbenchmark for which a single performance trial is to be
#'   conducted.
ClusteringAllocator <- function(benchmarkParameters) {
   # Create list of kernel parameters
   kernelParameters <- get(benchmarkParameters$dataObjectName)
   kernelParameters$numberOfFeatures <- dim(kernelParameters$featureVectors)[2]
   kernelParameters$numberOfFeatureVectors <- dim(kernelParameters$featureVectors)[1]
   kernelParameters$numberOfClusters <- dim(kernelParameters$mu)[1]

   if (nrow(kernelParameters$mu) != dim(kernelParameters$S)[1]) {
      stop("Number of mean values must be equal to the number of covariance matrices")
   } else if (dim(kernelParameters$featureVectors)[1] %% kernelParameters$numberOfClusters != 0) {
      stop("Number of feature vectors must be a multiple of the number of clusters")
   }

   return (kernelParameters)
}


#' Conducts a single performance trial with the cluster::pam function
#'
#' \code{ClusteringMicrobenchmark} conducts a single performance trial
#' of the cluster::pam function with the data given in the
#' \code{kernelParameters} parameter.
#'
#' @param benchmarkParameters an object of type
#'   \code{\link{MachineLearningMicrobenchmark}} specifying various parameters
#'   for microbenchmarking the cluster::pam function
#' @param kernelParameters a list of data objects to be used as input to
#'   the clustering function
#' @return a vector containing the user, system, and elapsed performance
#'   timings in that order
PamClusteringBenchmark <- function(benchmarkParameters, kernelParameters) {
   timings <- system.time({clusterObj <- cluster::pam(kernelParameters$featureVectors,
      kernelParameters$numberOfClusters, cluster.only=TRUE, trace.lev=1)})
   return (timings)
}

