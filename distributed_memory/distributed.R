library(doMPI, quiet = TRUE)

# let the user set the number of work tasks
args <- commandArgs(trailingOnly=TRUE)
ntasks <- 50
if (length(args) >= 1) {
    ntasks <- strtoi(args[1])
}

# no need to specify the number of workers,
# it will be determined automatically
cl <- startMPIcluster(bcast = FALSE)

registerDoMPI(cl)

# ntasks calculations, store the result in 'x' 
x <- foreach(z = 1000000:(1000000 + ntasks), .combine = 'c') %dopar% { 
    sum(rnorm(z))
}

closeCluster(cl)
mpi.finalize()
print(x)

