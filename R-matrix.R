
num_tests <- 8
runs <- 3			# Number of times the tests are executed
times <- rep(0, num_tests*runs);
averages <- rep(0,num_tests);
dim(times) <- c(runs, num_tests)
require(Matrix)		# Optimized matrix operations
require(SuppDists)	# Optimized random number generators
Runif <- rMWC1019	# The fast uniform number generator
#Runif <- runif
# If you don't have SuppDists, you can use: Runif <- runif
a <- rMWC1019(10, new.start=TRUE, seed=492166)	# Init. the generator
Rnorm <- rziggurat	# The fast normal number generator
# If you don't have SuppDists, you can use: Rnorm <- rnorm
b <- rziggurat(10, new.start=TRUE)	# Init. the generator
#Rnorm <- rnorm
remove("a", "b")
#options(object.size=100000000)

cat("\n\nR Matrix Benchmark\n")
cat("===============\n")
cat(c("Number of times each test is run__________________________: ", runs))
cat("\n\n")

cat("Running creation, deformation and transpose... ")
if (R.Version()$os == "Win32" || R.Version()$os == "mingw32") flush.console()

# (1)
# No special transpose options
a <- 0; b <- 0
for (i in 1:runs) {
  invisible(gc())

  timing <- system.time({
    a <- matrix(Rnorm(2500*2500)/10, ncol=2500, nrow=2500);
    b <- t(a);
    dim(b) <- c(1250, 5000);
    a <- t(b)
  })[3]

  times[i,1] <- timing
}

cat("Done\n")

#cat(c("Creation, transp., deformation of a 2500x2500 matrix (sec): ", timing, "\n"))
remove("a", "b")

cat("Running matrix raised to power... ") 

if (R.Version()$os == "Win32" || R.Version()$os == "mingw32") flush.console()

# (2)
# No special power options
b <- 0
for (i in 1:runs) {
  a <- abs(matrix(Rnorm(2500*2500)/2, ncol=2500, nrow=2500));
  invisible(gc())

  timing <- system.time({ 
    b <- a^1000 
  })[3]

  times[i,2] <- timing
}

cat("Done\n")
#cat(c("2500x2500 normal distributed random matrix ^1000____ (sec): ", timing, "\n"))
remove("a", "b")

cat("Running cross-product... ")

if (R.Version()$os == "Win32" || R.Version()$os == "mingw32") flush.console()

# (3)
# No special cross product options
b <- 0
for (i in 1:runs) {
  a <- Rnorm(2800*2800); dim(a) <- c(2800, 2800)
  invisible(gc())

  timing <- system.time({
    b <- crossprod(a)		# equivalent to: b <- t(a) %*% a
  })[3]

  times[i,3] <- timing
}

cat("Done\n")
#cat(c("2800x2800 cross-product matrix (b = a' * a)_________ (sec): ", timing, "\n"))
remove("a", "b")

cat("Running linear regression... ")

if (R.Version()$os == "Win32" || R.Version()$os == "mingw32") flush.console()

# (4)
# No special cross product options
# No special solve options, but does supposedly use *ESV LAPACK routines
# TODO: Determine which of crossproduct, qr, or lsfit implementations
# is fastest in parallel
c <- 0; qra <-0
for (i in 1:runs) {
  a <- new("dgeMatrix", x = Rnorm(2000*2000), Dim = as.integer(c(2000,2000)))
  b <- as.double(1:2000)
  invisible(gc())

  timing <- system.time({
    c <- solve(crossprod(a), crossprod(a,b))
  })[3]

  # This is the old method
  #a <- Rnorm(600*600); dim(a) <- c(600,600)
  #b <- 1:600
  #invisible(gc())
  #timing <- system.time({
  #  qra <- qr(a, tol = 1e-7);
  #  c <- qr.coef(qra, b)
  #  #Rem: a little faster than c <- lsfit(a, b, inter=F)$coefficients
  #})[3]
  #cumulate <- cumulate + timing

  times[i,4] <- timing
}

cat("Done\n")

#cat(c("Linear regr. over a 2000x2000 matrix (c = a \\ b')___ (sec): ", timing, "\n"))
remove("a", "b", "c", "qra")


cat("Running eigensolve... ")

if (R.Version()$os == "Win32" || R.Version()$os == "mingw32") flush.console()

# (5)
# Try computing the eigenvectors as well.
# Uses LAPACK DSYEV, DGEEV, ZHEEV, ZGEEV
b <- 0
for (i in 1:runs) {
  a <- array(Rnorm(600*600), dim = c(600, 600))
  # Only needed if using eigen.Matrix(): Matrix.class(a)
  invisible(gc())
  timing <- system.time({
  	b <- eigen(a, symmetric=FALSE, only.values=TRUE)$Value
  	# Rem: on my machine, it is faster than:
  #	 b <- La.eigen(a, symmetric=F, only.values=T, method="dsyevr")$Value
  #	 b <- La.eigen(a, symmetric=F, only.values=T, method="dsyev")$Value
  #  b <- eigen.Matrix(a, vectors = F)$Value
  })[3]

  times[i,5] <- timing
}

cat("Done\n")

#cat(c("Eigenvalues of a 600x600 random matrix______________ (sec): ", timing, "\n"))
remove("a", "b")


cat("Running determinant... ")
if (R.Version()$os == "Win32" || R.Version()$os == "mingw32") flush.console()

# (6)
# No special options for determinant
b <- 0
for (i in 1:runs) {
  a <- Rnorm(2500*2500); dim(a) <- c(2500, 2500)
  #Matrix.class(a)
  invisible(gc())

  timing <- system.time({
    #b <- determinant(a, logarithm=F)
    # Rem: the following is slower on my computer!
    # b <- det.default(a)
    b <- det(a)
  })[3]

  times[i,6] <- timing
}

cat("Done\n")

#cat(c("Determinant of a 2500x2500 random matrix____________ (sec): ", timing, "\n"))
remove("a", "b")


cat("Running Cholesky decomposition... ")
if (R.Version()$os == "Win32" || R.Version()$os == "mingw32") flush.console()

# (7)
# No special Cholesky options.  Uses LAPACK DPOTRF and DPSTRF.
cumulate <- 0; b <- 0
for (i in 1:runs) {
  a <- crossprod(new("dgeMatrix", x = Rnorm(3000*3000),
                       Dim = as.integer(c(3000, 3000))))
  invisible(gc())
  #a <- Rnorm(900*900); dim(a) <- c(900, 900)
  #a <- crossprod(a, a)
  timing <- system.time({
    b <- chol(a)
  })[3]

  times[i,7] <- timing
}

cat("Done\n")

#cat(c("Cholesky decomposition of a 3000x3000 matrix________ (sec): ", timing, "\n"))
remove("a", "b")


cat("Inverse... ")
if (R.Version()$os == "Win32" || R.Version()$os == "mingw32") flush.console()

# (8)
# No special solve options.  Uses LAPACK DGESV an ZGESV.
b <- 0
for (i in 1:runs) {
  a <- new("dgeMatrix", x = Rnorm(1600*1600), Dim = as.integer(c(1600, 1600)))
  invisible(gc())
  #a <- Rnorm(400*400); dim(a) <- c(400, 400)

  timing <- system.time({
  #  b <- qr.solve(a)
    # Rem: a little faster than
    b <- solve(a)
  })[3]

  times[i,8] <- timing
}

cat("Done\n")
#cat(c("Inverse of a 1600x1600 random matrix________________ (sec): ", timing, "\n"))
remove("a", "b")

cat("SVD... ")
if (R.Version()$os == "Win32" || R.Version()$os == "mingw32") flush.console()

# (9)
#
b <- 0
for (i in 1:runs) {
  a <- new("dgeMatrix", x = Rnorm(1600*1600), Dim = as.integer(c(1600, 1600)))
  invisible(gc())

  timing <- system.time({
     b <- solve(a)
  })[3]

  times[i,9] <- timing
}

cat("Done\n")
remove("a", "b")


for (i in 1:num_tests) {
   times[ , i] <- sort(times[ , i])
}

for (i in 1:num_tests) {
   averages[i] <- mean(times[2:num_tests-1, i])
}

cat("Timings summary:\n")
cat("--------------------------------\n")
cat("Creation, deformation, transpose: ", averages[1])
cat("Matrix raised to power          : ", averages[2])
cat("Cross product                   : ", averages[3])
cat("Linear regression               : ", averages[4])                
cat("Eigenvalue                      : ", averages[5])
cat("Determinant                     : ", averages[6])
cat("Cholesky decomposition          : ", averages[7])
cat("Inverse                         : ", averages[8])

cat("--- End of tests ---\n\n")
