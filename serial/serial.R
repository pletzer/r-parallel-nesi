library(foreach)

# 50 calculations, store the result in 'x' 
x <- foreach(z = 1000000:1000050, .combine = 'c') %do% { 
    sum(rnorm(z)) }

print(x)

