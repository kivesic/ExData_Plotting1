### loading the dataset and extracting the requested dates ###

# read a file
data <- read.csv(file="household_power_consumption.txt", na.strings="?", sep=";")

# convert the date to a date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y" )

# extract only the required dates
subset <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02") , ]

# calculate datetime form plots
datetime <- as.POSIXlt(paste(subset$Date, subset$Time, sep=" "))

### Creating the 3rd plot ###

# Load the PNG device
png(file="plot3.png")

# set the background to a transparent color
par(bg=rgb(0,0,0,0))

# save system's current time locale:
timeLocale <- Sys.getlocale(category="LC_TIME")

# set the time locale to English to be able to print English weekday names
Sys.setlocale(category="LC_TIME", locale = "English")

# Draw plots
plot(datetime, subset$Sub_metering_1, ylab="Energy sub metering", xlab="", type="l")
lines(x=datetime, y=subset$Sub_metering_2, col="red")
lines(x=datetime, y=subset$Sub_metering_3, col="blue")

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty="solid")
  
# Close the driver
dev.off()

#restore time locale
Sys.setlocale(category="LC_TIME", locale = timeLocale)