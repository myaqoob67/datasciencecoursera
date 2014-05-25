Getting and Cleaning Data Project
=================================

Codebook
========


Variable list and descriptions
------------------------------
        * Variables used

        Variable name           | Description
        ------------------------|------------------------------------------------------------------------------
        subject                 | ID the subject
        activity                | Activity name, Store training data read from "./data/activity_labels.txt"
        trainData               | Store training data read from "./data/train/X_train.txt"
        trainLabel              | Store training data read from "./data/train/y_train.txt"
        trainSubject            | Store training data read from "./data/train/subject_train.txt"
        testData                | Store test data read from "./data/test/X_test.txt"
        testLabel               | Store test data read from "./data/test/y_test.txt"
        testSubject             | Store test data read from "./data/test/subject_test.txt"
        joinData                | Store data by row joining trainData and testData
        joinLabel               | Store data by row joining trainLabel and testLabel
        joinSubject             | Store data by row joining trainSubject and testSubject
        features                | Store training data read from "./data/features.txt"
        meanStdIndices          | Store mean and Standard deviation
        cleanedData             | Store data by Column joining joinSubject, joinLabel, joinData
        result                  | Store tidy data subset
        ------------------------|-------------------------------------------------------------------------------
        
        

### Data Location

The site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Process

The script designed to perform the following steps:

* Read training data from the "./data/train" folder and store them in trainData, trainLabel and trainSubject variables respectively

* Read test data from the "./data/test" folder and store them in testData, testLabel and testsubject variables respectively

### Data dimensions
        * Data dimensions for each of the data tables


        Data table              | Dimensions
        ------------------------|------------
        trainData               | 7352  561
        trainLabel              | 7352    1
        trainSubject            | 7352    1
        testData                | 2947  561
        testLabel               | 2947    1
        testSubject             | 2947    1

* Merge testData to trainData to generate a 10299x561 data frame joinData

* Merge testLabel to trainLabel to generate a 10299x1 data frame joinLabel

* Merge testSubject to trainSubject to generate a 10299x1 data frame joinSubject

* Used the following r code to perform the merge and get aboev results

```{r}
joinData <- rbind(trainData, testData)
joinLabel <- rbind(trainLabel, testLabel)
joinSubject <- rbind(trainSubject, testSubject)
```
* Created a variable call features and stored the data read from file "./data/features.txt"

* Extracted mean and standard deviation and generated subset fo JoinData using Mean and Standard Dev.

* Performed the following cleanup of the data

        * Removed "()" in the names
        
        * Removed "_" in the names
        
        * Capitalize the first letter of mean to Mean
        
        * Capitalize the first letter of std to Std
        

* Read the file "./data/activity_labels.txt" folder and store the data using new variable called activity

* Cleaned up the activity data as follow:

        * a. Made all names to lower case
        
        * b. Remove "_"
        
        * c. Capitalize the letter following "_"
        
* Replaced the values of joinLabel according to the activity data frame

* Created a data frame called cleanData(10299X68) by joing by column the joinSubject, joinLabel and joinData

* Performed the following activity on the cleanData data frame

        * Setup proper names for the the first two columns, "subject" and "activity"
        * The "subject" column contains integers that range from 1 to 30 inclusive
        * The "activity" column contains 6 kinds of activity names
        
                V1      |    V2
                --------|--------------------
                1       | walking
                2       | walkingUpstairs
                3       | walkingDownstairs
                4       | sitting
                5       | standing
                6       | laying

        * In addition to "subject" and "activity" column, there are 66 columns measurement ranges from -1 to 1
        
* Next wrote cleanedData out to file "MergedDataWithDescriptiveActivity.txt" in current working directory

* Next calculated avarages of each activity for each Subject and stored it in data frame called result as follow:

        * 30 subjects X 6 activities = 180 combinations
        * Used 2 for loops to get 180X68 data frame


* Finally, the result was written out to "TidyDataWithMeans.txt" file in current working directory.



