setwd("/Users/bor-shyangsheu/Developer/datasciencecoursera/2_Get&CleanData/Project")

#1 get the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./Dataset.zip", method = "curl")
unzip("Dataset.zip")


#2) [ Step 1 ] Merges the training and the test sets to create one data set.
tmp1 <- read.table("Dataset/train/X_train.txt")
tmp2 <- read.table("Dataset/test/X_test.txt")
X <- rbind(tmp1, tmp2)

tmp1 <- read.table("Dataset/train/subject_train.txt")
tmp2 <- read.table("Dataset/test/subject_test.txt")
S <- rbind(tmp1, tmp2)

tmp1 <- read.table("Dataset/train/y_train.txt")
tmp2 <- read.table("Dataset/test/y_test.txt")
Y <- rbind(tmp1, tmp2)


#3) [ Step 2 ] Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("Dataset/features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2]) #extract the word has mean or std in it
X <- X[, indices_of_good_features] 					#select the columns that we need by indices_of_good_features(only select the mean and std columns)
names(X) <- features[indices_of_good_features, 2] 	#rename the title of columns
names(X) <- gsub("\\(|\\)", "", names(X))  			#subtitue the () with "" nothing , 去掉()
names(X) <- tolower(names(X))						#transform all char to lower cases


#4) [ Step 3 ] Uses descriptive activity names to name the activities in the data set
activities <- read.table("Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2]))) # subtitue and tramsform all char to lower cases
Y[,1] = activities[Y[,1], 2]		#replace the number by the true meaning
names(Y) <- "activity"				#rename the column title


#5) [ Step 4 ] Appropriately labels the data set with descriptive variable names. 
names(S) <- "subject"
cleanedData <- cbind(S, Y, X)
write.table(cleanedData, "merged_clean_data.txt")


#6) [ Step 5 ] From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
uniqueSubjects = unique(S)[,1]
numSubjects = length(unique(S)[,1])
numActivities = length(activities[,1]) # or  numActivities = nrow(activities)
numColumns = dim(cleanedData)[2]
result = cleanedData[1:(numSubjects*numActivities), ] #nrow(cleanedData) is 10299, and nrow(result) is 180
#numObserved= nrow(cleanedData)

row=1
	for (s in 1:numSubjects) {
    	for (a in 1:numActivities) {
        	result[row, 1] = uniqueSubjects[s]
        	result[row, 2] = activities[a, 2]
    	    tmp <- cleanedData[cleanedData$subject==s & cleanedData$activity==activities[a, 2], ]
    	    result[row, 3:numColumns] <- colMeans(tmp[, 3:numColumns])
    	    row= row +1
    	}
    }

write.table(result, "Result_AverageDataSet.txt")





