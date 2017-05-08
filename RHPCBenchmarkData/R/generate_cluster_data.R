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

#' Generates mean vectors and covariances used to generate clusters of normally
#' distributed vectors
#'
#' \code{GenerateMvnParameters} generates mean value vectors \code{mu} at the
#' origin and -1 and 1 of each major axis up to and including the axis given by 
#' the index \code{numDimensionsToCluster}.  The covariances are diagonal with
#' elements drawn from a univariate standard normal distribution.
#'
#' @param dimension the number of dimesion of the feature space
#' @param numDimensionsToCluster the index indicating the maximum number of
#'   features (dimensions) over which to generate clusters; if
#'   \code{numDimensionsToCluster} is less than \code{dimension}, then
#'   mean values and covariances will only be generated at -1 and 1 of
#'   each major axis up to and including the axis indicated by
#'   \code{numDimensionsToCluster}.
#' @return a list containing a matrix \code{mu} containing the mean value
#'   vectors as row vectors and an array \code{S} of diagonal covariance
#'   matrices corresponding to the mean value vectors
GenerateMvnParameters <- function(dimension, numDimensionsToCluster=dimension) {
   
   if (numDimensionsToCluster < 1) {
      stop("numDimensionsToCluster must be greater than zero")
   }

   numDimensionsToCluster <- min(dimension, numDimensionsToCluster)
   numClusters <- 2*numDimensionsToCluster+1 
   mu <- rep(0.0, numClusters * dimension)
   dim(mu) <- c(numClusters, dimension)

   for (i in 1:numDimensionsToCluster) {
      mu[i, i] <- 1 
      mu[numDimensionsToCluster+i, i] <- -1
   }

   S <- rep(0.0, numClusters*dimension*dimension)
   dim(S) <- c(numClusters, dimension, dimension)

   for (i in 1:numClusters) {
      s <- stats::runif(dimension)
      s <- 4*s
      S[i,,] <- diag(s, dimension, dimension)
   }

   return (list("mu" = mu, "S" = S))
}


#' Generates clusters of normally distributed vectors given mean value
#' vectors and covariance matrices
#'
#' \code{GenerateMVNVectors} generates clusters of normally distributed vectors
#' given a matrix of row vectors representing mean value vectors and an
#' array of covariance matrices.
#' 
#' @param params list containing a matrix \code{mu} containing the mean value vectors
#'   as row vectors and an array \code{S} of diagonal covariance matrices
#'   corresponding to the mean value vectors.  This is the same list returned by
#'   the function \code{\link{GenerateMvnParameters}}.
#' @param numVectorsPerCluster the number of vectors to randomly generate for
#'   each cluster
#' @return a list containing a matrix of the randomly generated feature vectors
#'   \code{featureVectors} from each cluster and a value \code{numClusters}
#'   indicating the number of clusters; the feature vectors are stored by row
#'   in the \code{featureVectors} matrix.
GenerateMvnVectors <- function(params, numVectorsPerCluster) {
   numClusters <- dim(params$mu)[1]
   dimension <- dim(params$mu)[2]
   numFeatureVectors <- numClusters*numVectorsPerCluster
   featureVectors <- rep(0.0, numFeatureVectors*dimension)
   dim(featureVectors) <- c(numFeatureVectors, dimension)

   for (i in 1:numClusters) {
      rangeStart <- (i-1)*numVectorsPerCluster + 1 
      rangeEnd <- rangeStart + numVectorsPerCluster - 1
      cat("rangeStart: ", rangeStart, "\n")
      cat("rangeEnd: ", rangeEnd, "\n")
      featureVectors[rangeStart:rangeEnd, ] <- mvtnorm::rmvnorm(numVectorsPerCluster, params$mu[i, ], params$S[i,,])
   }

   return (list("featureVectors"=featureVectors, "numClusters"=numClusters))
}


#' Generates clusters of normally dtributed vectors and writes them to
#' an R data file
#'
#' Generates clusters of normally distributed vectors with means at
#' origin and -1 and 1 of each major axis up to and including the axis given by 
#' the index \code{numDimensionsToCluster}.  The covariances are diagonal with
#' elements drawn from a univariate standard normal distribution.  The
#' features vectors of each cluster are concatenated into a single matrix
#' \code{featureVectors} and stored in a list along with the mean values
#' \code{mu} and covariance matrices \code{S} that define the cluster
#' distributions.  The list is written to a file with a name that has the
#' following form:
#' cluster_\code{featureVectorDimension}_\code{numClusters}_\code{numVectorsPerCluster}
#'
#' @param featureVectorDimension the dimension of each feature vector to be
#'   generated
#' @param numDimensionsToCluster the index indicating the maximum number of
#'   features (dimensions) over which to generate clusters; if
#'   \code{numDimensionsToCluster} is less than \code{dimension}, then
#'   mean values and covariances will only be generated at -1 and 1 of
#'   each major axis up to and including the axis indicated by
#'   \code{numDimensionsToCluster}.
#' @param numVectorsPerCluster the number of vectors to randomly generate for
#'   each cluster
#' @param dataDirectory the directory path where the R data file containing
#'   the feature vectors is to be stored
#' @export
GenerateClusterData <- function(featureVectorDimension, numDimensionsToCluster,
   numVectorsPerCluster, dataDirectory) {

   mvnParameters <- GenerateMvnParameters(featureVectorDimension,
      numDimensionsToCluster)
   generatedVectors <- GenerateMvnVectors(mvnParameters, numVectorsPerCluster)
   numClusters <- generatedVectors$numClusters

   clusters <- list()
   clusters$mu <- mvnParameters$mu
   clusters$S <- mvnParameters$S
   clusters$featureVectors <- generatedVectors$featureVectors

   clusterName <- paste("cluster_", featureVectorDimension, "_", numClusters,
      "_", numVectorsPerCluster, sep="")
   fileName <- paste(clusterName, ".RData", sep="")
   filePath <- file.path(dataDirectory, fileName)

   assign(clusterName, clusters)
   cat(sprintf("Writing cluster data to file: %s\n", clusterName))
   utils::str(get(clusterName))
   save(list=c(clusterName), file=filePath)

}

