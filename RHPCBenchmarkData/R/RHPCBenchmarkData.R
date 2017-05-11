#' RHPCBenchmarkData: A data package which accompanies the RHPCBenchmark for 
#'   high-performance computing benchmark
#'
#' The data sets currently contain sparse matrix data.
#' The sparse matrix data files are for performance testing functionality in
#' the Matrix package, and consists of several matrices from the
#' University of Florida
#' \href{https://www.cise.ufl.edu/research/sparse/matrices/}{Sparse Matrix
#' Collection}.
#' 
#' @section The set of sparse matrices:
#' \describe{
#'    \item{laplacian7pt_100}{100x100x100 7-point Laplacian operator}
#'    \item{laplacian7pt_200}{200x200x200 7-point Laplacian operator}
#'    \item{ca2010}{SuiteSparse DIMACS10/ca2010 undirected graph matrix}
#'    \item{ct20stif}{SuiteSparse Boeing/ct20stif structural problem matrix}
#'    \item{Andrews}{SuiteSparse Andrews/Andrews computer graphics vision
#'      problem matrix}
#'    \item{G3_circuit}{SuiteSparse AMD/G3_circuit circuit simulation problem
#'      matrix}
#'    \item{circuit5M_dc}{SuiteSparse Freescale/circuit5M_dc circuit simulation
#'      problem matrix}
#'    \item{stomach}{SuiteSparse Norris/stomach 2D/3D problem matrix}
#'    \item{torso3}{SuiteSparse Norris/torso3 2D/3D problem matrix}
#'    \item{Maragal_6}{SuiteSparse NYPA/Maragal_6 least squares problem matrix}
#'    \item{landmark}{SuiteSparse Pereyra/landmark least squares problem matrix}
#' }
#'
#' @docType package
#' @name RHPCBenchmarkData
NULL
