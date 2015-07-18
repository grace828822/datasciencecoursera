#setwd("/Users/bor-shyangsheu/Developer/datasciencecoursera/1_R/HW_AirPollution")

pollutantmean <- function(directory, pollutant, id = 1:332) {

        combineData <- c()

        for( i in id) {

                filename <- sprintf("%03d.csv", i)          
                # filepath = "./" + directory + "/" + id +".csv" 不可用這種加的
                filepath <- paste(".", directory, filename, sep="/")

                pollutantData <- read.csv(filepath,header=T, sep=',')
                sub <- subset(pollutantData, !is.na(pollutantData[,pollutant]), select = pollutant)
                combineData <- c(combineData, sub[,pollutant]) 
        }

        #round(mean(combineData),3)
        mean(combineData)
}

## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used

        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        ## NOTE: Do not round the result!
