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

# Plot 1
hist(subSource$Global_active_power, main = "Global Active Power", xlab = "Global Active Power(kilowatts)", 
	col = "red")
dev.copy(png, file = "plot1.png")
dev.off()
