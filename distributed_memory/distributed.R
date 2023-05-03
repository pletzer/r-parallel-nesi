library(doMPI, quiet = TRUE)

args <- commandArgs(trailingOnly=TRUE)
njobs <- 50
if (length(args) >= 1) {
    njobs <- strtoi(args[1])
}

cl <- startMPIcluster(verbose = TRUE)
registerDoMPI(cl)

# njobs calculations, store the result in 'x' 
x <- foreach(z = 1000000:(1000000 + njobs), .combine = 'c') %dopar% { 
    sum(rnorm(z))
}

closeCluster(cl)
mpi.finalize()
print(x)

