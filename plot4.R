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

# plot 4
png(filename = "plot4.png",
    width = 480, 
    height = 480)

par(mfrow = c(2,2))
with(data.hpc, 
{
  plot(Global_active_power ~ Datetime, 
       type = "l", 
       xlab = "",
       ylab = "Global Active Power")
  plot(Voltage ~ Datetime, 
       type = "l", 
       xlab = "datetime", 
       ylab = "Voltage")
  plot(Sub_metering_1 ~ Datetime,
       type = "l",
       xlab = "",
       ylab = "Energy sub metering")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
  legend("topright", 
         col = c("black", "red", "blue"), 
         lty = 1, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ Datetime, 
       type = "l", 
       xlab = "datetime",
       ylab = "Global_reactive_power")
}
)

dev.off()