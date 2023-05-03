library(foreach)
library(doParallel)
library(doMPI, quiet = TRUE)

cl <- startMPIcluster(verbose = TRUE)
registerDoMPI(cl)

# 50 calculations, store the result in 'x' 
x <- foreach(z = 1000000:1000050, .combine = 'c') %dopar% { 
    sum(rnorm(z))
}

closeCluster(cl)
#mpi.exit()
print(x)
mpi.quit()
