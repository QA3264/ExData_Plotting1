## Load "dplyr" library
library(dplyr)

## unzip the file and save it into a tempfile variable
tempfile <- unzip("exdata-data-household_power_consumption.zip")


##read the entire file and save it in a dataframe variable (powerdata)
powerdata <- read.table(tempfile, sep =";", header = T)


## conver the data in variable "Date" from Factor to Date format
powerdata$Date <- as.Date(powerdata$Date, format = "%d/%m/%Y")

## filter the data to get data for two days 2007-02-01 and 2007-02-02
subpowerdata <- filter(powerdata, (Date == "2007-02-01" | Date =="2007-02-02") )

## conver the data for "Global Active Power"to numeric and store in variable "gap"
gap <- as.numeric(as.character(subpowerdata$Global_active_power))

## Since as.numeric funciton changes "?" to NA. remove any NAs from data (if any): 
gap <- gap[!is.na(gap)]

## Open png device; create 'plot1.png' in my working directory
png(filename = "plot1.png", width = 480, height = 480)

## plot the data using histogram function; Add title and label for X-axis.
hist(gap, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")


## Close Device
dev.off()
