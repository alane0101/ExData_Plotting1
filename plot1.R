# Require packages

packages <- c("stats", "graphics", "lubridate", "ggplot2", "grDevices")
lapply(packages, library, character.only = TRUE)

# Read data in and slice for relevant date range

unzip("./household_power_consumption.zip")

full <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

date1 <- dmy("01-02-2007")
date2 <- dmy("02-02-2007")

range <- full[(dmy(full$Date)) >= date1 & (dmy(full$Date)) <= date2,]

# Create histogram and export to PNG

png(filename = "plot1.png",
    width = 480, height = 480, units = "px", 
    bg = "white")

hist(range$Global_active_power, breaks = 16, col = "red", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")

dev.off()