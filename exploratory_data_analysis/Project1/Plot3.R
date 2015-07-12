#read the data
wholeData <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?")
wholeData$Date <- as.Date(wholeData$Date, format="%d/%m/%Y")

# extract the data we want to use
data <- subset(wholeData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(wholeData)

# Converting dates and add a column Datetime 
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 3
plot(data$Sub_metering_1~data$Datetime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
lines(data$Sub_metering_2~data$Datetime, col='Red')
lines(data$Sub_metering_3~data$Datetime, col='Blue')

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()