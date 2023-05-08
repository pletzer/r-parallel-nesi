library(doParallel, quiet = TRUE)
library(Rmpi)

# let the user set the number of work tasks
args <- commandArgs(trailingOnly=TRUE)
ntasks <- 50
if (length(args) >= 1) {
    ntasks <- strtoi(args[1])
}

slaves <- as.numeric(Sys.getenv(c("SLURM_NTASKS"))) - 1
print(sprintf("number of slaves = %d", slaves))

cl <- makeCluster(slaves, type="MPI")

registerDoParallel(cl)
 
x <- foreach(z = 1000000:(1000000 + ntasks), .combine=c) %dopar% {
    sum(rnorm(z))
}
print('done with the loop')

# this will detach MPI
snow::stopCluster(cl)
#mpi.exit()
print(x)
