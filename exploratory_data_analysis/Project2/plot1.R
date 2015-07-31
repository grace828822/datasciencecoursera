setwd("/Users/bor-shyangsheu/Developer/datasciencecoursera/3_exploratory_data_analysis/Project2")

#load the Data
#source("loadData.R")
NEIdata <- readRDS("data/summarySCC_PM25.rds")
SCCdata <- readRDS("data/Source_Classification_Code.rds")

# Samples data for testing
#NEIsample <- NEIdata[sample(nrow(NEIdata), size = 1000, replace = F), ]

# Aggregates sum of "Emission" by each year 
Emissions <- aggregate(NEIdata[, 'Emissions'], by = list(NEIdata$year), FUN = sum)
Emissions$PM <- round(Emissions[, 2] / 1000, 2)   # add a new column named "PM"
names(Emissions)[1] <- "Year"					  # rename 

png(filename = "plot1.png")
barplot(Emissions$PM, names.arg = Emissions$Year, col = "lemonchiffon",
	main = expression('Total Emission of PM'[2.5]),  
	xlab = 'Year', ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))
	
#Another plot
  plot(x=NEIdata$year,y=NEIdata$Emissions,type = "n", ylab="Total Emissions", xlab="Year", yaxt="n", xaxt="n",
       frame.plot = FALSE)
  smoothline<-predict(interpSpline(obj1=NEIdata$year,obj2=NEIdata$Emissions))
  lines(smoothline, col="red")
  lines(x=NEIdata$year,y=NEIdata$Emissions,col="blue")
  axis(1,at=seq(1999,2008,1),labels=seq(1999,2008,1))
  axis(2,at=seq(0,7e+06,1e+06),labels=seq(0,7e+06,1e+06))
  mtext("Total Emissions Dynamics In The United States From 1999 To 2008", side=3, line=1, outer=TRUE, cex=1)
}
	
	
#dev.copy(png, file="plot1.png")  # with transparent background
dev.off() 
