### loading the dataset and extracting the requested dates ###

# read a file
data <- read.csv(file="household_power_consumption.txt", na.strings="?", sep=";")

# convert the date to a date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y" )

# extract only the required dates
subset <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02") , ]

# calculate datetime form plots
dateTime <- as.POSIXlt(paste(subset$Date, subset$Time, sep=" "))


### Creating the 1st plot ###

# Load the PNG device
png(file="plot1.png")

# set the background to a transparent color
par(bg=rgb(0,0,0,0))

# Draw a plot
hist(subset$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")

# Close the driver
dev.off()