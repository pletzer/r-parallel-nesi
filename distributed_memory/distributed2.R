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
print(cl)

registerDoParallel(cl)
 
tick <- proc.time()
x <- foreach(z = 1000000:(1000000 + ntasks), .combine=c) %dopar% {
    sum(rnorm(z))
}
tock <- proc.time() - tick
print('done with the loop')
 
#mpi.close.Rslaves()
#snow::stopCluster(cl)
Rmpi::mpi.finalize()

cat("\nforeach w/ Rmpi test times using", slaves, "MPI slaves: \n")
tock
