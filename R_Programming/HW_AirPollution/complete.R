#setwd("/Users/bor-shyangsheu/Developer/datasciencecoursera/1_R/HW_AirPollution")

complete <- function(directory, id = 1:332) {
        
        nobs <- c();

        for(i in id)
        {
        	filename <- sprintf("%03d.csv", i)          
            filepath <- paste(".", directory, filename, sep="/")

            pollutantData <- read.csv(filepath,header=T, sep=',')
            completeData <-  pollutantData[complete.cases(pollutantData),]
            #completeData <- subset(pollutantData, complete.cases(pollutantData) )
            nobs <- c(nobs, nrow(completeData))
        }

        return(data.frame(cbind(id, nobs)))
}

## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
