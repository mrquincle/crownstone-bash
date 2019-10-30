library(ggplot2)

x <- read.csv("../output/timeseries.log", sep="\t")

power <- x[,1]
time <- x[,2]

power_usage <- data.frame(y=power)

power_usage$x <- as.POSIXct(time, format="%Y-%m-%dT%H:%M:%OS")

#print(head(power_usage))

dev.new()

p <- ggplot(power_usage, aes(x,y) ) + geom_point() + 
	ggtitle("Time series of power data")

print(p)
