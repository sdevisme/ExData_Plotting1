## Coursera : Data Science Specialization / Exploratory Data Analysis Course Projet week 1

## R SCRIPT FOR PRODUCT PLOT 3
file = "household_power_consumption.txt"

data <- read.table(file, sep = ";", header = TRUE, na.string = "?")

head(data)

class(data$Date)

data$DateToChar <- as.character(data$Date)

data$Dateformat <- strptime(data$DateToChar, format = "%d/%m/%Y")

data$DateformatDate <- as.Date(data$Dateformat)

## Subsetting Data for 2 days

dataFor2Days <- subset(data, 
                       DateformatDate >= "2007-02-01" & DateformatDate <= "2007-02-02", 
                       select = c(DateformatDate, DateToChar, Time, Global_active_power, 
                                  Global_reactive_power, Voltage, Global_intensity, 
                                  Sub_metering_1, Sub_metering_2, Sub_metering_3))


## Format Data

dataFor2Days$TimeToChar <- as.character(dataFor2Days$Time)
dataFor2Days$DayTime <- strptime(paste(dataFor2Days$DateToChar, dataFor2Days$TimeToChar), "%d/%m/%Y %H:%M:%S")

## Construct PLOT

par(mfrow = c(2,2))

# plot1
with(dataFor2Days, plot(DayTime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)"))
lines(dataFor2Days$DayTime, dataFor2Days$Global_active_power)

# plot2
with(dataFor2Days, plot(DayTime, Voltage, type = "n", xlab = "datetime", ylab = "Voltage"))
lines(dataFor2Days$DayTime, dataFor2Days$Voltage)

# plot3
with(dataFor2Days, plot(DayTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
lines(dataFor2Days$DayTime, dataFor2Days$Sub_metering_1)
lines(dataFor2Days$DayTime, dataFor2Days$Sub_metering_2, col = "red")
lines(dataFor2Days$DayTime, dataFor2Days$Sub_metering_3, col = "blue")
legend("topright", cex = .7, col = c("black", "red", "blue"), lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot4
with(dataFor2Days, plot(DayTime, Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power"))
lines(dataFor2Days$DayTime, dataFor2Days$Global_reactive_power)

## Copying plot to png file

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
