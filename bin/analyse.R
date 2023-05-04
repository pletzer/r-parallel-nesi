library(ggplot2)

data <- read.csv('table.txt', sep='|')

# manually assigning column names
colnames(data) <- c('cycle', 'method', 'submit_num', 'start_time', 'end_time')

# remove rows we are not interested in
d2 <- data[data$method %in% c('serial', 'shared', 'distributed'),]

# turn the strings into date time objects
start_time <- as.POSIXct(d2[, 4], format="%Y-%m-%dT%H:%M:%S")
end_time <- as.POSIXct(d2[, 5], format="%Y-%m-%dT%H:%M:%S")

# compute the execution time
d2$exec_time <- as.numeric(end_time - start_time) # in sec

# plot
ggplot(d2, aes(x=method, y=exec_time, fill=method)) + geom_bar(stat = "identity")

# save
top_dir <- Sys.getenv('TOP_DIR', unset = '.')
filename <- paste0(top_dir, '/results.png')
ggsave(filename, device = 'png')

resultfile <- paste0(top_dir, '/results.csv')
write.csv(d2, resultfile)
