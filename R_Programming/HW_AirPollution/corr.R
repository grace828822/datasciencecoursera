
corr <- function(directory, threshold = 0) {
	
	correlations <- c()
	
	for(i in 1:332){

		filename <- sprintf("%03d.csv", i)          
        filepath <- paste(".", directory, filename, sep="/")
		pollutantData <- read.csv(filepath,header=T, sep=',')
		completeData <-  pollutantData[complete.cases(pollutantData),]
		if (nrow(completeData) > threshold) {
        	correlations <- c(correlations, cor(completeData$sulfate, completeData$nitrate))
    	}
	}
	
	correlations
}

## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Returns a numeric vector of correlations
		