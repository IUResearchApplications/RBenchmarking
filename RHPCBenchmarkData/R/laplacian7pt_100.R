#' A 100x100x100 7-point Laplacian operator stored as a sparse matrix object
#'
#' A sparse matrix object containing a 7-point Laplacian operator generated over
#' a 100x100x100 grid.  It was generated from a Matlab script and converted to R
#' Matrix format.
#'
#' @format A dgCMatrix object from the Matrix package
#' \describe{
#'   \item{# rows}{1000000}
#'   \item{# columns}{1000000}
#'   \item{# nonzeros}{6940000} 
#' }
#'
"laplacian7pt_100"
