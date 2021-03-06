## Coursera : Data Science Specialization / Exploratory Data Analysis Course Projet week 1

## R SCRIPT FOR PRODUCT PLOT 1
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


## Construct PLOT

hist(dataFor2Days$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

## Copying plot to png file

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()