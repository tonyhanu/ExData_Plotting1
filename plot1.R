# Exploratory Data Analysis Project 1 - Plot 1
# Author: Tony Hanusiak
# Date: November 8, 2015

# load required libraries
library(sqldf)
library(dplyr)

# get current working directory and use it to store downloaded and unzipped files
tempd <- getwd()
tempf <- "household_power_consumption.zip"
temp <- paste(tempd, tempf, sep = "/")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
datafile <- unzip("household_power_consumption.zip", "household_power_consumption.txt")

# read the rows for the dates in question
tmpdata <- read.csv.sql(datafile, sql = "select * from file where Date == '1/2/2007' or Date == '2/2/2007'", header=TRUE, sep=";")

# combine the date and time and add as another column and then convert the string to a POSIXlt type
# this really wasn't necessary for this plot
prjdata <- mutate(tmpdata, daytime = paste(Date, Time, sep = " "))
prjdata$daytime <- strptime(prjdata$daytime, format="%d/%m/%Y %H:%M:%S")
unlink(temp)

# In this script I created the graph on the screen device and then copied it to a png device 
# create histogram
hist(prjdata$Global_active_power, breaks = seq(from = 0, to = 8, by = 0.5), col = "#FF4500", xlab = "Global Active Power (kilowatts)", main = "Global Active Power", axes = F)
axis(1, at=c(0,2,4,6), labels = T, tick = T)
axis(2, at=seq(from = 0, to=1200, by=200), labels = T, tick = T)

#copy to a png file
dev.copy(png,'plot1.png')
png(filename="plot1.png", width=480, height=480, units="px")
dev.off()
dev.off()
dev.off()

