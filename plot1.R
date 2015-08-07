## Load "dplyr" library
library(dplyr)

## read the entire file and save it in a dataframe(powerdata)
powerdata <- read.table("household_power_consumption.txt", sep =";")

## conver the data in variable V1 (Date) from Factor to Date format
powerdata$V1 <- as.Date(powerdata$V1, format = "%d/%m/%Y")

## filter the data to get data for two days 2007-02-01 and 2007-02-02
subpowerdata <- filter(powerdata, (V1 == "2007-02-01" | V1 =="2007-02-02") )

## conver the data for "Global Active Power" (V3) to numeric
gap <- as.numeric(as.character(subpowerdata$V3))
## remove any NAs from data 
gap <- gap[!is.na(gap)]

## Open png device; create 'plot1.png' in my working directory
png(filename = "plot1.png", width = 480, height = 480)

## plot the data using histogram function
hist(gap, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")


## Close Device
dev.off()
