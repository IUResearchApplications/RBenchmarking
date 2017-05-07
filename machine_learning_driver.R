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
library(devtools)
devtools::load_all("RHPCBenchmark")

GetClusteringTestMicrobenchmarks <- function() {
   microbenchmarks <- list()
   microbenchmarks[["pam_cluster_3_7_2500"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = TRUE,
      benchmarkName = "pam_cluster_3_7_2500",
      benchmarkDescription = "Clustering of 17500 3-dimensional feature vectors into seven clusters using pam function",
      dataObjectName = NA_character_,
      numberOfFeatures = as.integer(3),
      numberOfClusters = as.integer(7),
      numberOfFeatureVectorsPerCluster = as.integer(2500),
      numberOfTrials = as.integer(2),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringBenchmark
   )

   microbenchmarks[["pam_cluster_3_7_5000"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = FALSE,
      benchmarkName = "pam_cluster_3_7_5000",
      benchmarkDescription = "Clustering of 35000 3-dimensional feature vectors into seven clusters using pam function",
      numberOfFeatures = as.integer(3),
      numberOfClusters = as.integer(7),
      numberOfFeatureVectorsPerCluster = as.integer(5000),
      dataObjectName = NA_character_,
      numberOfTrials = as.integer(2),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringBenchmark
   )

   microbenchmarks[["pam_cluster_3_7_5715"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = FALSE,
      benchmarkName = "pam_cluster_3_7_5715",
      benchmarkDescription = "Clustering of 40005 3-dimensional feature vectors into seven clusters using pam function",
      numberOfFeatures = as.integer(3),
      numberOfClusters = as.integer(7),
      numberOfFeatureVectorsPerCluster = as.integer(5715),
      dataObjectName = NA_character_,
      numberOfTrials = as.integer(2),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringBenchmark
   )

   microbenchmarks[["pam_cluster_16_33_1213"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = FALSE,
      benchmarkName = "pam_cluster_16_33_1213",
      benchmarkDescription = "Clustering of 40029 16-dimensional feature vectors into 33 clusters using pam function",
      numberOfFeatures = as.integer(16),
      numberOfClusters = as.integer(33),
      numberOfFeatureVectorsPerCluster = as.integer(1213),
      dataObjectName = NA_character_,
      numberOfTrials = as.integer(2),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringBenchmark
   )

   microbenchmarks[["pam_cluster_64_33_1213"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = FALSE,
      benchmarkName = "pam_cluster_64_33_1213",
      benchmarkDescription = "Clustering of 40029 64-dimensional feature vectors into 33 clusters using pam function",
      numberOfFeatures = as.integer(64),
      numberOfClusters = as.integer(33),
      numberOfFeatureVectorsPerCluster = as.integer(1213),
      dataObjectName = NA_character_,
      numberOfTrials = as.integer(2),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringBenchmark
   )

   microbenchmarks[["pam_cluster_16_7_2858"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = FALSE,
      benchmarkName = "pam_cluster_16_7_2858",
      benchmarkDescription = "Clustering of 20006 16-dimensional feature vectors into seven clusters using pam function",
      numberOfFeatures = as.integer(16),
      numberOfClusters = as.integer(7),
      numberOfFeatureVectorsPerCluster = as.integer(2858),
      dataObjectName = NA_character_,
      numberOfTrials = as.integer(2),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringBenchmark
   )

   microbenchmarks[["pam_cluster_32_7_2858"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = FALSE,
      benchmarkName = "pam_cluster_32_7_2858",
      benchmarkDescription = "Clustering of 20006 32-dimensional feature vectors into seven clusters using pam function",
      numberOfFeatures = as.integer(32),
      numberOfClusters = as.integer(7),
      numberOfFeatureVectorsPerCluster = as.integer(2858),
      dataObjectName = NA_character_,
      numberOfTrials = as.integer(2),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringBenchmark
   )

   microbenchmarks[["pam_cluster_64_7_5715"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = FALSE,
      benchmarkName = "pam_cluster_64_7_5715",
      benchmarkDescription = "Clustering of 40005 64-dimensional feature vectors into seven clusters using pam function",
      numberOfFeatures = as.integer(64),
      numberOfClusters = as.integer(7),
      numberOfFeatureVectorsPerCluster = as.integer(5715),
      dataObjectName = NA_character_,
      numberOfTrials = as.integer(2),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = PamClusteringBenchmark
   )

   microbenchmarks[["clara_cluster_64_33_1213"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = TRUE,
      benchmarkName = "clara_cluster_64_33_1213",
      benchmarkDescription = "Clustering of 40029 64-dimensional feature vectors into 33 clusters using clara function",
      numberOfFeatures = as.integer(64),
      numberOfClusters = as.integer(33),
      numberOfFeatureVectorsPerCluster = as.integer(1213),
      dataObjectName = NA_character_,
      numberOfTrials = as.integer(2),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = ClaraClusteringBenchmark
   )

   microbenchmarks[["clara_cluster_1000_99_1000"]] <- methods::new(
      "ClusteringMicrobenchmark",
      active = FALSE,
      benchmarkName = "clara_cluster_1000_99_1000",
      benchmarkDescription = "Clustering of 99000 1000-dimensional feature vectors into 99 clusters using clara function",
      numberOfFeatures = as.integer(1000),
      numberOfClusters = as.integer(99),
      numberOfFeatureVectorsPerCluster = as.integer(1000),
      dataObjectName = NA_character_,
      numberOfTrials = as.integer(2),
      numberOfWarmupTrials = as.integer(1),
      allocatorFunction = ClusteringAllocator,
      benchmarkFunction = ClaraClusteringBenchmark
   )

   return (microbenchmarks)
}


args <- commandArgs(trailingOnly=TRUE)

if (length(args) != 2) {
   write("USAGE: machine_learning_driver runIdentifier resultsDirectory", stderr())
   quit(status=1)
}

runIdentifier <- args[1]
resultsDirectory <- args[2]

myClustering <- GetClusteringDefaultMicrobenchmarks()
#myClustering[["pam_cluster_3_7_2500"]]$active <- FALSE
myClustering[["pam_cluster_3_7_5000"]]$active <- FALSE
myClustering[["pam_cluster_3_7_5715"]]$active <- FALSE
myClustering[["pam_cluster_16_33_1213"]]$active <- FALSE
myClustering[["pam_cluster_64_33_1213"]]$active <- FALSE
myClustering[["pam_cluster_16_7_2858"]]$active <- FALSE
myClustering[["pam_cluster_32_7_2858"]]$active <- FALSE
myClustering[["pam_cluster_64_7_5715"]]$active <- FALSE
myClustering[["pam_cluster_64_33_1213"]]$active <- FALSE
myClustering[["pam_cluster_1000_99_1000"]]$active <- FALSE
myClustering[["clara_cluster_64_33_1213"]]$active <- FALSE
myClustering[["clara_cluster_1000_99_1000"]]$active <- FALSE

machineLearningResults <- RunMachineLearningBenchmark(runIdentifier,
   resultsDirectory, clusteringMicrobenchmarks=myClustering)
dataFrameFileName <- file.path(resultsDirectory, "machineLearningResults.RData")
save(machineLearningResults, file=dataFrameFileName)
cat("Warnings (NULL, if none):\n")
warnings()
