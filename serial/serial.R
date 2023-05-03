library(foreach)

# let the user set the number of work tasks
args <- commandArgs(trailingOnly=TRUE)
ntasks <- 50
if (length(args) >= 1) {
    ntasks <- strtoi(args[1])
}


# ntasks calculations, store the result in 'x' 
x <- foreach(z = 1000000:(1000000 + ntasks), .combine = 'c') %do% { 
    sum(rnorm(z))
}

print(x)

