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

png(filename = "plot2.png",
    width = 480, height = 480, units = "px", 
    bg = "white")

plot(strptime(xaxis, format = "%Y-%m-%d %H:%M:%S", tz = ""), range$Global_active_power, 
     type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()