
# Merging the training and the test sets to create one data set.
# uncomment the below line after adding path to your folder
# setwd("C:/DataScience/GCData/Project/")
# Read Training data and create a table
trainData <- read.table("./data/train/X_train.txt")
# Check dimensions of the training data
dim(trainData) 
# Dimensions are:  
# Check the headers for of the Training data
head(trainData)
# Read labes for training data and creat a table
trainLabel <- read.table("./data/train/y_train.txt")
table(trainLabel)
# Read subkect Training data and create a table
trainSubject <- read.table("./data/train/subject_train.txt")
# Read Test data and create a table
testData <- read.table("./data/test/X_test.txt")
# get dimensions of the Test table
dim(testData) 
# Read labels of Test data and create a table
testLabel <- read.table("./data/test/y_test.txt") 
table(testLabel) 
# Read subject Test data and create a table
testSubject <- read.table("./data/test/subject_test.txt")
# Row bind Training and Test Data tables
joinData <- rbind(trainData, testData)
dim(joinData) 
# Row bind Lables tables
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel) 
# Row bind the subject tables
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject) # 

# Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./data/features.txt")
dim(features)
#Subset data mean and standard deviation
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices) 
joinData <- joinData[, meanStdIndices]
dim(joinData) 
# remove "()"
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) 
# capitalize M
names(joinData) <- gsub("mean", "Mean", names(joinData)) 
# capitalize S
names(joinData) <- gsub("std", "Std", names(joinData)) 
# remove "-" in column names
names(joinData) <- gsub("-", "", names(joinData))  

# Uses descriptive activity names to name the activities in the data set
# read activity_labels.txt file
activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

# Appropriately labels the data set with descriptive activity names. 
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanedData)  
# write out the Merged Data With Descriptive Activity dataset
write.table(cleanedData, "MergedDataWithDescriptiveActivity.txt") 

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
subjectLen <- length(table(joinSubject)) 
activityLen <- dim(activity)[1] 
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
head(result)
# write out the Tidy Data With Means dataset
write.table(result, "TidyDataWithMeans.txt") # write out the 2nd dataset

