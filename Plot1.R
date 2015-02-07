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

#making plot 1

library(lubridate)
sample$moment <- paste(as.character(sample$Date), sample$Time)
sample$moment <- ymd_hms(sample$moment)

png("plot1.png")
par(pty="s", bg=NA)
hist(sample$Global_active_power, col="red", axes=FALSE, xlab="Global active power (kilowatts)", ylab="Frequency", main="Global active power", cex.lab=0.7)

xlabels <- seq(0, 6, by=2)
ylabels <- seq(0, 1200, by=200)

axis(1, at=xlabels, labels=xlabels, las=0, cex.axis=0.7)
axis(2, at=ylabels, labels=ylabels, las=1, cex.axis=0.7)
dev.off()

