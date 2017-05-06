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

# Run this script to perform a devtools install of the package to
# test the installation process.  It ought to be run after the package
# has been checked using devtools::check_built().
library(devtools)

packagePath <- file.path(getwd(), "RHPCBenchmark")
devtools::install(pkg=packagePath, local=FALSE, upgrade_dependencies=FALSE,
   build_vignettes=TRUE)
