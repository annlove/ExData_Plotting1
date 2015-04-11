# Downlaod & load file into memory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
	"household_power_consumption.zip", method = "curl")
unzip("household_power_consumption.zip")
source <- read.csv("household_power_consumption.txt", sep = ";", na.strings = c("?"))
str(source)

# Convert Date/Time
# source$Date <- as.Date(source$Date, format = '%d/%m/%Y')
DateTime <- c(paste(source$Date, " ", source$Time))
source <- cbind(source, DateTime)
source$DateTime <- strptime(source$DateTime, format = "%d/%m/%Y %H:%M:%S")

#Arrange columns order
names(source)
col <- c(names(source[10]), as.character(names(source[3:9])))
source <- source[, col]

dateFrame <- source$DateTime > strptime("2007/02/01", format = "%Y/%m/%d") & source$DateTime < 
	strptime("2007/02/03", format = "%Y/%m/%d")
subSource <- source[dateFrame, ]

# Set locale for date abbriviation
Sys.setlocale("LC_TIME", "C")

#Plot 4
par(mfrow = c(2, 2))
with(subSource, {
	# 1-1
	plot(DateTime, Global_active_power, type = "n", ylab = "Global Active Power", 
		xlab = "")
	lines(DateTime, Global_active_power)
	# 1-2
	plot(DateTime, Voltage, type = "n", ylab = "Voltage", xlab = "datetime")
	lines(DateTime, Voltage)
	# 2-1
	plot(DateTime, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
	lines(DateTime, Sub_metering_1)
	lines(DateTime, Sub_metering_2, col = "red")
	lines(DateTime, Sub_metering_3, col = "blue")
	legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", 
		"Sub_metering_2", "Sub_metering_3"), lwd = 1.5, bty = "n")
	# 2-2
	plot(DateTime, Global_reactive_power, type = "n", ylab = "Global_reactive_power", 
		xlab = "datetime")
	lines(DateTime, Global_reactive_power)
})
dev.copy(png, "plot4.png")
dev.off()
