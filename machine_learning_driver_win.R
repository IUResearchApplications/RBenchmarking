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

devtools::load_all(pkg="RHPCBenchmark", export_all=FALSE)

Sys.setenv(R_BENCH_NUM_THREADS_VARIABLE="MKL_NUM_THREADS")
Sys.setenv(MKL_NUM_THREADS="1")

runIdentifier <- "windows1"
resultsDirectory <- "./windowsMachineLearning"

myClustering <- ClusteringDefaultMicrobenchmarks()
myClustering[["pam_cluster_3_7_2500"]]$active <- TRUE
myClustering[["pam_cluster_3_7_5000"]]$active <- FALSE
myClustering[["pam_cluster_3_7_5715"]]$active <- FALSE
myClustering[["pam_cluster_16_33_1213"]]$active <- FALSE
myClustering[["pam_cluster_64_33_1213"]]$active <- FALSE
myClustering[["pam_cluster_16_7_2858"]]$active <- FALSE
myClustering[["pam_cluster_32_7_2858"]]$active <- FALSE
myClustering[["pam_cluster_64_7_5715"]]$active <- FALSE
myClustering[["pam_cluster_64_33_1213"]]$active <- FALSE
myClustering[["pam_cluster_1000_99_1000"]]$active <- TRUE

machineLearningResults <- MachineLearningBenchmark(runIdentifier,
   resultsDirectory, clusteringMicrobenchmarks=myClustering)
dataFrameFileName <- file.path(resultsDirectory, "machineLearningResults.RData")
save(machineLearningResults, file=dataFrameFileName)
cat("Warnings (NULL, if none):\n")
warnings()
