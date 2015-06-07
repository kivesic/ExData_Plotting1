### loading the dataset and extracting the requested dates ###

# read a file
data <- read.csv(file="household_power_consumption.txt", na.strings="?", sep=";")

# convert the date to a date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y" )

# extract only the required dates
subset <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02") , ]

# calculate datetime form plots
dateTime <- as.POSIXlt(paste(subset$Date, subset$Time, sep=" "))

### Creating the 4th plot ###

# Load the PNG device
png(file="plot4.png")

# set the background to a transparent color
par(bg=rgb(0,0,0,0))

# save system's current time locale:
timeLocale <- Sys.getlocale(category="LC_TIME")

# set the time locale to English to be able to print English weekday names
Sys.setlocale(category="LC_TIME", locale = "English")

### Draw plots ###

# define 2 x 2 grid for the four plots
par(mfrow=c(2,2))

# 1st plot
plot(dateTime, subset$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

# 2nd plot
plot(dateTime, subset$Voltage, type="l", ylab="Voltage")

# 3rd plot
plot(dateTime, subset$Sub_metering_1, ylab="Energy sub metering", xlab="", type="l")
lines(x=dateTime, y=subset$Sub_metering_2, col="red")
lines(x=dateTime, y=subset$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), 
       lty="solid", cex=0.95, bty="n")

# 4th plot
plot(dateTime, subset$Global_reactive_power, type="l", ylab="Global_reactive_power")

# Close the driver
dev.off()

#restore time locale
Sys.setlocale(category="LC_TIME", locale = timeLocale)