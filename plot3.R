# Require packages

packages <- c("stats", "graphics", "lubridate", "ggplot2", "grDevices")
lapply(packages, library, character.only = TRUE)

# Read data in and slice for relevant date range

unzip("./household_power_consumption.zip")

full <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

date1 <- dmy("01-02-2007")
date2 <- dmy("02-02-2007")

range <- full[(dmy(full$Date)) >= date1 & (dmy(full$Date)) <= date2,]

# Merge Date and Time, convert to "%Y-%m-%d %H:%M:%S"

dateMaker <- function(row){
  date <- dmy(row["Date"])
  clock <- row["Time"]
  both <- paste(date, clock)
}

xaxis <- apply(as.data.frame(range), 1, dateMaker)

# Create plot and export to PNG

png(filename = "plot3.png",
    width = 480, height = 480, units = "px", 
    bg = "white")

plot(strptime(xaxis, format = "%Y-%m-%d %H:%M:%S", tz = ""), range$Sub_metering_1, 
     type = "l", ylab = "Energy sub metering", xlab = "", col = "black")
lines(strptime(xaxis, format = "%Y-%m-%d %H:%M:%S", tz = ""), range$Sub_metering_2, 
      type = "l", ylab = "Energy sub metering", xlab = "", col = "red")
lines(strptime(xaxis, format = "%Y-%m-%d %H:%M:%S", tz = ""), range$Sub_metering_3, 
      type = "l", ylab = "Energy sub metering", xlab = "", col = "blue")
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"), border = "black")

dev.off()

