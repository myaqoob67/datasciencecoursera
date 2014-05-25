**Project for Getting and Cleaning Data**
==============================================

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 

### Data for Project

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Objectives

You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set
2. Extracts only the measurements on the mean and standard deviation for each measurement 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject 



### How to reproduce results

Please use the following steps to reproduce the results:

1. Open the R script run_analysis.r using RStudio
2. Change the parameter of the setwd function call to your working directory/folder
3. Please make sure data and run_analysis.R in the same parent folder
3. Run the R script run_analysis.R using source("run_analysis.R") command in RStudio


### Outputs run_analysis.R script

1. Readme.md : this file providing information on the objectives, data location, steps to reproduce, and related outputs
2. CodeBook.md : describes the variables, the data, and transformations performed to clean up the data
3. MergedDataWithDescriptiveActivity.txt : file contains both Train and Test data merged with descriptive activity code
4. TidyDataWithMeans.txt : file contains result of tidy data set with average of each varible


