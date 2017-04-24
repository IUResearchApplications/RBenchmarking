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

args <- commandArgs(trailingOnly=TRUE)

if (length(args) != 2) {
   write("USAGE: machine_learning_driver runIdentifier resultsDirectory", stderr())
   quit(status=1)
}

runIdentifier <- args[1]
resultsDirectory <- args[2]

myClustering <- GetClusteringDefaultMicrobenchmarks()
#myClustering[["pam_cluster_3_7_2500"]]$active <- FALSE
#myClustering[["pam_cluster_3_7_5000"]]$active <- FALSE
#myClustering[["pam_cluster_3_7_5715"]]$active <- FALSE
#myClustering[["pam_cluster_16_33_1213"]]$active <- FALSE
#myClustering[["pam_cluster_64_33_1213"]]$active <- FALSE
#myClustering[["pam_cluster_16_7_2858"]]$active <- FALSE
#myClustering[["pam_cluster_32_7_2858"]]$active <- FALSE
#myClustering[["pam_cluster_64_7_5715"]]$active <- FALSE
#myClustering[["pam_cluster_64_33_1213"]]$active <- FALSE
#myClustering[["pam_cluster_1000_99_1000"]]$active <- FALSE
#myClustering[["clara_cluster_64_33_1213"]]$active <- FALSE
#myClustering[["clara_cluster_1000_99_1000"]]$active <- FALSE

machineLearningResults <- RunMachineLearningBenchmark(runIdentifier,
   resultsDirectory, clusteringMicrobenchmarks=myClustering)
dataFrameFileName <- file.path(resultsDirectory, "machineLearningResults.RData")
save(machineLearningResults, file=dataFrameFileName)
cat("Warnings (NULL, if none):\n")
warnings()
