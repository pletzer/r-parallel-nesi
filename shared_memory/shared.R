library(doParallel)

# let the user set the number of work tasks
args <- commandArgs(trailingOnly=TRUE)
ntasks <- 50
if (length(args) >= 1) {
    ntasks <- strtoi(args[1])
}

# infer the number ofg workers from SLURM
nworkers <- strtoi(Sys.getenv("SLURM_CPUS_PER_TASK", unset = "1"))

cl <- makeCluster(nworkers)

registerDoParallel(cl)

# ntasks calculations, store the result in 'x' 
x <- foreach(z = 1000000:(1000000 + ntasks), .combine = 'c') %dopar% { 
    sum(rnorm(z))
}

stopCluster(cl)
print(x)

