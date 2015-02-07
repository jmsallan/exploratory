#setting up directory

setwd("~/Dropbox/CourseraExploratory/project1")

#download file and loead dataset into R (power dataframe)

address <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(address, destfile="~/Dropbox/CourseraExploratory/project1/power.zip", method="curl")

unzip("~/Dropbox/CourseraExploratory/project1/power.zip")

power <- read.table("household_power_consumption.txt", sep=";", na.strings="?", header=TRUE)

#selecting data from 2007-02-01 to 2007-02-02 and load into sampel dataframe

library(lubridate)

power$Date <- dmy(power$Date)

power$Time <- hms(power$Time)

low_date <- ymd("2007-02-01")
up_date <- ymd("2007-02-02")

sample <- power[power$Date <= up_date & power$Date >= low_date, ]

rm(power)

#making plot 3

library(lubridate)
sample$moment <- paste(as.character(sample$Date), sample$Time)
sample$moment <- ymd_hms(sample$moment)

png("plot3.png")
par(pty="s", bg=NA)
plot(sample$moment, sample$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering", cex.lab=0.7, cex.axis=0.7)
lines(sample$moment, sample$Sub_metering_1, col="grey")
lines(sample$moment, sample$Sub_metering_2, col="red")
lines(sample$moment, sample$Sub_metering_3, col="blue")
legend("topright", legend =colnames(sample[,c(7:9)]) , col=c("grey", "red", "blue"), lty=1, cex=0.7)
dev.off()
