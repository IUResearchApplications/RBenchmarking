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
devtools::load_all("RHPCBenchmarkData")

args <- commandArgs(trailingOnly=TRUE)

if (length(args) != 4) {
   write("USAGE: generate_cluster_test_data featureVectorDimension numDimensionsToCluster numVectorsPerCluster dataDirectory", stderr())
   quit(status=1)
}

set.seed(910)

featureVectorDimension <- as.integer(args[1])
numDimensionsToCluster <- as.integer(args[2])
numVectorsPerCluster <- as.integer(args[3])
dataDirectory <- args[4]

GenerateClusterData(featureVectorDimension, numDimensionsToCluster,
   numVectorsPerCluster, dataDirectory)
cat("Done\n")

