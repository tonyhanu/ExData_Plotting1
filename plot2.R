# Exploratory Data Analysis Project 1 - Plot 2
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

# reading the whole file and then filtering for the two dates of interest
# because the read.csv.sql doesn't have an na.strings parameter
d <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors=F, header = TRUE)
df <- filter(d, Date == '1/2/2007' | Date == '2/2/2007')
#remove original full dataframe
rm(d)
# combine Date and Time columns and convert to a POSIXlt format as another column
d1 <- mutate(df, daytime = paste(Date, Time, sep = " "))
d1$daytime <- strptime(d1$daytime, format="%d/%m/%Y %H:%M:%S")


# do the line plot
png(filename="plot2.png", width=480, height=480, units="px")
plot(d1$daytime, d1$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
