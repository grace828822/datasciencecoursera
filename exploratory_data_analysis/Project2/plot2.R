#load the Data
#source("loadData.R")
NEIdata <- readRDS("data/summarySCC_PM25.rds")
SCCdata <- readRDS("data/Source_Classification_Code.rds")

# Samples data for testing
# NEIsample <- NEIdata[sample(nrow(NEIdata), size = 5000, replace = F), ]

# Subsets data 
Maryland <- subset(NEIdata, fips == '24510')

png(filename = 'plot2.png')
barplot(tapply(X = Maryland$Emissions, INDEX = Maryland$year, FUN = sum), 
	main = 'Total Emission in Baltimore City, Maryland', 
	xlab = 'Year', ylab = expression('PM'[2.5]),col = "lemonchiffon")
dev.off()