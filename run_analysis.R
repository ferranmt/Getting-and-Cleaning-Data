#Setting the working directory:
setwd("C:/Users/ftorrent/Desktop/Getting and Cleaning Data Course Work/UCI HAR Dataset")

#1. We merge the data:

#Read x_train dataset
trainData <- read.table("./train/X_train.txt")
#Read y_train dataset
trainLabel <- read.table("./train/y_train.txt")
#Read the subject_train dataset
trainSubject <- read.table("./train/subject_train.txt")
#Read the x_test dataset
testData <- read.table("./test/X_test.txt")
#Read the y_test dataset
testLabel <- read.table("./test/y_test.txt") 
#Read the test subject_train dataset
testSubject <- read.table("./test/subject_test.txt")
#Join the train and test data:
joinData <- rbind(trainData, testData)
#Join the train and test Subject:
joinSubject <-rbind(trainSubject, testSubject)
#Join the train and test Labels:
joinLabel<- rbind(trainLabel, testLabel)

#2. We extract only the measurements on the mean and standard deviation for each measurement:

#Read and store the features dataset:
features <- read.table("./features.txt")
#Get the values for mean and std from the features dataset:
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
#Merge the joinData with the values obtained before:
joinData <- joinData[, meanStdIndices]
#We make the columns in the dataset more readable, by doing those small changes:
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 

# Step3. We use descriptive activity names to name the activities in the data set:

#Read the labels that associate each activity with the Label datasets:
activity <- read.table("./activity_labels.txt")
#Put the names of the activities in lowercase:
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
#Put the activities 2 and 3 to uppercase (Upstairs and Downstairs)
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
#Create the vector activityLabel, to match the labels 1:6 to the activities:
activityLabel <- activity[joinLabel[, 1], 2]
#Put the activityLabel names in the joinLabel table, to substitute the 1:6 
#for the names of the activities.
joinLabel[, 1] <- activityLabel

#4.We label the datset with descriptive activity names.

#Just change the name of the variables in the joinLabel and joinSubject tables.
names(joinLabel) <- "activity"
names(joinSubject) <- "subject"
#Merge the three datasets we have:
cleanedData <- cbind(joinSubject, joinLabel, joinData)
#Write out the 1st dataset:
write.table(cleanedData, "merged_data.txt") 

# Step5. Now we have to create a second, independent tidy data set 
# with the average of each variable for each activity and each subject. 
subjectLen <- length(table(joinSubject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleanedData$subject
    bool2 <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}

#And we store the final, clean table in a new file called data_with_means:
write.table(result, "data_with_means.txt", ) # write out the 2nd dataset
data <- read.table("./data_with_means.txt")
data[1:12, 1:3]

