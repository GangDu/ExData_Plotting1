### This R code will read "Electric power consumption" data from "UC Irvine Machine Learning Repository"
### and then extract and convert the data which date in "2007-02-01" and "2007-02-02", finally, 
### plot data in png device and save the png file in the current working directory.

library(dplyr)
library(lubridate)
Sys.setlocale("LC_ALL","English")

## Step One: Import data from "household_power_consumption.txt" in the current working 
## directory if the current working directory not have required file, the code 
## will automatically download it from website, unzip and read it.

if(!file.exists("household_power_consumption.txt")){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, "household_power_consumption.zip")
    unzip("household_power_consumption.zip")
    data <- read.table("household_power_consumption.txt", 
                       header = TRUE, sep = ";", as.is = c(1, 2), na.strings = "?")
}else{
    data <- read.table("household_power_consumption.txt", 
                       header = TRUE, sep = ";", as.is = c(1, 2), na.strings = "?")
}

## Step Two: Convert 'Date' and 'Time' variables to 'Date' and 'POSIXct' classes 
## from character data type by using 'lubridate' and 'dplyr' package and 
## filter the data by 'Date' variable.

data <- mutate(data, Time = paste(Date, Time))
data <- mutate(data, Date = dmy(Date))
data <- mutate(data, Time = dmy_hms(Time))
data <- filter(data, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))

## step three: Making a plot in png device and the png file save in the current working directory

png(filename = "plot2.png", width = 480, height = 480)

par(mfrow = c(1, 1))

plot(data$Time, data$Global_active_power, type = "l", xlab = "Time", ylab = 
         "Global Active Power(kilowatts)", main = "Global Active Power")

dev.off()