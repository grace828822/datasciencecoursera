#load the Data
#source("loadData.R")
NEIdata <- readRDS("data/summarySCC_PM25.rds")
SCCdata <- readRDS("data/Source_Classification_Code.rds")

library(ggplot2)

# Baltimore City, Maryland == fips 24510
# MarylandData <- subset(NEIdata, fips == 24510)
# MarylandData$year <- factor(MarylandData$year, levels = c('1999', '2002', '2005', '2008'))
MarylandData <- NEIdata[NEIdata$fips == "24510", ]

png('plot3.png', width = 800, height = 500, units = 'px')

#================= line plot
g <- ggplot(data = MarylandData, aes(year, Emissions, color = type))
g + geom_line(stat = "summary", fun.y="sum") + ylab("Total Particle Emission") + ggtitle("Total Particle Emission in Baltimore, Maryland\n by emission type from 1999 until 2008")
dev.off()

#================= box plot
ggplot(data = MarylandData, aes(x = year, y = log(Emissions))) + facet_grid(. ~ type) + guides(fill = F) + geom_boxplot(aes(fill = type)) + stat_boxplot(geom = 'errorbar') + ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + ggtitle('Emissions per Type in Baltimore City, Maryland') + geom_jitter(alpha = 0.10)
dev.off()

#================= bar plot 
png('plot3.png', width = 400, height = 400)
ggplot(MarylandData,aes(factor(year),Emissions, color = type)) + geom_bar(stat="identity") + facet_grid(.~type,scales = "free",space="free") + labs(x="Year", y=expression("Total PM"[2.5]*" Emission")) + labs(title=expression("PM"[2.5]*" Emissions in Baltimore 1999,2002,2005,2008 by Type"))
dev.off()
