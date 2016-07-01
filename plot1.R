# plot1.R
# Creates a histogram of Global Active Power in kilowatts

# Only download the data file if it hasn't already been downloaded & extracted
if (!file.exists("household_power_consumption.txt")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, 
                destfile = "household_power_consumption.zip", 
                method="curl") 
  unzip('household_power_consumption.zip')
}

# Data of interest: two-day period between 2007-02-01 and 2007-02-02 
# (yyyy-mm-dd). Only reading data from that range (lines 66638 - 69517). 
# Note: Raw data is in the format dd/mm/yyyy
consumption_data <- read.table("household_power_consumption.txt", 
                               header=FALSE, sep=";", 
                               skip=66637, nrows=2879,
                               col.names=c("Date","Time", "Global_active_power",
                                           "Global_reactive_power", "Voltage",
                                           "Global_intensity", "Sub_metering_1",
                                           "Sub_metering_2", "Sub_metering_3"))

# Finally, create the plot in png format
png("plot1.png")
hist(consumption_data$Global_active_power, 
     col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
