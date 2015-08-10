setwd("/Users/bor-shyangsheu/Developer/datasciencecoursera/1_R/HW_Hospital Quality")

### 1 Plot the 30-day mortality rates for heart attack\
outcome <- read.csv("HospitalData/outcome-of-care-measures.csv", colClasses = "character")

#to see the data by different ways
head(outcome)
ncol(outcome)  # 46 columns
nrow(outcome)  # 4706 rows
names(outcome) # ... column names

outcome[, 11] <- as.numeric(outcome[, 11])
# You may get a warning about NAs being introduced; that is okay
hist(outcome[, 11], main= "30-day mortality rates for heart attack")



### 2 Finding the best hospital in a state
best <- function(state, outcome) {
	
	## load the data
	outcomeData <- read.csv("HospitalData/outcome-of-care-measures.csv", sep = ",")

	## Checks that state and outcome are valid
    valid_states <- unique(outcomeData$State)  
    #valid_states <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")
    valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
    if (!is.element(state, valid_states)) stop("invalid state")
    if (!is.element(outcome, valid_outcomes)) stop("invalid outcome")

    ## Return hospital name in that state with lowest 30-day death rate
    data <- outcomeData[outcomeData$State == state,]
    header_name <- NULL
    if (outcome == "heart attack") {
        header_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    } else if (outcome == "heart failure") {
        header_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    } else {
        header_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    }

    mortality_rate <- data[,header_name]
    mortality_rate <- mortality_rate[mortality_rate != "Not Available"] #remove the "Not Available row"
    mortality_rate <- as.numeric(as.character(mortality_rate)) 			# can test with the class(mortality_rate), before this line is "factor", after is "numeric"

    min_rate <- min(mortality_rate)
    best_hosps <- data[data[,header_name] == min_rate,]
    hosp_names <- sort(best_hosps[,"Hospital.Name"])
    return(as.character(hosp_names[1]))
        
}


