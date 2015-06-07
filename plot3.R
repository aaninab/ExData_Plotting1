setwd("~/Documents/Coursera/Exploratory Data Analysis")
hpc <- file("household_power_consumption.txt")
data.hpc <- read.table(text = grep("^[1,2]/2/2007", readLines(hpc), value = TRUE), 
                       col.names = c("Date", 
                                     "Time", 
                                     "Global_active_power", 
                                     "Global_reactive_power", 
                                     "Voltage", 
                                     "Global_intensity", 
                                     "Sub_metering_1", 
                                     "Sub_metering_2", 
                                     "Sub_metering_3"), 
                       sep = ";", 
                       header = TRUE)
data.hpc <- data.frame(data.hpc)

#Formatting
data.hpc$Date <- as.Date(data.hpc$Date, 
                         format = "%d/%m/%Y")
Datetime <- paste(as.Date(data.hpc$Date), data.hpc$Time)
data.hpc$Datetime <- as.POSIXct(Datetime)

# plot 3
png(filename = "plot3.png",
    width = 480, 
    height = 480)

with(data.hpc, 
{
  plot(Sub_metering_1 ~ Datetime, 
       type = "l", 
       xlab = "",
       ylab = "Global Active Power (kilowatts)")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
}
)
legend("topright", 
       col = c("black", "red", "blue"), 
       lty = 1, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()