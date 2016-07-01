# plot3.R
# Creates a timeseries of Energy sub metering

# Only download the data file if it hasn't already been downloaded & extracted
if (!file.exists("household_power_consumption.txt")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, 
                destfile = "household_power_consumption.zip", 
                method="curl") 
  unzip('household_power_consumption.zip')
}

# Data of interest: the two-day period between 2007-02-01 and 2007-02-02 
# (yyyy-mm-dd). Only reading data from that range (lines 66638 - 69517). 
# Note: Raw data is in the format dd/mm/yyyy
consumption_data <- read.table("household_power_consumption.txt", 
                               header=FALSE, sep=";", 
                               skip=66637, nrows=2879,
                               col.names=c("Date","Time","Global_active_power",
                                           "Global_reactive_power","Voltage",
                                           "Global_intensity","Sub_metering_1",
                                           "Sub_metering_2","Sub_metering_3"))

library(dplyr)
consumption_data <- mutate(consumption_data,Date=as.Date(Date,format="%d/%m/%Y"))
consumption_data <- mutate(consumption_data,
                           Time=as.POSIXct(paste(consumption_data$Date, 
                                                 as.character(consumption_data$Time))))

# Finally, create the plot in png format
png("plot3.png")
plot(consumption_data$Time,consumption_data$Sub_metering_1,
     type="l",xlab="",ylab="Energy sub metering")
lines(consumption_data$Time,consumption_data$Sub_metering_2
      ,col="red")
lines(consumption_data$Time,consumption_data$Sub_metering_3
      ,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))
dev.off()
