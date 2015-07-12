#read the data
wholeData <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?")
wholeData$Date <- as.Date(wholeData$Date, format="%d/%m/%Y")

# extract the data we want to use
data <- subset(wholeData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(wholeData)

# Converting dates and add a column Datetime 
data$Datetime <- paste(as.Date(data$Date), data$Time)

## Plot 1
hist(data$Global_active_power, 
	main = "Global Active Power", 
    xlab = "Global Active Power (kilowatts)", 
    ylab = "Frequency", 
    col = "Red")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

