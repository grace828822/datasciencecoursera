#load the Data
#source("loadData.R")
NEIdata <- readRDS("data/summarySCC_PM25.rds")
SCCdata <- readRDS("data/Source_Classification_Code.rds")

library(ggplot2)


Maryland_onroad <- subset(NEIdata, fips == '24510' & type == 'ON-ROAD') # Baltimore City, Maryland
California_onroad <- subset(NEIdata, fips == '06037' & type == 'ON-ROAD') # Los Angeles County, California

Maryland_yearSum <- aggregate(Maryland_onroad[, 'Emissions'], by = list(Maryland_onroad$year), sum)
colnames(Maryland_yearSum) <- c('year', 'Emissions')
Maryland_yearSum$City <- paste(rep('Maryland', 4))

California_yearSum <- aggregate(California_onroad[, 'Emissions'], by = list(California_onroad$year), sum)
colnames(California_yearSum) <- c('year', 'Emissions')
California_yearSum$City <- paste(rep('California', 4))

CombinedData <- as.data.frame(rbind(Maryland_yearSum, California_yearSum))


png('plot6.png')
ggplot(data = CombinedData, aes(x = year, y = Emissions)) + geom_bar(aes(fill = year),stat = "identity") + guides(fill = F) + ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles Country, California vs. Baltimore City, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + facet_grid(. ~ City) + geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))
dev.off()