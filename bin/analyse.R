library(ggplot2)

data <- read.csv('table.txt', sep='|')

# manually assigning column names
colnames(data) <- c('job_id', 'cycle', 'method', 'submit_num', 'start_time', 'end_time')

# remove rows we are not interested in
d2 <- data[!(rownames(data) %in% c('install', 'analyse')),]

# turn the strings into date time objects
start_time <- as.POSIXct(d2$start_time, format="%Y-%m-%dT%H:%M:%S")
end_time <- as.POSIXct(d2$end_time, format="%Y-%m-%dT%H:%M:%S")

# compute the execution time
d2$exec_time <- as.numeric(end_time - start_time) # in sec

# plot
args <- commandArgs(trailingOnly=TRUE)
ntasks <- 0
if (length(args) >= 1) {
    ntasks <- strtoi(args[1])
}
p <- ggplot(d2, aes(x=method, y=exec_time, fill=method)) + geom_bar(stat = "identity")
p + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + ggtitle(sprintf("NTASKS=%d", ntasks))

# save
top_dir <- Sys.getenv('TOP_DIR', unset = '.')
filename <- paste0(top_dir, '/results.png')
ggsave(filename, device = 'png')

resultfile <- paste0(top_dir, '/results.csv')
write.csv(d2, resultfile)
