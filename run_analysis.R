library(reshape2)

#Set working directory
setwd("E:/Data Science JHU/Datacleaning/finalProject")

#Download Ddata
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFile <- "CourseDataset.zip"
if (!file.exists(destFile)){
  download.file(URL, destfile = destFile, mode='wb')
}
if (!file.exists("./UCI HAR Dataset")){
  unzip(destFile)
}

#Load the activity labels and feature
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

#extract mean and standard deviation data
neededFeatures <- grep(".*mean.*|.*std.*", features[,2])
neededFeatures.names <- features[neededFeatures,2]
neededFeatures.names = gsub('-mean', 'Mean', neededFeatures.names)
neededFeatures.names = gsub('-std', 'Std', neededFeatures.names)
neededFeatures.names <- gsub('[-()]', '', neededFeatures.names)


#load dataset
train <- read.table("UCI HAR Dataset/train/X_train.txt")[neededFeatures]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[neededFeatures]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

#merge the datasets together and add the labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", neededFeatures.names)

#transform the activities and subjects to factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
