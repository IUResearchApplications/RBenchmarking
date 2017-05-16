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

# Run this script to update the benchmark vignettes and install a development
# version of the data package so that the vignettes can be viewed.
library(devtools)

packagePath <- file.path(getwd(), "RHPCBenchmarkData")
devtools::build_vignettes("RHPCBenchmarkData")
devtools::install(pkg=packagePath, local=FALSE, upgrade_dependencies=FALSE,
   build_vignettes=TRUE)
vignette(topic="vignette", package="RHPCBenchmarkData")
