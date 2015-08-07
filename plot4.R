## Load "dplyr" library
library(dplyr)

## unzip the file and save it into a tempfile variable
tempfile <- unzip("exdata-data-household_power_consumption.zip")

##read the entire file and save it in a dataframe variable (powerdata)
powerdata <- read.table(tempfile, sep =";", header = T)

## convert the data in variable "Date" from Factor to Date format
powerdata$Date <- as.Date(powerdata$Date, format = "%d/%m/%Y")

## filter the data to get data for two days 2007-02-01 and 2007-02-02
subpowerdata <- filter(powerdata, (Date == "2007-02-01" | Date =="2007-02-02") )

## combine Data and time variables into one and save to datetime
datetime <- strptime(paste(subpowerdata$Date, subpowerdata$Time), format="%Y-%m-%d %H:%M:%S")


## conver the data for "Global Active Power" to numeric
gap <- as.numeric(as.character(subpowerdata$Global_active_power))
## remove any NAs from data (if any)
gap <- gap[!is.na(gap)]

## conver the data for "Voltage" to numeric
voltage <- as.numeric(as.character(subpowerdata$Voltage))
## remove any NAs from data (if any)
voltage <- voltage[!is.na(voltage)]

## conver the data for "Sub_metering_1" to numeric
submeter1 <- as.numeric(as.character(subpowerdata$Sub_metering_1))
## remove any NAs from data (if any)
submeter1 <- submeter1[!is.na(submeter1)]

## conver the data for "Sub_metering_2" to numeric
submeter2 <- as.numeric(as.character(subpowerdata$Sub_metering_2))
## remove any NAs from data (if any)
submeter2 <- submeter2[!is.na(submeter2)]

## conver the data for "Sub_metering_3" to numeric
submeter3 <- as.numeric(as.character(subpowerdata$Sub_metering_3))
## remove any NAs from data (if any)
submeter3 <- submeter3[!is.na(submeter3)]

## conver the data for "Global rective Power" to numeric
grp <- as.numeric(as.character(subpowerdata$Global_reactive_power))
## remove any NAs from data (if any)
grp <- grp[!is.na(grp)]

## Open png device; create 'plot4.png' in my working directory
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))
par(mar = c(4,4,4,2))

## plot the "Global Active Power" data using plot function
plot(datetime, gap, type="l", xlab ="", ylab = "Global Active Power (kilowatts)" )

## plot the "Voltage" data using plot function
plot(datetime, voltage, type="l", xlab ="datetime", ylab = "Voltage" )

## plot the sub_metering_1 data using plot function
plot(datetime, submeter1, type="l", xlab ="", ylab = "Energy sub metering")

# add the sub_metering_2 data using points function
points(datetime, submeter2, type="l", col= "red", xlab ="")

# add the sub_metering_3 data using points function
points(datetime, submeter3, type="l", col= "blue", xlab ="")

## add Legend to the plot
labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright",labels, lwd =1,col=c("black", "red", "blue"), lty =c(1,1,1), bty = "n")

## plot the "Global reactive power" data using plot function
plot(datetime, grp, type="l", xlab ="datetime", ylab = "Global_reactive_power" )


## Close Device
dev.off()
