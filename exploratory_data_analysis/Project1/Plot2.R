#read the data
wholeData <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?")
wholeData$Date <- as.Date(wholeData$Date, format="%d/%m/%Y")

# extract the data we want to use
data <- subset(wholeData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(wholeData)

# Converting dates and add a column Datetime 
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 2
plot(data$Global_active_power~data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()