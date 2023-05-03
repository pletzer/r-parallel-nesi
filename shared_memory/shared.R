library(doParallel)

nworkers <- strtoi(Sys.getenv("SLURM_CPUS_PER_TASK", unset = "1"))

cl <- makeCluster(nworkers)
registerDoParallel(cl)

# 50 calculations, store the result in 'x' 
x <- foreach(z = 1000000:1000050, .combine = 'c') %dopar% { 
    sum(rnorm(z)) }

stopCluster(cl)
print(x)

