#' A 200x200x200 7-point Laplacian operator stored as a sparse matrix object
#'
#' A sparse matrix object containing a 7-point Laplacian operator generated over
#' a 200x200x200 grid.  It was generated from a Matlab script and converted to R
#' Matrix format.
#'
#' @format A dgCMatrix object from the Matrix package
#' \describe{
#'   \item{# rows}{8000000}
#'   \item{# columns}{8000000}
#'   \item{# nonzeros}{55760000} 
#' }
#'
"laplacian7pt_200"
