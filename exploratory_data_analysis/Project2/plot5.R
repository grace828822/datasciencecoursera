#load the Data
#source("loadData.R")
NEIdata <- readRDS("data/summarySCC_PM25.rds")
SCCdata <- readRDS("data/Source_Classification_Code.rds")

library(ggplot2)

# Baltimore City, Maryland == fips
Maryland_onroad <- subset(NEIdata, fips == 24510 & type == 'ON-ROAD')

# Aggregates
Maryland_yearSum <- aggregate(Maryland_onroad[, 'Emissions'], by = list(Maryland_onroad$year), sum)
colnames(Maryland_yearSum) <- c('year', 'Emissions')

png('plot5.png')
ggplot(data = Maryland_yearSum, aes(x = year, y = Emissions)) + geom_bar(aes(fill = year), stat = "identity") + guides(fill = F) + ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = 2))
dev.off()