run_analysis
============
Last updated 2014-05-25 12:31:34 using R version 3.0.3 (2014-03-06).


Objectives of the project
------------------------

> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  
> 
> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
> 
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
> 
> Here are the data for the project: 
> 
> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
> 
> You should create one R script called run_analysis.R that does the following. 
> 
> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set.
> 4. Appropriately labels the data set with descriptive activity names.
> 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
> 


Read the files
--------------

Read the data files.


```r
trainData <- read.table("./data/train/X_train.txt")
trainLabel <- read.table("./data/train/y_train.txt")
trainSubject <- read.table("./data/train/subject_train.txt")
testData <- read.table("./data/test/X_test.txt")
testLabel <- read.table("./data/test/y_test.txt")
testSubject <- read.table("./data/test/subject_test.txt")
```


Data structures
------------------------------------

### Training Data Structures

#### TrainData:

```r
summary(trainData)
```

```
##        V1               V2                V3                V4        
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.: 0.263   1st Qu.:-0.0249   1st Qu.:-0.1210   1st Qu.:-0.993  
##  Median : 0.277   Median :-0.0172   Median :-0.1087   Median :-0.946  
##  Mean   : 0.275   Mean   :-0.0177   Mean   :-0.1091   Mean   :-0.605  
##  3rd Qu.: 0.288   3rd Qu.:-0.0108   3rd Qu.:-0.0978   3rd Qu.:-0.243  
##  Max.   : 1.000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.000  
##        V5                V6               V7               V8         
##  Min.   :-0.9999   Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.:-0.9781   1st Qu.:-0.980   1st Qu.:-0.994   1st Qu.:-0.9782  
##  Median :-0.8519   Median :-0.859   Median :-0.951   Median :-0.8573  
##  Mean   :-0.5109   Mean   :-0.605   Mean   :-0.630   Mean   :-0.5269  
##  3rd Qu.:-0.0342   3rd Qu.:-0.262   3rd Qu.:-0.293   3rd Qu.:-0.0667  
##  Max.   : 0.9162   Max.   : 1.000   Max.   : 1.000   Max.   : 0.9677  
##        V9              V10               V11               V12        
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.980   1st Qu.:-0.9362   1st Qu.:-0.5636   1st Qu.:-0.813  
##  Median :-0.857   Median :-0.8816   Median :-0.4797   Median :-0.737  
##  Mean   :-0.606   Mean   :-0.4686   Mean   :-0.3060   Mean   :-0.557  
##  3rd Qu.:-0.266   3rd Qu.:-0.0171   3rd Qu.:-0.0654   3rd Qu.:-0.332  
##  Max.   : 1.000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.000  
##       V13              V14              V15              V16        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.: 0.197   1st Qu.: 0.102   1st Qu.: 0.390   1st Qu.:-0.983  
##  Median : 0.792   Median : 0.628   Median : 0.778   Median :-0.885  
##  Mean   : 0.524   Mean   : 0.387   Mean   : 0.594   Mean   :-0.548  
##  3rd Qu.: 0.844   3rd Qu.: 0.686   3rd Qu.: 0.837   3rd Qu.:-0.107  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V17              V18              V19              V20        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.994  
##  Median :-0.998   Median :-0.994   Median :-0.986   Median :-0.958  
##  Mean   :-0.820   Mean   :-0.902   Mean   :-0.846   Mean   :-0.684  
##  3rd Qu.:-0.711   3rd Qu.:-0.817   3rd Qu.:-0.748   3rd Qu.:-0.393  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V21              V22              V23               V24        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.982   1st Qu.:-0.980   1st Qu.:-0.5734   1st Qu.:-0.560  
##  Median :-0.896   Median :-0.865   Median :-0.0734   Median :-0.137  
##  Mean   :-0.644   Mean   :-0.631   Mean   :-0.1030   Mean   :-0.138  
##  3rd Qu.:-0.310   3rd Qu.:-0.316   3rd Qu.: 0.3365   3rd Qu.: 0.280  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 0.9197   Max.   : 1.000  
##       V25              V26              V27               V28         
##  Min.   :-1.000   Min.   :-0.926   Min.   :-0.9631   Min.   :-1.0000  
##  1st Qu.:-0.505   1st Qu.:-0.365   1st Qu.:-0.0825   1st Qu.:-0.1906  
##  Median :-0.149   Median :-0.129   Median : 0.0701   Median :-0.0190  
##  Mean   :-0.164   Mean   :-0.117   Mean   : 0.1028   Mean   :-0.0378  
##  3rd Qu.: 0.164   3rd Qu.: 0.133   3rd Qu.: 0.2769   3rd Qu.: 0.1286  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 0.9784   Max.   : 1.0000  
##       V29               V30               V31               V32         
##  Min.   :-0.8221   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.0239   1st Qu.:-0.2219   1st Qu.:-0.1354   1st Qu.: 0.0344  
##  Median : 0.1341   Median :-0.0407   Median : 0.0117   Median : 0.1684  
##  Mean   : 0.1305   Mean   :-0.0262   Mean   : 0.0263   Mean   : 0.1600  
##  3rd Qu.: 0.2853   3rd Qu.: 0.1723   3rd Qu.: 0.1778   3rd Qu.: 0.2934  
##  Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000  
##       V33               V34               V35               V36         
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-0.7538   Min.   :-1.0000  
##  1st Qu.:-0.1688   1st Qu.:-0.2073   1st Qu.:-0.1235   1st Qu.:-0.1065  
##  Median :-0.0224   Median : 0.0290   Median : 0.0033   Median : 0.0494  
##  Mean   :-0.0196   Mean   : 0.0094   Mean   : 0.0333   Mean   : 0.0366  
##  3rd Qu.: 0.1309   3rd Qu.: 0.2310   3rd Qu.: 0.1756   3rd Qu.: 0.1956  
##  Max.   : 1.0000   Max.   : 0.8146   Max.   : 1.0000   Max.   : 0.9972  
##       V37               V38               V39               V40        
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-0.972  
##  1st Qu.:-0.2389   1st Qu.:-0.3739   1st Qu.:-0.4035   1st Qu.:-0.148  
##  Median :-0.0819   Median :-0.1637   Median :-0.1897   Median : 0.147  
##  Mean   :-0.0786   Mean   :-0.1251   Mean   :-0.1938   Mean   : 0.105  
##  3rd Qu.: 0.0792   3rd Qu.: 0.0708   3rd Qu.: 0.0052   3rd Qu.: 0.382  
##  Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.000  
##       V41              V42              V43               V44        
##  Min.   :-1.000   Min.   :-0.535   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.: 0.805   1st Qu.:-0.239   1st Qu.:-0.1239   1st Qu.:-0.995  
##  Median : 0.919   Median :-0.144   Median : 0.0264   Median :-0.982  
##  Mean   : 0.664   Mean   : 0.011   Mean   : 0.0939   Mean   :-0.965  
##  3rd Qu.: 0.953   3rd Qu.: 0.148   3rd Qu.: 0.2330   3rd Qu.:-0.961  
##  Max.   : 0.992   Max.   : 1.000   Max.   : 1.0000   Max.   : 1.000  
##       V45              V46              V47              V48        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.992   1st Qu.:-0.987   1st Qu.:-0.995   1st Qu.:-0.992  
##  Median :-0.976   Median :-0.966   Median :-0.983   Median :-0.977  
##  Mean   :-0.954   Mean   :-0.937   Mean   :-0.965   Mean   :-0.955  
##  3rd Qu.:-0.947   3rd Qu.:-0.928   3rd Qu.:-0.962   3rd Qu.:-0.949  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V49              V50              V51               V52         
##  Min.   :-1.000   Min.   :-1.000   Min.   :-0.4939   Min.   :-1.0000  
##  1st Qu.:-0.987   1st Qu.: 0.743   1st Qu.:-0.2461   1st Qu.:-0.1158  
##  Median :-0.967   Median : 0.857   Median :-0.1516   Median : 0.0368  
##  Mean   :-0.938   Mean   : 0.604   Mean   :-0.0033   Mean   : 0.0990  
##  3rd Qu.:-0.930   3rd Qu.: 0.887   3rd Qu.: 0.1416   3rd Qu.: 0.2313  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 0.9683   Max.   : 0.9966  
##       V53              V54               V55               V56         
##  Min.   :-1.000   Min.   :-0.5682   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.: 0.804   1st Qu.:-0.2254   1st Qu.:-0.1421   1st Qu.:-0.3985  
##  Median : 0.927   Median :-0.1293   Median : 0.0127   Median :-0.1089  
##  Mean   : 0.678   Mean   : 0.0232   Mean   : 0.0806   Mean   :-0.0783  
##  3rd Qu.: 0.965   3rd Qu.: 0.1407   3rd Qu.: 0.2240   3rd Qu.: 0.2275  
##  Max.   : 1.000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000  
##       V57              V58              V59              V60        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.: 0.504   1st Qu.:-0.967   1st Qu.:-0.990   1st Qu.:-0.995  
##  Median : 0.785   Median :-0.910   Median :-0.942   Median :-0.985  
##  Mean   : 0.437   Mean   :-0.730   Mean   :-0.745   Mean   :-0.968  
##  3rd Qu.: 0.872   3rd Qu.:-0.769   3rd Qu.:-0.741   3rd Qu.:-0.965  
##  Max.   : 0.976   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V61              V62              V63              V64        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.993   1st Qu.:-0.988   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.980   Median :-0.971   Median :-0.745   Median :-1.000  
##  Mean   :-0.958   Mean   :-0.943   Mean   :-0.667   Mean   :-0.869  
##  3rd Qu.:-0.953   3rd Qu.:-0.936   3rd Qu.:-0.392   3rd Qu.:-0.872  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V65              V66              V67              V68        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-0.660   1st Qu.: 0.414   1st Qu.:-0.748  
##  Median :-0.870   Median :-0.521   Median : 0.565   Median :-0.609  
##  Mean   :-0.685   Mean   :-0.516   Mean   : 0.553   Mean   :-0.590  
##  3rd Qu.:-0.425   3rd Qu.:-0.378   3rd Qu.: 0.703   3rd Qu.:-0.447  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V69              V70              V71              V72        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-0.954   Min.   :-1.000  
##  1st Qu.: 0.478   1st Qu.:-0.541   1st Qu.: 0.127   1st Qu.:-0.556  
##  Median : 0.652   Median :-0.342   Median : 0.327   Median :-0.360  
##  Mean   : 0.626   Mean   :-0.345   Mean   : 0.331   Mean   :-0.360  
##  3rd Qu.: 0.793   3rd Qu.:-0.147   3rd Qu.: 0.532   3rd Qu.:-0.170  
##  Max.   : 1.000   Max.   : 0.813   Max.   : 1.000   Max.   : 1.000  
##       V73              V74              V75              V76        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-0.618   Min.   :-1.000  
##  1st Qu.: 0.227   1st Qu.:-0.623   1st Qu.: 0.278   1st Qu.:-0.667  
##  Median : 0.420   Median :-0.430   Median : 0.453   Median :-0.480  
##  Mean   : 0.407   Mean   :-0.431   Mean   : 0.456   Mean   :-0.481  
##  3rd Qu.: 0.603   3rd Qu.:-0.248   3rd Qu.: 0.645   3rd Qu.:-0.305  
##  Max.   : 1.000   Max.   : 0.649   Max.   : 1.000   Max.   : 0.586  
##       V77              V78              V79              V80         
##  Min.   :-0.554   Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.: 0.330   1st Qu.:-0.469   1st Qu.:-0.809   1st Qu.:-0.6067  
##  Median : 0.504   Median : 0.393   Median :-0.217   Median : 0.1852  
##  Mean   : 0.502   Mean   : 0.187   Mean   :-0.105   Mean   : 0.0887  
##  3rd Qu.: 0.687   3rd Qu.: 0.845   3rd Qu.: 0.597   3rd Qu.: 0.7845  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.0000  
##       V81               V82               V83               V84        
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.: 0.0636   1st Qu.:-0.0167   1st Qu.:-0.0308   1st Qu.:-0.992  
##  Median : 0.0760   Median : 0.0107   Median :-0.0011   Median :-0.959  
##  Mean   : 0.0791   Mean   : 0.0086   Mean   :-0.0047   Mean   :-0.644  
##  3rd Qu.: 0.0910   3rd Qu.: 0.0325   3rd Qu.: 0.0248   3rd Qu.:-0.288  
##  Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.000  
##       V85              V86              V87              V88        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.986   1st Qu.:-0.990   1st Qu.:-0.992   1st Qu.:-0.985  
##  Median :-0.932   Median :-0.959   Median :-0.963   Median :-0.935  
##  Mean   :-0.611   Mean   :-0.760   Mean   :-0.640   Mean   :-0.595  
##  3rd Qu.:-0.217   3rd Qu.:-0.545   3rd Qu.:-0.279   3rd Qu.:-0.181  
##  Max.   : 0.807   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V89              V90              V91              V92        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.988   1st Qu.:-0.992   1st Qu.:-0.991   1st Qu.:-0.990  
##  Median :-0.959   Median :-0.954   Median :-0.946   Median :-0.960  
##  Mean   :-0.754   Mean   :-0.700   Mean   :-0.751   Mean   :-0.818  
##  3rd Qu.:-0.531   3rd Qu.:-0.465   3rd Qu.:-0.534   3rd Qu.:-0.681  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 0.624   Max.   : 1.000  
##       V93              V94              V95              V96        
##  Min.   :-1.000   Min.   :-0.747   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.: 0.253   1st Qu.: 0.403   1st Qu.: 0.525   1st Qu.:-0.990  
##  Median : 0.946   Median : 0.941   Median : 0.948   Median :-0.953  
##  Mean   : 0.624   Mean   : 0.688   Mean   : 0.736   Mean   :-0.648  
##  3rd Qu.: 0.990   3rd Qu.: 0.989   3rd Qu.: 0.987   3rd Qu.:-0.283  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 0.999   Max.   : 1.000  
##       V97              V98              V99              V100       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.990  
##  Median :-0.999   Median :-0.997   Median :-0.999   Median :-0.967  
##  Mean   :-0.850   Mean   :-0.828   Mean   :-0.927   Mean   :-0.629  
##  3rd Qu.:-0.744   3rd Qu.:-0.689   3rd Qu.:-0.891   3rd Qu.:-0.263  
##  Max.   : 1.000   Max.   : 0.634   Max.   : 1.000   Max.   : 1.000  
##       V101             V102             V103              V104        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.984   1st Qu.:-0.987   1st Qu.:-0.7372   1st Qu.:-0.7389  
##  Median :-0.948   Median :-0.962   Median :-0.3860   Median :-0.3191  
##  Mean   :-0.658   Mean   :-0.769   Mean   :-0.0994   Mean   :-0.0997  
##  3rd Qu.:-0.322   3rd Qu.:-0.575   3rd Qu.: 0.5896   3rd Qu.: 0.5704  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.0000   Max.   : 1.0000  
##       V105             V106             V107              V108        
##  Min.   :-1.000   Min.   :-0.975   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.729   1st Qu.:-0.357   1st Qu.: 0.0406   1st Qu.:-0.0897  
##  Median :-0.426   Median :-0.112   Median : 0.1650   Median : 0.0734  
##  Mean   :-0.134   Mean   :-0.107   Mean   : 0.1620   Mean   : 0.0636  
##  3rd Qu.: 0.497   3rd Qu.: 0.144   3rd Qu.: 0.2844   3rd Qu.: 0.2292  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.0000   Max.   : 0.9646  
##       V109              V110              V111              V112        
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.0094   1st Qu.:-0.2774   1st Qu.:-0.0687   1st Qu.: 0.0175  
##  Median : 0.1281   Median :-0.0815   Median : 0.0610   Median : 0.1849  
##  Mean   : 0.1207   Mean   :-0.0693   Mean   : 0.0644   Mean   : 0.1730  
##  3rd Qu.: 0.2573   3rd Qu.: 0.1482   3rd Qu.: 0.2039   3rd Qu.: 0.3414  
##  Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 0.9916  
##       V113             V114              V115              V116        
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-0.7991   Min.   :-1.0000  
##  1st Qu.: 0.192   1st Qu.:-0.2362   1st Qu.:-0.0426   1st Qu.:-0.1453  
##  Median : 0.327   Median :-0.0075   Median : 0.0833   Median : 0.0118  
##  Mean   : 0.322   Mean   :-0.0300   Mean   : 0.0836   Mean   :-0.0036  
##  3rd Qu.: 0.461   3rd Qu.: 0.1853   3rd Qu.: 0.2082   3rd Qu.: 0.1597  
##  Max.   : 1.000   Max.   : 0.9252   Max.   : 1.0000   Max.   : 0.9335  
##       V117              V118              V119              V120        
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-0.9595  
##  1st Qu.:-0.0151   1st Qu.:-0.3105   1st Qu.:-0.1934   1st Qu.:-0.0979  
##  Median : 0.1539   Median :-0.1447   Median : 0.0173   Median : 0.0799  
##  Mean   : 0.1395   Mean   :-0.1448   Mean   : 0.0086   Mean   : 0.0883  
##  3rd Qu.: 0.3017   3rd Qu.: 0.0201   3rd Qu.: 0.2131   3rd Qu.: 0.2686  
##  Max.   : 1.0000   Max.   : 0.9045   Max.   : 0.9933   Max.   : 1.0000  
##       V121              V122              V123              V124       
##  Min.   :-0.9140   Min.   :-0.8520   Min.   :-0.9029   Min.   :-1.000  
##  1st Qu.:-0.0434   1st Qu.:-0.1036   1st Qu.: 0.0641   1st Qu.:-0.988  
##  Median :-0.0277   Median :-0.0748   Median : 0.0861   Median :-0.911  
##  Mean   :-0.0272   Mean   :-0.0762   Mean   : 0.0866   Mean   :-0.721  
##  3rd Qu.:-0.0105   3rd Qu.:-0.0521   3rd Qu.: 0.1096   3rd Qu.:-0.478  
##  Max.   : 0.7390   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.000  
##       V125             V126             V127             V128       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.984   1st Qu.:-0.987   1st Qu.:-0.989   1st Qu.:-0.985  
##  Median :-0.917   Median :-0.890   Median :-0.918   Median :-0.924  
##  Mean   :-0.676   Mean   :-0.654   Mean   :-0.726   Mean   :-0.689  
##  3rd Qu.:-0.430   3rd Qu.:-0.333   3rd Qu.:-0.488   3rd Qu.:-0.448  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V129             V130             V131             V132       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-0.998   Min.   :-0.943  
##  1st Qu.:-0.988   1st Qu.:-0.879   1st Qu.:-0.948   1st Qu.:-0.751  
##  Median :-0.897   Median :-0.804   Median :-0.896   Median :-0.656  
##  Mean   :-0.667   Mean   :-0.643   Mean   :-0.733   Mean   :-0.486  
##  3rd Qu.:-0.359   3rd Qu.:-0.430   3rd Qu.:-0.572   3rd Qu.:-0.257  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V133             V134             V135             V136       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.: 0.463   1st Qu.: 0.598   1st Qu.: 0.317   1st Qu.:-0.980  
##  Median : 0.778   Median : 0.857   Median : 0.749   Median :-0.832  
##  Mean   : 0.634   Mean   : 0.732   Mean   : 0.561   Mean   :-0.600  
##  3rd Qu.: 0.839   3rd Qu.: 0.907   3rd Qu.: 0.824   3rd Qu.:-0.230  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V137             V138             V139             V140       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.990  
##  Median :-0.992   Median :-0.993   Median :-0.984   Median :-0.929  
##  Mean   :-0.900   Mean   :-0.877   Mean   :-0.871   Mean   :-0.730  
##  3rd Qu.:-0.836   3rd Qu.:-0.835   3rd Qu.:-0.786   3rd Qu.:-0.496  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V141             V142             V143             V144        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.:-0.987   1st Qu.:-0.990   1st Qu.:-0.517   1st Qu.:-0.3722  
##  Median :-0.936   Median :-0.917   Median :-0.181   Median :-0.0842  
##  Mean   :-0.713   Mean   :-0.719   Mean   :-0.147   Mean   :-0.1101  
##  3rd Qu.:-0.495   3rd Qu.:-0.468   3rd Qu.: 0.193   3rd Qu.: 0.1717  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 0.9728  
##       V145              V146              V147              V148        
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.4834   1st Qu.:-0.4311   1st Qu.:-0.0288   1st Qu.:-0.0007  
##  Median : 0.0113   Median :-0.2375   Median : 0.1325   Median : 0.1545  
##  Mean   :-0.0757   Mean   :-0.2199   Mean   : 0.1417   Mean   : 0.1391  
##  3rd Qu.: 0.3054   3rd Qu.:-0.0163   3rd Qu.: 0.2996   3rd Qu.: 0.2918  
##  Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000  
##       V149              V150              V151             V152        
##  Min.   :-0.9666   Min.   :-1.0000   Min.   :-1.000   Min.   :-0.9625  
##  1st Qu.:-0.2545   1st Qu.:-0.3500   1st Qu.: 0.028   1st Qu.:-0.1827  
##  Median :-0.0827   Median :-0.2075   Median : 0.160   Median :-0.0312  
##  Mean   :-0.0854   Mean   :-0.2031   Mean   : 0.165   Mean   :-0.0355  
##  3rd Qu.: 0.0786   3rd Qu.:-0.0592   3rd Qu.: 0.296   3rd Qu.: 0.1207  
##  Max.   : 0.8527   Max.   : 1.0000   Max.   : 1.000   Max.   : 1.0000  
##       V153             V154              V155              V156        
##  Min.   :-1.000   Min.   :-0.9072   Min.   :-0.9234   Min.   :-0.9473  
##  1st Qu.:-0.001   1st Qu.:-0.3354   1st Qu.:-0.1801   1st Qu.:-0.1934  
##  Median : 0.141   Median :-0.1051   Median : 0.0624   Median : 0.0155  
##  Mean   : 0.138   Mean   :-0.0806   Mean   : 0.0622   Mean   :-0.0041  
##  3rd Qu.: 0.280   3rd Qu.: 0.1762   3rd Qu.: 0.2929   3rd Qu.: 0.1952  
##  Max.   : 1.000   Max.   : 0.8661   Max.   : 0.9452   Max.   : 1.0000  
##       V157              V158              V159              V160       
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.0314   1st Qu.:-0.4530   1st Qu.:-0.2545   1st Qu.:-0.438  
##  Median : 0.1469   Median :-0.1903   Median :-0.0221   Median :-0.113  
##  Mean   : 0.1482   Mean   :-0.1731   Mean   : 0.0010   Mean   :-0.117  
##  3rd Qu.: 0.3258   3rd Qu.: 0.0906   3rd Qu.: 0.2503   3rd Qu.: 0.189  
##  Max.   : 0.9851   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.000  
##       V161              V162              V163              V164       
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.1170   1st Qu.:-0.0590   1st Qu.:-0.0784   1st Qu.:-0.991  
##  Median :-0.0983   Median :-0.0406   Median :-0.0546   Median :-0.943  
##  Mean   :-0.0979   Mean   :-0.0425   Mean   :-0.0543   Mean   :-0.730  
##  3rd Qu.:-0.0807   3rd Qu.:-0.0256   3rd Qu.:-0.0324   3rd Qu.:-0.484  
##  Max.   : 1.0000   Max.   : 0.8480   Max.   : 1.0000   Max.   : 1.000  
##       V165             V166             V167             V168       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.993   1st Qu.:-0.994   1st Qu.:-0.992   1st Qu.:-0.993  
##  Median :-0.960   Median :-0.956   Median :-0.950   Median :-0.966  
##  Mean   :-0.784   Mean   :-0.742   Mean   :-0.728   Mean   :-0.794  
##  3rd Qu.:-0.629   3rd Qu.:-0.508   3rd Qu.:-0.475   3rd Qu.:-0.642  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V169             V170             V171             V172       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.994   1st Qu.:-0.991   1st Qu.:-0.993   1st Qu.:-0.992  
##  Median :-0.962   Median :-0.936   Median :-0.958   Median :-0.945  
##  Mean   :-0.748   Mean   :-0.751   Mean   :-0.808   Mean   :-0.747  
##  3rd Qu.:-0.512   3rd Qu.:-0.545   3rd Qu.:-0.687   3rd Qu.:-0.532  
##  Max.   : 1.000   Max.   : 0.928   Max.   : 1.000   Max.   : 0.979  
##       V173             V174             V175             V176       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-0.760   Min.   :-1.000  
##  1st Qu.: 0.559   1st Qu.: 0.721   1st Qu.: 0.646   1st Qu.:-0.994  
##  Median : 0.942   Median : 0.964   Median : 0.961   Median :-0.962  
##  Mean   : 0.760   Mean   : 0.830   Mean   : 0.801   Mean   :-0.765  
##  3rd Qu.: 0.991   3rd Qu.: 0.994   3rd Qu.: 0.994   3rd Qu.:-0.550  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V177             V178             V179             V180       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.992  
##  Median :-0.998   Median :-0.999   Median :-0.999   Median :-0.959  
##  Mean   :-0.914   Mean   :-0.936   Mean   :-0.919   Mean   :-0.734  
##  3rd Qu.:-0.865   3rd Qu.:-0.931   3rd Qu.:-0.877   3rd Qu.:-0.481  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V181             V182             V183              V184        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.994   1st Qu.:-0.994   1st Qu.:-0.5956   1st Qu.:-0.5390  
##  Median :-0.973   Median :-0.971   Median :-0.0819   Median :-0.0418  
##  Mean   :-0.806   Mean   :-0.767   Mean   :-0.0275   Mean   : 0.0015  
##  3rd Qu.:-0.660   3rd Qu.:-0.542   3rd Qu.: 0.5491   3rd Qu.: 0.5517  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.0000   Max.   : 0.9909  
##       V185              V186              V187              V188        
##  Min.   :-1.0000   Min.   :-0.9059   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.6275   1st Qu.:-0.2559   1st Qu.:-0.0856   1st Qu.: 0.0242  
##  Median :-0.1740   Median :-0.0862   Median : 0.0320   Median : 0.1663  
##  Mean   :-0.0291   Mean   :-0.0708   Mean   : 0.0343   Mean   : 0.1610  
##  3rd Qu.: 0.5704   3rd Qu.: 0.1105   3rd Qu.: 0.1503   3rd Qu.: 0.3044  
##  Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000  
##       V189              V190              V191              V192        
##  Min.   :-1.0000   Min.   :-0.9211   Min.   :-1.0000   Min.   :-0.7736  
##  1st Qu.: 0.0417   1st Qu.:-0.3164   1st Qu.: 0.0873   1st Qu.:-0.0394  
##  Median : 0.1803   Median :-0.1659   Median : 0.1955   Median : 0.0936  
##  Mean   : 0.1736   Mean   :-0.1601   Mean   : 0.1940   Mean   : 0.0851  
##  3rd Qu.: 0.3117   3rd Qu.:-0.0163   3rd Qu.: 0.2959   3rd Qu.: 0.2165  
##  Max.   : 1.0000   Max.   : 1.0000   Max.   : 0.8974   Max.   : 0.9990  
##       V193              V194              V195              V196        
##  Min.   :-1.0000   Min.   :-0.9528   Min.   :-1.0000   Min.   :-0.9539  
##  1st Qu.:-0.0779   1st Qu.:-0.3123   1st Qu.:-0.1115   1st Qu.:-0.0798  
##  Median : 0.0826   Median :-0.0614   Median : 0.0380   Median : 0.0966  
##  Mean   : 0.0828   Mean   :-0.0259   Mean   : 0.0494   Mean   : 0.0873  
##  3rd Qu.: 0.2472   3rd Qu.: 0.2615   3rd Qu.: 0.2080   3rd Qu.: 0.2661  
##  Max.   : 0.9234   Max.   : 0.9456   Max.   : 1.0000   Max.   : 1.0000  
##       V197              V198              V199              V200        
##  Min.   :-0.9545   Min.   :-0.8953   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.1263   1st Qu.:-0.1467   1st Qu.:-0.1203   1st Qu.:-0.3001  
##  Median : 0.0459   Median : 0.0378   Median : 0.0478   Median :-0.1305  
##  Mean   : 0.0397   Mean   : 0.0415   Mean   : 0.0491   Mean   :-0.1286  
##  3rd Qu.: 0.2101   3rd Qu.: 0.2253   3rd Qu.: 0.2157   3rd Qu.: 0.0356  
##  Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 0.9968  
##       V201             V202             V203             V204       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.983   1st Qu.:-0.983   1st Qu.:-0.985   1st Qu.:-0.981  
##  Median :-0.883   Median :-0.854   Median :-0.870   Median :-0.863  
##  Mean   :-0.544   Mean   :-0.589   Mean   :-0.639   Mean   :-0.557  
##  3rd Qu.:-0.107   3rd Qu.:-0.233   3rd Qu.:-0.324   3rd Qu.:-0.156  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V205             V206             V207             V208       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.993   1st Qu.:-0.983   1st Qu.:-1.000   1st Qu.:-0.985  
##  Median :-0.969   Median :-0.883   Median :-0.990   Median :-0.888  
##  Mean   :-0.839   Mean   :-0.544   Mean   :-0.771   Mean   :-0.696  
##  3rd Qu.:-0.696   3rd Qu.:-0.107   3rd Qu.:-0.590   3rd Qu.:-0.437  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V209             V210              V211              V212        
##  Min.   :-0.995   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.566   1st Qu.:-0.2957   1st Qu.:-0.1513   1st Qu.:-0.1083  
##  Median : 0.144   Median :-0.0766   Median : 0.0182   Median : 0.0695  
##  Mean   : 0.124   Mean   :-0.0725   Mean   : 0.0250   Mean   : 0.0607  
##  3rd Qu.: 0.808   3rd Qu.: 0.1395   3rd Qu.: 0.1921   3rd Qu.: 0.2391  
##  Max.   : 1.000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 0.9947  
##       V213              V214             V215             V216       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.2368   1st Qu.:-0.983   1st Qu.:-0.983   1st Qu.:-0.985  
##  Median :-0.0582   Median :-0.883   Median :-0.854   Median :-0.870  
##  Mean   :-0.0587   Mean   :-0.544   Mean   :-0.589   Mean   :-0.639  
##  3rd Qu.: 0.1264   3rd Qu.:-0.107   3rd Qu.:-0.233   3rd Qu.:-0.324  
##  Max.   : 1.0000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V217             V218             V219             V220       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.981   1st Qu.:-0.993   1st Qu.:-0.983   1st Qu.:-1.000  
##  Median :-0.863   Median :-0.969   Median :-0.883   Median :-0.990  
##  Mean   :-0.557   Mean   :-0.839   Mean   :-0.544   Mean   :-0.771  
##  3rd Qu.:-0.156   3rd Qu.:-0.696   3rd Qu.:-0.107   3rd Qu.:-0.590  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V221             V222             V223              V224        
##  Min.   :-1.000   Min.   :-0.995   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.985   1st Qu.:-0.566   1st Qu.:-0.2957   1st Qu.:-0.1513  
##  Median :-0.888   Median : 0.144   Median :-0.0766   Median : 0.0182  
##  Mean   :-0.696   Mean   : 0.124   Mean   :-0.0725   Mean   : 0.0250  
##  3rd Qu.:-0.437   3rd Qu.: 0.808   3rd Qu.: 0.1395   3rd Qu.: 0.1921  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.0000   Max.   : 1.0000  
##       V225              V226              V227             V228       
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.1083   1st Qu.:-0.2368   1st Qu.:-0.990   1st Qu.:-0.991  
##  Median : 0.0695   Median :-0.0582   Median :-0.954   Median :-0.939  
##  Mean   : 0.0607   Mean   :-0.0587   Mean   :-0.650   Mean   :-0.633  
##  3rd Qu.: 0.2391   3rd Qu.: 0.1264   3rd Qu.:-0.287   3rd Qu.:-0.275  
##  Max.   : 0.9947   Max.   : 1.0000   Max.   : 1.000   Max.   : 1.000  
##       V229             V230             V231             V232       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.992   1st Qu.:-0.990   1st Qu.:-0.984   1st Qu.:-0.990  
##  Median :-0.946   Median :-0.936   Median :-0.964   Median :-0.954  
##  Mean   :-0.651   Mean   :-0.643   Mean   :-0.786   Mean   :-0.650  
##  3rd Qu.:-0.310   3rd Qu.:-0.298   3rd Qu.:-0.606   3rd Qu.:-0.287  
##  Max.   : 1.000   Max.   : 0.984   Max.   : 1.000   Max.   : 1.000  
##       V233             V234             V235              V236        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-1.000   1st Qu.:-0.992   1st Qu.:-0.8086   1st Qu.:-0.0892  
##  Median :-0.998   Median :-0.960   Median :-0.3557   Median : 0.0918  
##  Mean   :-0.850   Mean   :-0.702   Mean   :-0.0741   Mean   : 0.0794  
##  3rd Qu.:-0.729   3rd Qu.:-0.412   3rd Qu.: 0.7044   3rd Qu.: 0.2613  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.0000   Max.   : 0.8628  
##       V237              V238              V239              V240       
##  Min.   :-1.0000   Min.   :-0.8306   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.2124   1st Qu.:-0.2432   1st Qu.:-0.2252   1st Qu.:-0.980  
##  Median :-0.0574   Median :-0.0872   Median :-0.0515   Median :-0.835  
##  Mean   :-0.0297   Mean   :-0.0843   Mean   :-0.0494   Mean   :-0.603  
##  3rd Qu.: 0.1383   3rd Qu.: 0.0676   3rd Qu.: 0.1230   3rd Qu.:-0.233  
##  Max.   : 1.0000   Max.   : 0.9143   Max.   : 0.9743   Max.   : 1.000  
##       V241             V242             V243             V244       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.980   1st Qu.:-0.978   1st Qu.:-0.982   1st Qu.:-0.989  
##  Median :-0.838   Median :-0.819   Median :-0.861   Median :-0.899  
##  Mean   :-0.656   Mean   :-0.623   Mean   :-0.692   Mean   :-0.735  
##  3rd Qu.:-0.371   3rd Qu.:-0.307   3rd Qu.:-0.440   3rd Qu.:-0.535  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V245             V246             V247             V248       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.980   1st Qu.:-1.000   1st Qu.:-0.981   1st Qu.:-0.192  
##  Median :-0.835   Median :-0.984   Median :-0.830   Median : 0.259  
##  Mean   :-0.603   Mean   :-0.830   Mean   :-0.647   Mean   : 0.210  
##  3rd Qu.:-0.233   3rd Qu.:-0.693   3rd Qu.:-0.349   3rd Qu.: 0.635  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 0.969   Max.   : 0.993  
##       V249             V250              V251              V252        
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-0.8999   Min.   :-0.9974  
##  1st Qu.:-0.240   1st Qu.:-0.2553   1st Qu.:-0.0514   1st Qu.:-0.2194  
##  Median :-0.036   Median :-0.0758   Median : 0.1151   Median :-0.0610  
##  Mean   :-0.030   Mean   :-0.0666   Mean   : 0.1115   Mean   :-0.0587  
##  3rd Qu.: 0.178   3rd Qu.: 0.1109   3rd Qu.: 0.2784   3rd Qu.: 0.1042  
##  Max.   : 0.994   Max.   : 1.0000   Max.   : 0.9946   Max.   : 1.0000  
##       V253             V254             V255             V256       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.993   1st Qu.:-0.993   1st Qu.:-0.994   1st Qu.:-0.993  
##  Median :-0.961   Median :-0.948   Median :-0.955   Median :-0.949  
##  Mean   :-0.760   Mean   :-0.778   Mean   :-0.792   Mean   :-0.785  
##  3rd Qu.:-0.544   3rd Qu.:-0.609   3rd Qu.:-0.627   3rd Qu.:-0.633  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V257             V258             V259             V260       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.991   1st Qu.:-0.993   1st Qu.:-1.000   1st Qu.:-0.995  
##  Median :-0.974   Median :-0.961   Median :-0.999   Median :-0.963  
##  Mean   :-0.802   Mean   :-0.760   Mean   :-0.929   Mean   :-0.805  
##  3rd Qu.:-0.638   3rd Qu.:-0.544   3rd Qu.:-0.898   3rd Qu.:-0.641  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V261              V262             V263              V264        
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-0.9977   Min.   :-1.0000  
##  1st Qu.:-0.6082   1st Qu.: 0.130   1st Qu.:-0.3686   1st Qu.:-0.1913  
##  Median : 0.0358   Median : 0.295   Median :-0.2304   Median :-0.0474  
##  Mean   : 0.1104   Mean   : 0.280   Mean   :-0.2224   Mean   :-0.0486  
##  3rd Qu.: 0.8435   3rd Qu.: 0.449   3rd Qu.:-0.0932   3rd Qu.: 0.0962  
##  Max.   : 1.0000   Max.   : 0.993   Max.   : 1.0000   Max.   : 0.8803  
##       V265             V266             V267              V268       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.285   1st Qu.:-0.992   1st Qu.:-0.9804   1st Qu.:-0.984  
##  Median :-0.129   Median :-0.950   Median :-0.8770   Median :-0.900  
##  Mean   :-0.117   Mean   :-0.623   Mean   :-0.5390   Mean   :-0.660  
##  3rd Qu.: 0.041   3rd Qu.:-0.254   3rd Qu.:-0.0892   3rd Qu.:-0.356  
##  Max.   : 0.837   Max.   : 1.000   Max.   : 0.9718   Max.   : 1.000  
##       V269             V270              V271             V272       
##  Min.   :-1.000   Min.   :-0.9999   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.993   1st Qu.:-0.9779   1st Qu.:-0.979   1st Qu.:-0.992  
##  Median :-0.944   Median :-0.8500   Median :-0.849   Median :-0.949  
##  Mean   :-0.600   Mean   :-0.5287   Mean   :-0.609   Mean   :-0.590  
##  3rd Qu.:-0.241   3rd Qu.:-0.0701   3rd Qu.:-0.286   3rd Qu.:-0.194  
##  Max.   : 1.000   Max.   : 0.8603   Max.   : 1.000   Max.   : 1.000  
##       V273              V274             V275             V276       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.9812   1st Qu.:-0.982   1st Qu.:-0.995   1st Qu.:-0.980  
##  Median :-0.8720   Median :-0.884   Median :-0.946   Median :-0.873  
##  Mean   :-0.5228   Mean   :-0.627   Mean   :-0.647   Mean   :-0.659  
##  3rd Qu.:-0.0586   3rd Qu.:-0.298   3rd Qu.:-0.341   3rd Qu.:-0.352  
##  Max.   : 0.9612   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V277             V278             V279             V280       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.976   1st Qu.:-0.995   1st Qu.:-0.992   1st Qu.:-0.992  
##  Median :-0.828   Median :-0.978   Median :-0.970   Median :-0.975  
##  Mean   :-0.625   Mean   :-0.853   Mean   :-0.880   Mean   :-0.913  
##  3rd Qu.:-0.352   3rd Qu.:-0.786   3rd Qu.:-0.824   3rd Qu.:-0.878  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V281             V282             V283             V284       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.987   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.905   Median :-0.998   Median :-0.988   Median :-0.988  
##  Mean   :-0.554   Mean   :-0.821   Mean   :-0.752   Mean   :-0.830  
##  3rd Qu.:-0.105   3rd Qu.:-0.711   3rd Qu.:-0.529   3rd Qu.:-0.720  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 0.837   Max.   : 1.000  
##       V285             V286             V287             V288       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.990   1st Qu.:-0.987   1st Qu.:-0.983   1st Qu.:-0.946  
##  Median :-0.952   Median :-0.933   Median :-0.943   Median :-0.528  
##  Mean   :-0.656   Mean   :-0.653   Mean   :-0.747   Mean   :-0.211  
##  3rd Qu.:-0.326   3rd Qu.:-0.311   3rd Qu.:-0.533   3rd Qu.: 0.550  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V289             V290             V291             V292       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.870   1st Qu.:-0.814   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.405   Median :-0.413   Median :-0.806   Median :-0.800  
##  Mean   :-0.193   Mean   :-0.210   Mean   :-0.766   Mean   :-0.796  
##  3rd Qu.: 0.503   3rd Qu.: 0.411   3rd Qu.:-0.742   3rd Qu.:-0.733  
##  Max.   : 0.909   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V293             V294              V295              V296        
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-1.000   1st Qu.:-0.4235   1st Qu.:-0.1481   1st Qu.:-0.1451  
##  Median :-0.923   Median :-0.2433   Median : 0.0017   Median : 0.0621  
##  Mean   :-0.844   Mean   :-0.2273   Mean   : 0.0136   Mean   : 0.0453  
##  3rd Qu.:-0.769   3rd Qu.:-0.0235   3rd Qu.: 0.1752   3rd Qu.: 0.2545  
##  Max.   : 0.923   Max.   : 0.9141   Max.   : 1.0000   Max.   : 1.0000  
##       V297             V298             V299              V300       
##  Min.   :-0.931   Min.   :-0.999   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.487   1st Qu.:-0.841   1st Qu.:-0.5231   1st Qu.:-0.850  
##  Median :-0.163   Median :-0.574   Median :-0.3569   Median :-0.719  
##  Mean   :-0.129   Mean   :-0.458   Mean   :-0.2638   Mean   :-0.578  
##  3rd Qu.: 0.155   3rd Qu.:-0.174   3rd Qu.:-0.0968   3rd Qu.:-0.449  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 0.9756   Max.   : 0.966  
##       V301             V302             V303             V304       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.565   1st Qu.:-0.809   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.311   Median :-0.603   Median :-0.998   Median :-0.999  
##  Mean   :-0.238   Mean   :-0.477   Mean   :-0.810   Mean   :-0.888  
##  3rd Qu.: 0.040   3rd Qu.:-0.231   3rd Qu.:-0.701   3rd Qu.:-0.822  
##  Max.   : 0.985   Max.   : 0.980   Max.   : 1.000   Max.   : 1.000  
##       V305             V306             V307             V308       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.999   Median :-0.999   Median :-0.999   Median :-0.999  
##  Mean   :-0.858   Mean   :-0.896   Mean   :-0.913   Mean   :-0.910  
##  3rd Qu.:-0.783   3rd Qu.:-0.859   3rd Qu.:-0.874   3rd Qu.:-0.874  
##  Max.   : 1.000   Max.   : 0.881   Max.   : 1.000   Max.   : 1.000  
##       V309             V310             V311             V312       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.999   Median :-1.000   Median :-0.998   Median :-0.998  
##  Mean   :-0.944   Mean   :-0.953   Mean   :-0.816   Mean   :-0.848  
##  3rd Qu.:-0.929   3rd Qu.:-0.972   3rd Qu.:-0.708   3rd Qu.:-0.762  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V313             V314             V315             V316       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.999   Median :-0.999   Median :-0.998   Median :-0.998  
##  Mean   :-0.912   Mean   :-0.947   Mean   :-0.819   Mean   :-0.884  
##  3rd Qu.:-0.871   3rd Qu.:-0.940   3rd Qu.:-0.709   3rd Qu.:-0.832  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V317             V318             V319             V320       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.985   Median :-0.997   Median :-0.998   Median :-0.997  
##  Mean   :-0.787   Mean   :-0.845   Mean   :-0.862   Mean   :-0.906  
##  3rd Qu.:-0.609   3rd Qu.:-0.762   3rd Qu.:-0.779   3rd Qu.:-0.865  
##  Max.   : 1.000   Max.   : 0.950   Max.   : 1.000   Max.   : 0.958  
##       V321             V322             V323             V324       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.996   Median :-0.996   Median :-0.996   Median :-0.999  
##  Mean   :-0.897   Mean   :-0.882   Mean   :-0.902   Mean   :-0.952  
##  3rd Qu.:-0.847   3rd Qu.:-0.821   3rd Qu.:-0.863   3rd Qu.:-0.968  
##  Max.   : 0.847   Max.   : 0.898   Max.   : 1.000   Max.   : 1.000  
##       V325             V326             V327             V328       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.987   Median :-0.997   Median :-0.996   Median :-0.996  
##  Mean   :-0.757   Mean   :-0.839   Mean   :-0.879   Mean   :-0.920  
##  3rd Qu.:-0.544   3rd Qu.:-0.737   3rd Qu.:-0.814   3rd Qu.:-0.896  
##  Max.   : 0.867   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V329             V330             V331             V332       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.988   Median :-0.997   Median :-0.987   Median :-0.997  
##  Mean   :-0.754   Mean   :-0.893   Mean   :-0.848   Mean   :-0.895  
##  3rd Qu.:-0.535   3rd Qu.:-0.837   3rd Qu.:-0.764   3rd Qu.:-0.852  
##  Max.   : 0.821   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V333             V334             V335             V336       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.998   Median :-0.999   Median :-0.998   Median :-0.997  
##  Mean   :-0.922   Mean   :-0.960   Mean   :-0.962   Mean   :-0.934  
##  3rd Qu.:-0.903   3rd Qu.:-0.954   3rd Qu.:-0.954   3rd Qu.:-0.915  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V337             V338             V339             V340       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.996   Median :-0.999   Median :-0.988   Median :-0.999  
##  Mean   :-0.939   Mean   :-0.956   Mean   :-0.845   Mean   :-0.936  
##  3rd Qu.:-0.923   3rd Qu.:-0.972   3rd Qu.:-0.750   3rd Qu.:-0.918  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V341             V342             V343             V344       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.998   Median :-0.996   Median :-0.988   Median :-0.999  
##  Mean   :-0.952   Mean   :-0.943   Mean   :-0.834   Mean   :-0.958  
##  3rd Qu.:-0.939   3rd Qu.:-0.932   3rd Qu.:-0.729   3rd Qu.:-0.947  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V345             V346             V347             V348       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.992   1st Qu.:-0.986   1st Qu.:-0.988   1st Qu.:-0.992  
##  Median :-0.959   Median :-0.933   Median :-0.953   Median :-0.963  
##  Mean   :-0.660   Mean   :-0.632   Mean   :-0.741   Mean   :-0.659  
##  3rd Qu.:-0.325   3rd Qu.:-0.260   3rd Qu.:-0.508   3rd Qu.:-0.322  
##  Max.   : 1.000   Max.   : 0.647   Max.   : 1.000   Max.   : 1.000  
##       V349             V350             V351             V352       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.987   1st Qu.:-0.990   1st Qu.:-0.990   1st Qu.:-0.987  
##  Median :-0.936   Median :-0.964   Median :-0.953   Median :-0.937  
##  Mean   :-0.615   Mean   :-0.779   Mean   :-0.600   Mean   :-0.627  
##  3rd Qu.:-0.234   3rd Qu.:-0.587   3rd Qu.:-0.202   3rd Qu.:-0.252  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 0.805  
##       V353             V354             V355             V356       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.989   1st Qu.:-0.994   1st Qu.:-0.989   1st Qu.:-0.990  
##  Median :-0.959   Median :-0.972   Median :-0.949   Median :-0.966  
##  Mean   :-0.762   Mean   :-0.715   Mean   :-0.681   Mean   :-0.798  
##  3rd Qu.:-0.553   3rd Qu.:-0.446   3rd Qu.:-0.387   3rd Qu.:-0.637  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V357             V358             V359             V360       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.995   1st Qu.:-0.992   1st Qu.:-0.989   1st Qu.:-0.989  
##  Median :-0.984   Median :-0.972   Median :-0.970   Median :-0.942  
##  Mean   :-0.882   Mean   :-0.862   Mean   :-0.883   Mean   :-0.622  
##  3rd Qu.:-0.832   3rd Qu.:-0.802   3rd Qu.:-0.843   3rd Qu.:-0.241  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V361             V362             V363             V364       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.990  
##  Median :-0.999   Median :-0.997   Median :-0.999   Median :-0.953  
##  Mean   :-0.850   Mean   :-0.828   Mean   :-0.927   Mean   :-0.637  
##  3rd Qu.:-0.743   3rd Qu.:-0.689   3rd Qu.:-0.891   3rd Qu.:-0.295  
##  Max.   : 1.000   Max.   : 0.634   Max.   : 1.000   Max.   : 1.000  
##       V365             V366             V367             V368       
##  Min.   :-1.000   Min.   :-0.999   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.989   1st Qu.:-0.986   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.949   Median :-0.956   Median :-0.736   Median :-0.656  
##  Mean   :-0.723   Mean   :-0.769   Mean   :-0.279   Mean   :-0.274  
##  3rd Qu.:-0.452   3rd Qu.:-0.578   3rd Qu.: 0.521   3rd Qu.: 0.511  
##  Max.   : 0.641   Max.   : 1.000   Max.   : 1.000   Max.   : 0.997  
##       V369             V370             V371             V372       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-0.680   1st Qu.:-0.560   1st Qu.:-0.520  
##  Median :-0.708   Median :-0.400   Median :-0.400   Median :-0.320  
##  Mean   :-0.371   Mean   :-0.422   Mean   :-0.399   Mean   :-0.331  
##  3rd Qu.: 0.293   3rd Qu.:-0.160   3rd Qu.:-0.240   3rd Qu.:-0.160  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 0.960  
##       V373              V374             V375              V376       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.2964   1st Qu.:-0.431   1st Qu.:-0.3303   1st Qu.:-0.509  
##  Median :-0.0453   Median :-0.236   Median :-0.0959   Median :-0.359  
##  Mean   :-0.0465   Mean   :-0.212   Mean   :-0.1226   Mean   :-0.321  
##  3rd Qu.: 0.2042   3rd Qu.: 0.018   3rd Qu.: 0.0955   3rd Qu.:-0.171  
##  Max.   : 1.0000   Max.   : 1.000   Max.   : 0.6786   Max.   : 0.829  
##       V377             V378             V379             V380       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.859   1st Qu.:-0.535   1st Qu.:-0.913   1st Qu.:-0.629  
##  Median :-0.776   Median :-0.417   Median :-0.856   Median :-0.520  
##  Mean   :-0.716   Mean   :-0.396   Mean   :-0.820   Mean   :-0.487  
##  3rd Qu.:-0.640   3rd Qu.:-0.288   3rd Qu.:-0.772   3rd Qu.:-0.382  
##  Max.   : 0.660   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V381             V382             V383             V384       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.911   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.855   Median :-1.000   Median :-0.999   Median :-0.999  
##  Mean   :-0.813   Mean   :-0.862   Mean   :-0.889   Mean   :-0.875  
##  3rd Qu.:-0.766   3rd Qu.:-0.795   3rd Qu.:-0.814   3rd Qu.:-0.812  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V385             V386             V387             V388       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.999   Median :-0.999   Median :-0.999   Median :-0.999  
##  Mean   :-0.901   Mean   :-0.921   Mean   :-0.901   Mean   :-0.944  
##  3rd Qu.:-0.867   3rd Qu.:-0.888   3rd Qu.:-0.859   3rd Qu.:-0.923  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V389             V390             V391             V392       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-1.000   Median :-0.999   Median :-0.999   Median :-0.999  
##  Mean   :-0.984   Mean   :-0.868   Mean   :-0.857   Mean   :-0.906  
##  3rd Qu.:-0.991   3rd Qu.:-0.785   3rd Qu.:-0.781   3rd Qu.:-0.861  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V393             V394             V395             V396       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.999   Median :-0.999   Median :-0.998   Median :-0.996  
##  Mean   :-0.942   Mean   :-0.846   Mean   :-0.864   Mean   :-0.838  
##  3rd Qu.:-0.920   3rd Qu.:-0.734   3rd Qu.:-0.802   3rd Qu.:-0.711  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 0.703  
##       V397             V398             V399             V400       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.998   Median :-0.998   Median :-0.998   Median :-0.998  
##  Mean   :-0.867   Mean   :-0.839   Mean   :-0.911   Mean   :-0.915  
##  3rd Qu.:-0.796   3rd Qu.:-0.741   3rd Qu.:-0.872   3rd Qu.:-0.876  
##  Max.   : 0.892   Max.   : 0.908   Max.   : 0.888   Max.   : 0.632  
##       V401             V402             V403             V404       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.997   Median :-0.998   Median :-1.000   Median :-0.997  
##  Mean   :-0.876   Mean   :-0.922   Mean   :-0.971   Mean   :-0.841  
##  3rd Qu.:-0.809   3rd Qu.:-0.887   3rd Qu.:-0.984   3rd Qu.:-0.739  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 0.898  
##       V405             V406             V407             V408       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.998   Median :-0.998   Median :-0.999   Median :-0.997  
##  Mean   :-0.840   Mean   :-0.878   Mean   :-0.928   Mean   :-0.813  
##  3rd Qu.:-0.738   3rd Qu.:-0.809   3rd Qu.:-0.895   3rd Qu.:-0.669  
##  Max.   : 0.930   Max.   : 1.000   Max.   : 1.000   Max.   : 0.915  
##       V409             V410             V411             V412       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.998   Median :-0.997   Median :-0.998   Median :-0.999  
##  Mean   :-0.897   Mean   :-0.897   Mean   :-0.896   Mean   :-0.928  
##  3rd Qu.:-0.838   3rd Qu.:-0.856   3rd Qu.:-0.854   3rd Qu.:-0.912  
##  Max.   : 0.807   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V413             V414             V415             V416       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.999   Median :-0.999   Median :-0.998   Median :-0.998  
##  Mean   :-0.961   Mean   :-0.965   Mean   :-0.939   Mean   :-0.929  
##  3rd Qu.:-0.956   3rd Qu.:-0.960   3rd Qu.:-0.924   3rd Qu.:-0.914  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V417             V418             V419             V420       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.999   Median :-0.997   Median :-0.999   Median :-0.999  
##  Mean   :-0.970   Mean   :-0.875   Mean   :-0.944   Mean   :-0.955  
##  3rd Qu.:-0.987   3rd Qu.:-0.815   3rd Qu.:-0.928   3rd Qu.:-0.944  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V421             V422             V423             V424       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.986  
##  Median :-0.998   Median :-0.998   Median :-0.999   Median :-0.902  
##  Mean   :-0.929   Mean   :-0.895   Mean   :-0.959   Mean   :-0.673  
##  3rd Qu.:-0.913   3rd Qu.:-0.844   3rd Qu.:-0.949   3rd Qu.:-0.384  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V425             V426             V427             V428       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.986   1st Qu.:-0.987   1st Qu.:-0.989   1st Qu.:-0.983  
##  Median :-0.925   Median :-0.894   Median :-0.914   Median :-0.913  
##  Mean   :-0.702   Mean   :-0.646   Mean   :-0.738   Mean   :-0.666  
##  3rd Qu.:-0.466   3rd Qu.:-0.313   3rd Qu.:-0.518   3rd Qu.:-0.425  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V429             V430             V431             V432       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.988   1st Qu.:-0.987   1st Qu.:-0.986   1st Qu.:-0.987  
##  Median :-0.899   Median :-0.903   Median :-0.926   Median :-0.894  
##  Mean   :-0.691   Mean   :-0.687   Mean   :-0.707   Mean   :-0.642  
##  3rd Qu.:-0.413   3rd Qu.:-0.409   3rd Qu.:-0.486   3rd Qu.:-0.302  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V433             V434             V435             V436       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.989   1st Qu.:-0.985   1st Qu.:-0.990   1st Qu.:-0.997  
##  Median :-0.917   Median :-0.924   Median :-0.917   Median :-0.983  
##  Mean   :-0.735   Mean   :-0.726   Mean   :-0.765   Mean   :-0.932  
##  3rd Qu.:-0.531   3rd Qu.:-0.555   3rd Qu.:-0.580   3rd Qu.:-0.907  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 0.465  
##       V437             V438             V439             V440       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.995   1st Qu.:-0.995   1st Qu.:-0.986   1st Qu.:-1.000  
##  Median :-0.975   Median :-0.972   Median :-0.909   Median :-0.996  
##  Mean   :-0.899   Mean   :-0.908   Mean   :-0.659   Mean   :-0.914  
##  3rd Qu.:-0.861   3rd Qu.:-0.870   3rd Qu.:-0.343   3rd Qu.:-0.863  
##  Max.   : 0.794   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V441             V442             V443             V444       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.990   1st Qu.:-0.991  
##  Median :-0.996   Median :-0.994   Median :-0.941   Median :-0.948  
##  Mean   :-0.878   Mean   :-0.868   Mean   :-0.709   Mean   :-0.752  
##  3rd Qu.:-0.837   3rd Qu.:-0.775   3rd Qu.:-0.457   3rd Qu.:-0.575  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V445             V446             V447              V448       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.990   1st Qu.:-0.713   1st Qu.:-0.6606   1st Qu.:-0.779  
##  Median :-0.939   Median :-0.205   Median :-0.1605   Median :-0.268  
##  Mean   :-0.699   Mean   :-0.108   Mean   :-0.0591   Mean   :-0.162  
##  3rd Qu.:-0.438   3rd Qu.: 0.513   3rd Qu.: 0.5603   3rd Qu.: 0.448  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.0000   Max.   : 1.000  
##       V449             V450             V451             V452        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.2737  
##  Median :-0.933   Median :-0.935   Median :-0.931   Median :-0.0991  
##  Mean   :-0.875   Mean   :-0.811   Mean   :-0.805   Mean   :-0.1012  
##  3rd Qu.:-0.867   3rd Qu.:-0.742   3rd Qu.:-0.655   3rd Qu.: 0.0703  
##  Max.   : 1.000   Max.   : 0.806   Max.   : 0.655   Max.   : 1.0000  
##       V453              V454              V455              V456       
##  Min.   :-1.0000   Min.   :-0.9663   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.3666   1st Qu.:-0.2275   1st Qu.:-0.4139   1st Qu.:-0.754  
##  Median :-0.1761   Median :-0.0510   Median :-0.2171   Median :-0.581  
##  Mean   :-0.1771   Mean   :-0.0485   Mean   :-0.1747   Mean   :-0.491  
##  3rd Qu.: 0.0112   3rd Qu.: 0.1257   3rd Qu.: 0.0347   3rd Qu.:-0.302  
##  Max.   : 0.9937   Max.   : 1.0000   Max.   : 0.9209   Max.   : 0.894  
##       V457              V458             V459             V460       
##  Min.   :-1.0000   Min.   :-0.998   Min.   :-0.909   Min.   :-1.000  
##  1st Qu.:-0.4442   1st Qu.:-0.814   1st Qu.:-0.474   1st Qu.:-0.802  
##  Median :-0.2408   Median :-0.652   Median :-0.271   Median :-0.637  
##  Mean   :-0.1728   Mean   :-0.528   Mean   :-0.217   Mean   :-0.536  
##  3rd Qu.: 0.0408   3rd Qu.:-0.356   3rd Qu.:-0.007   3rd Qu.:-0.358  
##  Max.   : 0.9813   Max.   : 0.978   Max.   : 0.904   Max.   : 0.857  
##       V461             V462             V463             V464       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.996   Median :-0.998   Median :-0.999   Median :-0.999  
##  Mean   :-0.928   Mean   :-0.901   Mean   :-0.918   Mean   :-0.960  
##  3rd Qu.:-0.898   3rd Qu.:-0.864   3rd Qu.:-0.888   3rd Qu.:-0.952  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V465             V466             V467             V468       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.998   Median :-0.998   Median :-0.998   Median :-1.000  
##  Mean   :-0.950   Mean   :-0.952   Mean   :-0.964   Mean   :-0.976  
##  3rd Qu.:-0.938   3rd Qu.:-0.936   3rd Qu.:-0.959   3rd Qu.:-0.984  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V469             V470             V471             V472       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.996   Median :-0.999   Median :-0.998   Median :-0.998  
##  Mean   :-0.918   Mean   :-0.917   Mean   :-0.946   Mean   :-0.969  
##  3rd Qu.:-0.873   3rd Qu.:-0.886   3rd Qu.:-0.930   3rd Qu.:-0.969  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V473             V474             V475             V476       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.996   Median :-0.999   Median :-0.995   Median :-0.999  
##  Mean   :-0.915   Mean   :-0.955   Mean   :-0.870   Mean   :-0.955  
##  3rd Qu.:-0.866   3rd Qu.:-0.941   3rd Qu.:-0.840   3rd Qu.:-0.953  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V477             V478             V479             V480       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-1.000   Median :-1.000   Median :-1.000   Median :-0.999  
##  Mean   :-0.957   Mean   :-0.966   Mean   :-0.977   Mean   :-0.956  
##  3rd Qu.:-0.964   3rd Qu.:-0.970   3rd Qu.:-0.976   3rd Qu.:-0.953  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V481             V482             V483             V484       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.999   Median :-1.000   Median :-0.996   Median :-0.999  
##  Mean   :-0.950   Mean   :-0.975   Mean   :-0.883   Mean   :-0.949  
##  3rd Qu.:-0.948   3rd Qu.:-0.986   3rd Qu.:-0.845   3rd Qu.:-0.955  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V485             V486             V487             V488       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.999   Median :-0.999   Median :-0.996   Median :-0.999  
##  Mean   :-0.972   Mean   :-0.954   Mean   :-0.871   Mean   :-0.965  
##  3rd Qu.:-0.970   3rd Qu.:-0.954   3rd Qu.:-0.829   3rd Qu.:-0.966  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V489             V490             V491             V492       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.994   Median :-0.999   Median :-0.999   Median :-0.999  
##  Mean   :-0.898   Mean   :-0.932   Mean   :-0.930   Mean   :-0.967  
##  3rd Qu.:-0.839   3rd Qu.:-0.912   3rd Qu.:-0.912   3rd Qu.:-0.963  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V493             V494             V495             V496       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.999   Median :-0.998   Median :-0.996   Median :-0.999  
##  Mean   :-0.972   Mean   :-0.961   Mean   :-0.952   Mean   :-0.969  
##  3rd Qu.:-0.967   3rd Qu.:-0.951   3rd Qu.:-0.947   3rd Qu.:-0.981  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V497             V498             V499             V500       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.994   Median :-0.999   Median :-0.999   Median :-0.997  
##  Mean   :-0.880   Mean   :-0.917   Mean   :-0.969   Mean   :-0.959  
##  3rd Qu.:-0.803   3rd Qu.:-0.894   3rd Qu.:-0.961   3rd Qu.:-0.959  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V501             V502             V503             V504       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.986   1st Qu.:-0.984  
##  Median :-0.994   Median :-0.999   Median :-0.886   Median :-0.862  
##  Mean   :-0.872   Mean   :-0.968   Mean   :-0.586   Mean   :-0.656  
##  3rd Qu.:-0.782   3rd Qu.:-0.961   3rd Qu.:-0.206   3rd Qu.:-0.377  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V505             V506             V507             V508       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.983   1st Qu.:-0.987   1st Qu.:-0.992   1st Qu.:-0.986  
##  Median :-0.868   Median :-0.885   Median :-0.971   Median :-0.886  
##  Mean   :-0.594   Mean   :-0.753   Mean   :-0.891   Mean   :-0.586  
##  3rd Qu.:-0.244   3rd Qu.:-0.566   3rd Qu.:-0.839   3rd Qu.:-0.206  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V509             V510             V511             V512       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-0.988   1st Qu.:-0.892   1st Qu.:-1.000  
##  Median :-0.988   Median :-0.936   Median :-0.391   Median :-0.793  
##  Mean   :-0.817   Mean   :-0.695   Mean   :-0.198   Mean   :-0.751  
##  3rd Qu.:-0.701   3rd Qu.:-0.425   3rd Qu.: 0.497   3rd Qu.:-0.517  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V513              V514             V515             V516       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.0989   1st Qu.:-0.575   1st Qu.:-0.844   1st Qu.:-0.990  
##  Median : 0.0677   Median :-0.418   Median :-0.732   Median :-0.940  
##  Mean   : 0.0731   Mean   :-0.347   Mean   :-0.627   Mean   :-0.624  
##  3rd Qu.: 0.2417   3rd Qu.:-0.196   3rd Qu.:-0.525   3rd Qu.:-0.259  
##  Max.   : 1.0000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V517             V518             V519             V520       
##  Min.   :-1.000   Min.   :-0.999   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.991   1st Qu.:-0.989   1st Qu.:-0.993   1st Qu.:-0.987  
##  Median :-0.937   Median :-0.934   Median :-0.944   Median :-0.963  
##  Mean   :-0.647   Mean   :-0.619   Mean   :-0.691   Mean   :-0.806  
##  3rd Qu.:-0.314   3rd Qu.:-0.249   3rd Qu.:-0.422   3rd Qu.:-0.684  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V521             V522             V523             V524       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.990   1st Qu.:-1.000   1st Qu.:-0.989   1st Qu.:-1.000  
##  Median :-0.940   Median :-0.998   Median :-0.951   Median :-0.741  
##  Mean   :-0.624   Mean   :-0.842   Mean   :-0.679   Mean   :-0.348  
##  3rd Qu.:-0.259   3rd Qu.:-0.731   3rd Qu.:-0.372   3rd Qu.: 0.351  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V525             V526              V527              V528       
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.968   1st Qu.:-0.0004   1st Qu.:-0.6075   1st Qu.:-0.882  
##  Median :-0.905   Median : 0.1686   Median :-0.3648   Median :-0.727  
##  Mean   :-0.878   Mean   : 0.1782   Mean   :-0.3130   Mean   :-0.615  
##  3rd Qu.:-0.873   3rd Qu.: 0.3642   3rd Qu.:-0.0826   3rd Qu.:-0.450  
##  Max.   : 1.000   Max.   : 0.9758   Max.   : 1.0000   Max.   : 1.000  
##       V529             V530             V531             V532       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.984   1st Qu.:-0.980   1st Qu.:-0.981   1st Qu.:-0.981  
##  Median :-0.886   Median :-0.838   Median :-0.859   Median :-0.836  
##  Mean   :-0.693   Mean   :-0.693   Mean   :-0.675   Mean   :-0.727  
##  3rd Qu.:-0.438   3rd Qu.:-0.452   3rd Qu.:-0.397   3rd Qu.:-0.541  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 0.842  
##       V533             V534             V535             V536       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.994   1st Qu.:-0.984   1st Qu.:-1.000   1st Qu.:-0.987  
##  Median :-0.960   Median :-0.886   Median :-0.986   Median :-0.923  
##  Mean   :-0.885   Mean   :-0.693   Mean   :-0.874   Mean   :-0.720  
##  3rd Qu.:-0.837   3rd Qu.:-0.438   3rd Qu.:-0.801   3rd Qu.:-0.484  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V537              V538             V539              V540       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-0.9975   Min.   :-1.000  
##  1st Qu.:-0.6904   1st Qu.:-1.000   1st Qu.:-0.2409   1st Qu.:-0.492  
##  Median :-0.1902   Median :-0.949   Median :-0.0616   Median :-0.309  
##  Mean   :-0.0879   Mean   :-0.889   Mean   :-0.0465   Mean   :-0.254  
##  3rd Qu.: 0.5158   3rd Qu.:-0.846   3rd Qu.: 0.1488   3rd Qu.:-0.070  
##  Max.   : 1.0000   Max.   : 1.000   Max.   : 1.0000   Max.   : 0.969  
##       V541             V542             V543             V544       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.802   1st Qu.:-0.993   1st Qu.:-0.994   1st Qu.:-0.993  
##  Median :-0.656   Median :-0.952   Median :-0.947   Median :-0.945  
##  Mean   :-0.565   Mean   :-0.779   Mean   :-0.792   Mean   :-0.773  
##  3rd Qu.:-0.428   3rd Qu.:-0.612   3rd Qu.:-0.643   3rd Qu.:-0.608  
##  Max.   : 0.949   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V545             V546             V547             V548       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.994   1st Qu.:-0.994   1st Qu.:-0.993   1st Qu.:-1.000  
##  Median :-0.951   Median :-0.976   Median :-0.952   Median :-0.999  
##  Mean   :-0.811   Mean   :-0.872   Mean   :-0.779   Mean   :-0.936  
##  3rd Qu.:-0.689   3rd Qu.:-0.808   3rd Qu.:-0.612   3rd Qu.:-0.922  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V549             V550             V551             V552        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.:-0.992   1st Qu.:-0.956   1st Qu.:-0.968   1st Qu.:-0.0237  
##  Median :-0.950   Median :-0.456   Median :-0.905   Median : 0.1340  
##  Mean   :-0.771   Mean   :-0.285   Mean   :-0.899   Mean   : 0.1253  
##  3rd Qu.:-0.604   3rd Qu.: 0.337   3rd Qu.:-0.873   3rd Qu.: 0.2891  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 0.968   Max.   : 0.9467  
##       V553             V554             V555              V556        
##  Min.   :-0.995   Min.   :-1.000   Min.   :-0.9766   Min.   :-1.0000  
##  1st Qu.:-0.543   1st Qu.:-0.846   1st Qu.:-0.1215   1st Qu.:-0.2895  
##  Median :-0.344   Median :-0.712   Median : 0.0095   Median : 0.0089  
##  Mean   :-0.307   Mean   :-0.625   Mean   : 0.0087   Mean   : 0.0022  
##  3rd Qu.:-0.127   3rd Qu.:-0.504   3rd Qu.: 0.1509   3rd Qu.: 0.2929  
##  Max.   : 0.990   Max.   : 0.957   Max.   : 1.0000   Max.   : 1.0000  
##       V557              V558              V559             V560        
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.:-0.4823   1st Qu.:-0.3763   1st Qu.:-0.812   1st Qu.:-0.0179  
##  Median : 0.0087   Median :-0.0004   Median :-0.709   Median : 0.1821  
##  Mean   : 0.0087   Mean   :-0.0060   Mean   :-0.489   Mean   : 0.0586  
##  3rd Qu.: 0.5062   3rd Qu.: 0.3594   3rd Qu.:-0.509   3rd Qu.: 0.2484  
##  Max.   : 0.9987   Max.   : 0.9961   Max.   : 1.000   Max.   : 0.4782  
##       V561        
##  Min.   :-1.0000  
##  1st Qu.:-0.1434  
##  Median : 0.0032  
##  Mean   :-0.0565  
##  3rd Qu.: 0.1077  
##  Max.   : 1.0000
```

#### trainLabel:

```r
summary(trainLabel)
```

```
##        V1      
##  Min.   :1.00  
##  1st Qu.:2.00  
##  Median :4.00  
##  Mean   :3.64  
##  3rd Qu.:5.00  
##  Max.   :6.00
```


#### trainSubject:

```r
summary(trainSubject)
```

```
##        V1      
##  Min.   : 1.0  
##  1st Qu.: 8.0  
##  Median :19.0  
##  Mean   :17.4  
##  3rd Qu.:26.0  
##  Max.   :30.0
```


### Test Data Structures

#### testData:

```r
summary(testData)
```

```
##        V1               V2                V3                V4        
##  Min.   :-0.592   Min.   :-0.3629   Min.   :-0.5762   Min.   :-1.000  
##  1st Qu.: 0.262   1st Qu.:-0.0250   1st Qu.:-0.1212   1st Qu.:-0.991  
##  Median : 0.277   Median :-0.0170   Median :-0.1085   Median :-0.931  
##  Mean   : 0.274   Mean   :-0.0179   Mean   :-0.1084   Mean   :-0.614  
##  3rd Qu.: 0.288   3rd Qu.:-0.0101   3rd Qu.:-0.0971   3rd Qu.:-0.267  
##  Max.   : 0.672   Max.   : 0.2461   Max.   : 0.4941   Max.   : 0.465  
##        V5               V6               V7               V8        
##  Min.   :-1.000   Min.   :-0.999   Min.   :-0.999   Min.   :-1.000  
##  1st Qu.:-0.974   1st Qu.:-0.976   1st Qu.:-0.992   1st Qu.:-0.974  
##  Median :-0.791   Median :-0.828   Median :-0.938   Median :-0.800  
##  Mean   :-0.508   Mean   :-0.634   Mean   :-0.641   Mean   :-0.523  
##  3rd Qu.:-0.106   3rd Qu.:-0.311   3rd Qu.:-0.322   3rd Qu.:-0.134  
##  Max.   : 1.000   Max.   : 0.490   Max.   : 0.440   Max.   : 1.000  
##        V9              V10              V11              V12        
##  Min.   :-0.999   Min.   :-0.952   Min.   :-0.584   Min.   :-0.846  
##  1st Qu.:-0.975   1st Qu.:-0.934   1st Qu.:-0.560   1st Qu.:-0.810  
##  Median :-0.817   Median :-0.853   Median :-0.436   Median :-0.684  
##  Mean   :-0.637   Mean   :-0.462   Mean   :-0.303   Mean   :-0.575  
##  3rd Qu.:-0.323   3rd Qu.:-0.010   3rd Qu.:-0.075   3rd Qu.:-0.375  
##  Max.   : 0.428   Max.   : 0.786   Max.   : 0.675   Max.   : 0.385  
##       V13              V14              V15              V16        
##  Min.   :-0.507   Min.   :-0.881   Min.   :-0.649   Min.   :-0.999  
##  1st Qu.: 0.241   1st Qu.: 0.147   1st Qu.: 0.406   1st Qu.:-0.978  
##  Median : 0.755   Median : 0.594   Median : 0.761   Median :-0.862  
##  Mean   : 0.530   Mean   : 0.395   Mean   : 0.607   Mean   :-0.563  
##  3rd Qu.: 0.842   3rd Qu.: 0.683   3rd Qu.: 0.835   3rd Qu.:-0.154  
##  Max.   : 0.855   Max.   : 0.708   Max.   : 0.854   Max.   : 0.485  
##       V17               V18              V19               V20        
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.0000   Min.   :-0.999  
##  1st Qu.:-0.9999   1st Qu.:-1.000   1st Qu.:-0.9993   1st Qu.:-0.994  
##  Median :-0.9966   Median :-0.989   Median :-0.9793   Median :-0.950  
##  Mean   :-0.8390   Mean   :-0.905   Mean   :-0.8768   Mean   :-0.701  
##  3rd Qu.:-0.7278   3rd Qu.:-0.843   3rd Qu.:-0.7815   3rd Qu.:-0.438  
##  Max.   : 0.0747   Max.   :-0.234   Max.   :-0.0131   Max.   : 0.494  
##       V21              V22              V23               V24         
##  Min.   :-1.000   Min.   :-0.998   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.979   1st Qu.:-0.975   1st Qu.:-0.5428   1st Qu.:-0.5276  
##  Median :-0.851   Median :-0.815   Median :-0.0234   Median :-0.0264  
##  Mean   :-0.643   Mean   :-0.665   Mean   :-0.0937   Mean   :-0.1059  
##  3rd Qu.:-0.353   3rd Qu.:-0.377   3rd Qu.: 0.3114   3rd Qu.: 0.2932  
##  Max.   : 0.657   Max.   : 0.795   Max.   : 1.0000   Max.   : 0.7248  
##       V25              V26              V27               V28         
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-0.9835  
##  1st Qu.:-0.475   1st Qu.:-0.376   1st Qu.:-0.0706   1st Qu.:-0.1896  
##  Median :-0.120   Median :-0.156   Median : 0.0974   Median :-0.0128  
##  Mean   :-0.143   Mean   :-0.125   Mean   : 0.1231   Mean   :-0.0305  
##  3rd Qu.: 0.174   3rd Qu.: 0.135   3rd Qu.: 0.3040   3rd Qu.: 0.1449  
##  Max.   : 0.916   Max.   : 0.807   Max.   : 1.0000   Max.   : 0.9078  
##       V29               V30               V31               V32         
##  Min.   :-1.0000   Min.   :-0.8281   Min.   :-0.6041   Min.   :-0.6588  
##  1st Qu.:-0.0549   1st Qu.:-0.2218   1st Qu.:-0.1088   1st Qu.: 0.0123  
##  Median : 0.1047   Median :-0.0506   Median : 0.0313   Median : 0.1420  
##  Mean   : 0.1009   Mean   :-0.0383   Mean   : 0.0452   Mean   : 0.1431  
##  3rd Qu.: 0.2554   3rd Qu.: 0.1369   3rd Qu.: 0.1908   3rd Qu.: 0.2795  
##  Max.   : 0.8791   Max.   : 0.7193   Max.   : 0.7804   Max.   : 0.8969  
##       V33               V34               V35               V36         
##  Min.   :-0.8999   Min.   :-0.8177   Min.   :-1.0000   Min.   :-0.9538  
##  1st Qu.:-0.1564   1st Qu.:-0.2049   1st Qu.:-0.1067   1st Qu.:-0.1254  
##  Median :-0.0130   Median : 0.0012   Median : 0.0277   Median : 0.0398  
##  Mean   :-0.0143   Mean   :-0.0021   Mean   : 0.0488   Mean   : 0.0290  
##  3rd Qu.: 0.1329   3rd Qu.: 0.2020   3rd Qu.: 0.1905   3rd Qu.: 0.1905  
##  Max.   : 0.7241   Max.   : 1.0000   Max.   : 0.8401   Max.   : 1.0000  
##       V37               V38              V39               V40         
##  Min.   :-0.9461   Min.   :-0.988   Min.   :-0.9773   Min.   :-1.0000  
##  1st Qu.:-0.2407   1st Qu.:-0.340   1st Qu.:-0.4224   1st Qu.:-0.1268  
##  Median :-0.0870   Median :-0.156   Median :-0.1957   Median : 0.1093  
##  Mean   :-0.0927   Mean   :-0.108   Mean   :-0.2076   Mean   : 0.0952  
##  3rd Qu.: 0.0602   3rd Qu.: 0.105   3rd Qu.:-0.0035   3rd Qu.: 0.3427  
##  Max.   : 0.6417   Max.   : 0.979   Max.   : 0.9668   Max.   : 0.9944  
##       V41              V42               V43               V44        
##  Min.   :-0.807   Min.   :-1.0000   Min.   :-0.9911   Min.   :-1.000  
##  1st Qu.: 0.834   1st Qu.:-0.2573   1st Qu.:-0.1002   1st Qu.:-0.995  
##  Median : 0.927   Median :-0.1435   Median : 0.0466   Median :-0.982  
##  Mean   : 0.682   Mean   :-0.0133   Mean   : 0.0877   Mean   :-0.967  
##  3rd Qu.: 0.958   3rd Qu.: 0.0898   3rd Qu.: 0.1708   3rd Qu.:-0.963  
##  Max.   : 1.000   Max.   : 0.9828   Max.   : 0.9956   Max.   : 0.542  
##       V45               V46              V47              V48         
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.:-0.9905   1st Qu.:-0.986   1st Qu.:-0.995   1st Qu.:-0.9909  
##  Median :-0.9742   Median :-0.967   Median :-0.983   Median :-0.9753  
##  Mean   :-0.9562   Mean   :-0.944   Mean   :-0.968   Mean   :-0.9571  
##  3rd Qu.:-0.9442   3rd Qu.:-0.934   3rd Qu.:-0.964   3rd Qu.:-0.9459  
##  Max.   :-0.0119   Max.   : 0.561   Max.   : 0.525   Max.   :-0.0717  
##       V49              V50              V51               V52         
##  Min.   :-1.000   Min.   :-0.863   Min.   :-1.0000   Min.   :-0.9907  
##  1st Qu.:-0.986   1st Qu.: 0.774   1st Qu.:-0.2642   1st Qu.:-0.0940  
##  Median :-0.968   Median : 0.865   Median :-0.1490   Median : 0.0515  
##  Mean   :-0.945   Mean   : 0.621   Mean   :-0.0279   Mean   : 0.0912  
##  3rd Qu.:-0.936   3rd Qu.: 0.890   3rd Qu.: 0.0754   3rd Qu.: 0.1725  
##  Max.   : 0.524   Max.   : 0.991   Max.   : 1.0000   Max.   : 1.0000  
##       V53              V54              V55               V56        
##  Min.   :-0.757   Min.   :-1.000   Min.   :-0.9911   Min.   :-0.901  
##  1st Qu.: 0.837   1st Qu.:-0.243   1st Qu.:-0.1103   1st Qu.:-0.423  
##  Median : 0.935   Median :-0.127   Median : 0.0364   Median :-0.197  
##  Mean   : 0.697   Mean   : 0.000   Mean   : 0.0762   Mean   :-0.149  
##  3rd Qu.: 0.971   3rd Qu.: 0.101   3rd Qu.: 0.1647   3rd Qu.: 0.114  
##  Max.   : 0.996   Max.   : 0.991   Max.   : 0.9865   Max.   : 0.952  
##       V57              V58              V59              V60        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.: 0.573   1st Qu.:-0.972   1st Qu.:-0.993   1st Qu.:-0.995  
##  Median : 0.803   Median :-0.908   Median :-0.961   Median :-0.985  
##  Mean   : 0.470   Mean   :-0.699   Mean   :-0.811   Mean   :-0.970  
##  3rd Qu.: 0.885   3rd Qu.:-0.758   3rd Qu.:-0.874   3rd Qu.:-0.966  
##  Max.   : 1.000   Max.   : 0.935   Max.   : 0.965   Max.   : 0.413  
##       V61               V62              V63              V64        
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.9921   1st Qu.:-0.988   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.9778   Median :-0.971   Median :-0.811   Median :-1.000  
##  Mean   :-0.9600   Mean   :-0.949   Mean   :-0.693   Mean   :-0.861  
##  3rd Qu.:-0.9493   3rd Qu.:-0.941   3rd Qu.:-0.417   3rd Qu.:-0.816  
##  Max.   :-0.0317   Max.   : 0.328   Max.   : 0.990   Max.   : 0.750  
##       V65              V66              V67              V68        
##  Min.   :-1.000   Min.   :-0.996   Min.   :-0.576   Min.   :-0.998  
##  1st Qu.:-1.000   1st Qu.:-0.628   1st Qu.: 0.383   1st Qu.:-0.715  
##  Median :-0.703   Median :-0.485   Median : 0.525   Median :-0.572  
##  Mean   :-0.630   Mean   :-0.476   Mean   : 0.517   Mean   :-0.558  
##  3rd Qu.:-0.341   3rd Qu.:-0.336   3rd Qu.: 0.672   3rd Qu.:-0.422  
##  Max.   : 0.877   Max.   : 0.595   Max.   : 0.997   Max.   : 0.571  
##       V69              V70              V71              V72        
##  Min.   :-0.567   Min.   :-0.999   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.: 0.456   1st Qu.:-0.555   1st Qu.: 0.130   1st Qu.:-0.566  
##  Median : 0.617   Median :-0.342   Median : 0.336   Median :-0.376  
##  Mean   : 0.597   Mean   :-0.339   Mean   : 0.328   Mean   :-0.362  
##  3rd Qu.: 0.760   3rd Qu.:-0.138   3rd Qu.: 0.544   3rd Qu.:-0.181  
##  Max.   : 0.999   Max.   : 1.000   Max.   : 1.000   Max.   : 0.883  
##       V73              V74              V75              V76        
##  Min.   :-0.804   Min.   :-0.997   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.: 0.243   1st Qu.:-0.612   1st Qu.: 0.283   1st Qu.:-0.654  
##  Median : 0.439   Median :-0.415   Median : 0.444   Median :-0.477  
##  Mean   : 0.413   Mean   :-0.420   Mean   : 0.446   Mean   :-0.471  
##  3rd Qu.: 0.610   3rd Qu.:-0.250   3rd Qu.: 0.634   3rd Qu.:-0.309  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 0.998   Max.   : 1.000  
##       V77              V78              V79              V80         
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.: 0.333   1st Qu.:-0.520   1st Qu.:-0.797   1st Qu.:-0.6115  
##  Median : 0.508   Median : 0.296   Median :-0.222   Median : 0.1619  
##  Mean   : 0.493   Mean   : 0.148   Mean   :-0.116   Mean   : 0.0753  
##  3rd Qu.: 0.680   3rd Qu.: 0.818   3rd Qu.: 0.571   3rd Qu.: 0.7595  
##  Max.   : 0.998   Max.   : 1.000   Max.   : 1.000   Max.   : 0.9998  
##       V81               V82               V83               V84        
##  Min.   :-0.8539   Min.   :-0.9487   Min.   :-0.8073   Min.   :-0.999  
##  1st Qu.: 0.0613   1st Qu.:-0.0240   1st Qu.:-0.0327   1st Qu.:-0.990  
##  Median : 0.0759   Median : 0.0108   Median :-0.0012   Median :-0.931  
##  Mean   : 0.0785   Mean   : 0.0064   Mean   :-0.0046   Mean   :-0.630  
##  3rd Qu.: 0.0921   3rd Qu.: 0.0367   3rd Qu.: 0.0244   3rd Qu.:-0.296  
##  Max.   : 0.8824   Max.   : 0.9154   Max.   : 0.8537   Max.   : 0.435  
##       V85              V86              V87              V88        
##  Min.   :-0.996   Min.   :-1.000   Min.   :-0.999   Min.   :-0.995  
##  1st Qu.:-0.983   1st Qu.:-0.988   1st Qu.:-0.990   1st Qu.:-0.981  
##  Median :-0.898   Median :-0.937   Median :-0.941   Median :-0.904  
##  Mean   :-0.601   Mean   :-0.769   Mean   :-0.629   Mean   :-0.591  
##  3rd Qu.:-0.235   3rd Qu.:-0.556   3rd Qu.:-0.285   3rd Qu.:-0.208  
##  Max.   : 1.000   Max.   : 0.103   Max.   : 0.513   Max.   : 0.917  
##       V89               V90              V91              V92        
##  Min.   :-0.9996   Min.   :-0.999   Min.   :-0.999   Min.   :-0.999  
##  1st Qu.:-0.9866   1st Qu.:-0.990   1st Qu.:-0.988   1st Qu.:-0.989  
##  Median :-0.9416   Median :-0.920   Median :-0.916   Median :-0.938  
##  Mean   :-0.7621   Mean   :-0.698   Mean   :-0.741   Mean   :-0.820  
##  3rd Qu.:-0.5462   3rd Qu.:-0.451   3rd Qu.:-0.540   3rd Qu.:-0.686  
##  Max.   : 0.0255   Max.   : 0.588   Max.   : 1.000   Max.   : 0.255  
##       V93              V94              V95              V96        
##  Min.   :-0.792   Min.   :-1.000   Min.   :-0.277   Min.   :-0.999  
##  1st Qu.: 0.254   1st Qu.: 0.397   1st Qu.: 0.537   1st Qu.:-0.988  
##  Median : 0.907   Median : 0.904   Median : 0.908   Median :-0.932  
##  Mean   : 0.597   Mean   : 0.677   Mean   : 0.748   Mean   :-0.645  
##  3rd Qu.: 0.988   3rd Qu.: 0.987   3rd Qu.: 0.986   3rd Qu.:-0.311  
##  Max.   : 0.999   Max.   : 0.999   Max.   : 1.000   Max.   : 0.293  
##       V97               V98              V99              V100       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-0.999  
##  1st Qu.:-0.9999   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.989  
##  Median :-0.9971   Median :-0.994   Median :-0.997   Median :-0.951  
##  Mean   :-0.8501   Mean   :-0.825   Mean   :-0.939   Mean   :-0.624  
##  3rd Qu.:-0.7492   3rd Qu.:-0.703   3rd Qu.:-0.897   3rd Qu.:-0.272  
##  Max.   : 0.0306   Max.   : 1.000   Max.   :-0.385   Max.   : 0.599  
##       V101             V102              V103              V104        
##  Min.   :-0.996   Min.   :-0.9998   Min.   :-0.9808   Min.   :-0.9665  
##  1st Qu.:-0.981   1st Qu.:-0.9850   1st Qu.:-0.6996   1st Qu.:-0.6912  
##  Median :-0.929   Median :-0.9472   Median :-0.2304   Median :-0.1849  
##  Mean   :-0.665   Mean   :-0.7753   Mean   :-0.0406   Mean   :-0.0583  
##  3rd Qu.:-0.350   3rd Qu.:-0.5763   3rd Qu.: 0.6214   3rd Qu.: 0.5634  
##  Max.   : 0.600   Max.   :-0.0229   Max.   : 0.9209   Max.   : 0.9385  
##       V105             V106             V107              V108        
##  Min.   :-0.976   Min.   :-1.000   Min.   :-0.8423   Min.   :-0.7101  
##  1st Qu.:-0.705   1st Qu.:-0.368   1st Qu.: 0.0717   1st Qu.:-0.0832  
##  Median :-0.301   Median :-0.128   Median : 0.1903   Median : 0.0866  
##  Mean   :-0.112   Mean   :-0.113   Mean   : 0.1887   Mean   : 0.0775  
##  3rd Qu.: 0.486   3rd Qu.: 0.145   3rd Qu.: 0.3070   3rd Qu.: 0.2457  
##  Max.   : 0.915   Max.   : 0.792   Max.   : 0.9554   Max.   : 1.0000  
##       V109              V110              V111              V112        
##  Min.   :-0.9402   Min.   :-0.7950   Min.   :-0.8074   Min.   :-0.8094  
##  1st Qu.: 0.0145   1st Qu.:-0.2744   1st Qu.:-0.0577   1st Qu.: 0.0361  
##  Median : 0.1492   Median :-0.0945   Median : 0.0826   Median : 0.1887  
##  Mean   : 0.1408   Mean   :-0.0813   Mean   : 0.0794   Mean   : 0.1783  
##  3rd Qu.: 0.2758   3rd Qu.: 0.1202   3rd Qu.: 0.2165   3rd Qu.: 0.3323  
##  Max.   : 0.7738   Max.   : 0.6849   Max.   : 0.9805   Max.   : 1.0000  
##       V113             V114              V115              V116        
##  Min.   :-0.564   Min.   :-0.8858   Min.   :-1.0000   Min.   :-0.7362  
##  1st Qu.: 0.164   1st Qu.:-0.2394   1st Qu.:-0.0199   1st Qu.:-0.1361  
##  Median : 0.296   Median :-0.0280   Median : 0.1006   Median : 0.0162  
##  Mean   : 0.295   Mean   :-0.0394   Mean   : 0.1014   Mean   : 0.0054  
##  3rd Qu.: 0.430   3rd Qu.: 0.1672   3rd Qu.: 0.2227   3rd Qu.: 0.1547  
##  Max.   : 0.916   Max.   : 1.0000   Max.   : 0.9706   Max.   : 1.0000  
##       V117              V118             V119              V120        
##  Min.   :-0.8208   Min.   :-0.926   Min.   :-0.8716   Min.   :-1.0000  
##  1st Qu.:-0.0182   1st Qu.:-0.307   1st Qu.:-0.2113   1st Qu.:-0.1142  
##  Median : 0.1385   Median :-0.125   Median : 0.0040   Median : 0.0636  
##  Mean   : 0.1360   Mean   :-0.121   Mean   :-0.0109   Mean   : 0.0604  
##  3rd Qu.: 0.2972   3rd Qu.: 0.053   3rd Qu.: 0.1895   3rd Qu.: 0.2504  
##  Max.   : 0.8595   Max.   : 1.000   Max.   : 1.0000   Max.   : 0.9330  
##       V121              V122              V123              V124       
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.0529   1st Qu.:-0.1048   1st Qu.: 0.0660   1st Qu.:-0.985  
##  Median :-0.0281   Median :-0.0747   Median : 0.0868   Median :-0.860  
##  Mean   :-0.0405   Mean   :-0.0711   Mean   : 0.0928   Mean   :-0.722  
##  3rd Qu.:-0.0108   3rd Qu.:-0.0485   3rd Qu.: 0.1132   3rd Qu.:-0.496  
##  Max.   : 1.0000   Max.   : 0.7573   Max.   : 0.8813   Max.   : 0.484  
##       V125             V126             V127             V128       
##  Min.   :-0.999   Min.   :-1.000   Min.   :-1.000   Min.   :-0.999  
##  1st Qu.:-0.978   1st Qu.:-0.980   1st Qu.:-0.986   1st Qu.:-0.979  
##  Median :-0.888   Median :-0.862   Median :-0.874   Median :-0.900  
##  Mean   :-0.700   Mean   :-0.651   Mean   :-0.727   Mean   :-0.709  
##  3rd Qu.:-0.475   3rd Qu.:-0.352   3rd Qu.:-0.504   3rd Qu.:-0.491  
##  Max.   : 0.447   Max.   : 0.450   Max.   : 0.483   Max.   : 0.493  
##       V129             V130             V131             V132       
##  Min.   :-1.000   Min.   :-0.978   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.981   1st Qu.:-0.875   1st Qu.:-0.946   1st Qu.:-0.745  
##  Median :-0.867   Median :-0.777   Median :-0.869   Median :-0.602  
##  Mean   :-0.667   Mean   :-0.652   Mean   :-0.750   Mean   :-0.480  
##  3rd Qu.:-0.378   3rd Qu.:-0.453   3rd Qu.:-0.594   3rd Qu.:-0.257  
##  Max.   : 0.438   Max.   : 0.608   Max.   : 0.223   Max.   : 0.613  
##       V133             V134             V135             V136       
##  Min.   :-0.491   Min.   :-0.095   Min.   :-0.907   Min.   :-0.998  
##  1st Qu.: 0.462   1st Qu.: 0.617   1st Qu.: 0.340   1st Qu.:-0.974  
##  Median : 0.744   Median : 0.829   Median : 0.718   Median :-0.767  
##  Mean   : 0.627   Mean   : 0.740   Mean   : 0.555   Mean   :-0.609  
##  3rd Qu.: 0.836   3rd Qu.: 0.903   3rd Qu.: 0.820   3rd Qu.:-0.274  
##  Max.   : 0.902   Max.   : 0.984   Max.   : 0.973   Max.   : 0.433  
##       V137             V138              V139              V140       
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-0.9996   1st Qu.:-0.9996   1st Qu.:-0.988  
##  Median :-0.984   Median :-0.9879   Median :-0.9702   Median :-0.895  
##  Mean   :-0.905   Mean   :-0.9022   Mean   :-0.8775   Mean   :-0.728  
##  3rd Qu.:-0.839   3rd Qu.:-0.8574   3rd Qu.:-0.7976   3rd Qu.:-0.507  
##  Max.   : 0.127   Max.   : 0.0304   Max.   : 0.0546   Max.   : 0.543  
##       V141             V142             V143             V144        
##  Min.   :-0.999   Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.:-0.983   1st Qu.:-0.985   1st Qu.:-0.492   1st Qu.:-0.3173  
##  Median :-0.915   Median :-0.887   Median :-0.157   Median :-0.0267  
##  Mean   :-0.727   Mean   :-0.724   Mean   :-0.140   Mean   :-0.0721  
##  3rd Qu.:-0.533   3rd Qu.:-0.491   3rd Qu.: 0.181   3rd Qu.: 0.1895  
##  Max.   : 0.549   Max.   : 0.358   Max.   : 0.997   Max.   : 1.0000  
##       V145              V146              V147              V148        
##  Min.   :-1.0000   Min.   :-0.9242   Min.   :-0.9639   Min.   :-0.9876  
##  1st Qu.:-0.4083   1st Qu.:-0.4105   1st Qu.: 0.0086   1st Qu.:-0.0486  
##  Median : 0.0747   Median :-0.2579   Median : 0.1619   Median : 0.1113  
##  Mean   :-0.0322   Mean   :-0.2303   Mean   : 0.1629   Mean   : 0.1020  
##  3rd Qu.: 0.3168   3rd Qu.:-0.0653   3rd Qu.: 0.3088   3rd Qu.: 0.2527  
##  Max.   : 0.9761   Max.   : 0.9361   Max.   : 0.9337   Max.   : 0.9873  
##       V149              V150              V151              V152        
##  Min.   :-1.0000   Min.   :-0.9437   Min.   :-0.5800   Min.   :-1.0000  
##  1st Qu.:-0.2209   1st Qu.:-0.3467   1st Qu.: 0.0559   1st Qu.:-0.2051  
##  Median :-0.0679   Median :-0.2167   Median : 0.1768   Median :-0.0564  
##  Mean   :-0.0677   Mean   :-0.2089   Mean   : 0.1825   Mean   :-0.0598  
##  3rd Qu.: 0.0845   3rd Qu.:-0.0765   3rd Qu.: 0.3041   3rd Qu.: 0.0851  
##  Max.   : 1.0000   Max.   : 0.6430   Max.   : 0.9375   Max.   : 0.8643  
##       V153              V154              V155              V156        
##  Min.   :-0.9111   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.: 0.0044   1st Qu.:-0.3355   1st Qu.:-0.1389   1st Qu.:-0.2013  
##  Median : 0.1586   Median :-0.0983   Median : 0.0687   Median :-0.0004  
##  Mean   : 0.1503   Mean   :-0.0964   Mean   : 0.0781   Mean   :-0.0174  
##  3rd Qu.: 0.3090   3rd Qu.: 0.1275   3rd Qu.: 0.2848   3rd Qu.: 0.1659  
##  Max.   : 0.8944   Max.   : 1.0000   Max.   : 1.0000   Max.   : 0.7997  
##       V157              V158              V159              V160        
##  Min.   :-0.7728   Min.   :-0.9892   Min.   :-0.9693   Min.   :-0.9895  
##  1st Qu.:-0.0325   1st Qu.:-0.4142   1st Qu.:-0.1971   1st Qu.:-0.3380  
##  Median : 0.1473   Median :-0.1496   Median : 0.0273   Median :-0.0443  
##  Mean   : 0.1419   Mean   :-0.1599   Mean   : 0.0476   Mean   :-0.0761  
##  3rd Qu.: 0.3135   3rd Qu.: 0.0771   3rd Qu.: 0.2814   3rd Qu.: 0.1874  
##  Max.   : 1.0000   Max.   : 0.9680   Max.   : 0.9923   Max.   : 0.9901  
##       V161              V162              V163              V164       
##  Min.   :-0.6554   Min.   :-0.7759   Min.   :-0.8653   Min.   :-1.000  
##  1st Qu.:-0.1176   1st Qu.:-0.0581   1st Qu.:-0.0816   1st Qu.:-0.989  
##  Median :-0.0980   Median :-0.0403   Median :-0.0544   Median :-0.904  
##  Mean   :-0.0938   Mean   :-0.0420   Mean   :-0.0561   Mean   :-0.735  
##  3rd Qu.:-0.0735   3rd Qu.:-0.0237   3rd Qu.:-0.0302   3rd Qu.:-0.491  
##  Max.   : 0.8605   Max.   : 1.0000   Max.   : 0.6432   Max.   : 0.280  
##       V165             V166             V167             V168       
##  Min.   :-0.999   Min.   :-0.999   Min.   :-1.000   Min.   :-0.999  
##  1st Qu.:-0.990   1st Qu.:-0.991   1st Qu.:-0.989   1st Qu.:-0.990  
##  Median :-0.937   Median :-0.936   Median :-0.915   Median :-0.950  
##  Mean   :-0.791   Mean   :-0.735   Mean   :-0.736   Mean   :-0.803  
##  3rd Qu.:-0.621   3rd Qu.:-0.514   3rd Qu.:-0.486   3rd Qu.:-0.636  
##  Max.   : 0.234   Max.   : 0.537   Max.   : 0.118   Max.   : 0.143  
##       V169             V170             V171             V172       
##  Min.   :-0.999   Min.   :-1.000   Min.   :-1.000   Min.   :-0.999  
##  1st Qu.:-0.991   1st Qu.:-0.988   1st Qu.:-0.991   1st Qu.:-0.988  
##  Median :-0.944   Median :-0.889   Median :-0.930   Median :-0.915  
##  Mean   :-0.743   Mean   :-0.738   Mean   :-0.814   Mean   :-0.732  
##  3rd Qu.:-0.518   3rd Qu.:-0.515   3rd Qu.:-0.683   3rd Qu.:-0.532  
##  Max.   : 0.332   Max.   : 1.000   Max.   : 0.357   Max.   : 1.000  
##       V173             V174             V175             V176        
##  Min.   :-0.844   Min.   :-0.450   Min.   :-1.000   Min.   :-0.9996  
##  1st Qu.: 0.583   1st Qu.: 0.720   1st Qu.: 0.640   1st Qu.:-0.9904  
##  Median : 0.899   Median : 0.937   Median : 0.942   Median :-0.9394  
##  Mean   : 0.763   Mean   : 0.830   Mean   : 0.796   Mean   :-0.7706  
##  3rd Qu.: 0.989   3rd Qu.: 0.992   3rd Qu.: 0.993   3rd Qu.:-0.5714  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 0.0293  
##       V177             V178             V179             V180       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.989  
##  Median :-0.995   Median :-0.998   Median :-0.998   Median :-0.932  
##  Mean   :-0.924   Mean   :-0.948   Mean   :-0.920   Mean   :-0.746  
##  3rd Qu.:-0.869   3rd Qu.:-0.927   3rd Qu.:-0.880   3rd Qu.:-0.513  
##  Max.   :-0.179   Max.   :-0.237   Max.   : 0.184   Max.   : 0.125  
##       V181              V182             V183              V184        
##  Min.   :-0.9993   Min.   :-1.000   Min.   :-0.9560   Min.   :-0.9203  
##  1st Qu.:-0.9914   1st Qu.:-0.992   1st Qu.:-0.5244   1st Qu.:-0.4310  
##  Median :-0.9599   Median :-0.957   Median : 0.0924   Median : 0.0929  
##  Mean   :-0.8164   Mean   :-0.766   Mean   : 0.0156   Mean   : 0.0614  
##  3rd Qu.:-0.6590   3rd Qu.:-0.560   3rd Qu.: 0.5355   3rd Qu.: 0.5517  
##  Max.   : 0.0867   Max.   : 0.207   Max.   : 0.9402   Max.   : 1.0000  
##       V185              V186              V187              V188        
##  Min.   :-0.9655   Min.   :-1.0000   Min.   :-0.9430   Min.   :-0.8334  
##  1st Qu.:-0.5576   1st Qu.:-0.2388   1st Qu.:-0.0562   1st Qu.: 0.0266  
##  Median :-0.0507   Median :-0.0966   Median : 0.0606   Median : 0.1624  
##  Mean   : 0.0199   Mean   :-0.0766   Mean   : 0.0575   Mean   : 0.1563  
##  3rd Qu.: 0.5807   3rd Qu.: 0.0720   3rd Qu.: 0.1709   3rd Qu.: 0.2973  
##  Max.   : 0.9341   Max.   : 0.9199   Max.   : 0.7640   Max.   : 0.9436  
##       V189              V190              V191             V192        
##  Min.   :-0.6144   Min.   :-1.0000   Min.   :-0.564   Min.   :-1.0000  
##  1st Qu.:-0.0021   1st Qu.:-0.3155   1st Qu.: 0.121   1st Qu.:-0.0532  
##  Median : 0.1520   Median :-0.1796   Median : 0.212   Median : 0.0842  
##  Mean   : 0.1427   Mean   :-0.1681   Mean   : 0.216   Mean   : 0.0795  
##  3rd Qu.: 0.2952   3rd Qu.:-0.0361   3rd Qu.: 0.315   3rd Qu.: 0.2143  
##  Max.   : 0.8089   Max.   : 0.8714   Max.   : 1.000   Max.   : 1.0000  
##       V193              V194              V195              V196        
##  Min.   :-0.8494   Min.   :-1.0000   Min.   :-0.9301   Min.   :-1.0000  
##  1st Qu.:-0.0855   1st Qu.:-0.3000   1st Qu.:-0.0993   1st Qu.:-0.0597  
##  Median : 0.0831   Median :-0.0538   Median : 0.0580   Median : 0.0939  
##  Mean   : 0.0740   Mean   :-0.0354   Mean   : 0.0599   Mean   : 0.0927  
##  3rd Qu.: 0.2487   3rd Qu.: 0.2119   3rd Qu.: 0.2208   3rd Qu.: 0.2520  
##  Max.   : 1.0000   Max.   : 1.0000   Max.   : 0.8232   Max.   : 0.7368  
##       V197             V198              V199              V200        
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-0.8334   Min.   :-0.8520  
##  1st Qu.:-0.156   1st Qu.:-0.1727   1st Qu.:-0.1278   1st Qu.:-0.2527  
##  Median : 0.026   Median : 0.0250   Median : 0.0445   Median :-0.0855  
##  Mean   : 0.018   Mean   : 0.0256   Mean   : 0.0497   Mean   :-0.0763  
##  3rd Qu.: 0.200   3rd Qu.: 0.2202   3rd Qu.: 0.2297   3rd Qu.: 0.0790  
##  Max.   : 0.983   Max.   : 0.8276   Max.   : 0.8773   Max.   : 1.0000  
##       V201             V202             V203             V204       
##  Min.   :-0.999   Min.   :-1.000   Min.   :-1.000   Min.   :-0.998  
##  1st Qu.:-0.978   1st Qu.:-0.979   1st Qu.:-0.981   1st Qu.:-0.977  
##  Median :-0.862   Median :-0.810   Median :-0.841   Median :-0.822  
##  Mean   :-0.559   Mean   :-0.597   Mean   :-0.651   Mean   :-0.562  
##  3rd Qu.:-0.150   3rd Qu.:-0.264   3rd Qu.:-0.358   3rd Qu.:-0.196  
##  Max.   : 0.479   Max.   : 0.453   Max.   : 0.263   Max.   : 0.695  
##       V205             V206             V207             V208       
##  Min.   :-1.000   Min.   :-0.999   Min.   :-1.000   Min.   :-0.998  
##  1st Qu.:-0.992   1st Qu.:-0.978   1st Qu.:-1.000   1st Qu.:-0.983  
##  Median :-0.962   Median :-0.862   Median :-0.986   Median :-0.856  
##  Mean   :-0.836   Mean   :-0.559   Mean   :-0.795   Mean   :-0.718  
##  3rd Qu.:-0.691   3rd Qu.:-0.150   3rd Qu.:-0.622   3rd Qu.:-0.498  
##  Max.   :-0.119   Max.   : 0.479   Max.   : 0.149   Max.   : 0.214  
##       V209             V210              V211              V212        
##  Min.   :-1.000   Min.   :-0.8542   Min.   :-0.8421   Min.   :-0.9004  
##  1st Qu.:-0.502   1st Qu.:-0.2628   1st Qu.:-0.1423   1st Qu.:-0.1162  
##  Median : 0.228   Median :-0.0643   Median : 0.0175   Median : 0.0506  
##  Mean   : 0.154   Mean   :-0.0622   Mean   : 0.0217   Mean   : 0.0533  
##  3rd Qu.: 0.786   3rd Qu.: 0.1345   3rd Qu.: 0.1771   3rd Qu.: 0.2223  
##  Max.   : 0.974   Max.   : 0.8807   Max.   : 0.7078   Max.   : 1.0000  
##       V213              V214             V215             V216       
##  Min.   :-0.8220   Min.   :-0.999   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.2323   1st Qu.:-0.978   1st Qu.:-0.979   1st Qu.:-0.981  
##  Median :-0.0461   Median :-0.862   Median :-0.810   Median :-0.841  
##  Mean   :-0.0559   Mean   :-0.559   Mean   :-0.597   Mean   :-0.651  
##  3rd Qu.: 0.1170   3rd Qu.:-0.150   3rd Qu.:-0.264   3rd Qu.:-0.358  
##  Max.   : 0.7946   Max.   : 0.479   Max.   : 0.453   Max.   : 0.263  
##       V217             V218             V219             V220       
##  Min.   :-0.998   Min.   :-1.000   Min.   :-0.999   Min.   :-1.000  
##  1st Qu.:-0.977   1st Qu.:-0.992   1st Qu.:-0.978   1st Qu.:-1.000  
##  Median :-0.822   Median :-0.962   Median :-0.862   Median :-0.986  
##  Mean   :-0.562   Mean   :-0.836   Mean   :-0.559   Mean   :-0.795  
##  3rd Qu.:-0.196   3rd Qu.:-0.691   3rd Qu.:-0.150   3rd Qu.:-0.622  
##  Max.   : 0.695   Max.   :-0.119   Max.   : 0.479   Max.   : 0.149  
##       V221             V222             V223              V224        
##  Min.   :-0.998   Min.   :-1.000   Min.   :-0.8542   Min.   :-0.8421  
##  1st Qu.:-0.983   1st Qu.:-0.502   1st Qu.:-0.2628   1st Qu.:-0.1423  
##  Median :-0.856   Median : 0.228   Median :-0.0643   Median : 0.0175  
##  Mean   :-0.718   Mean   : 0.154   Mean   :-0.0622   Mean   : 0.0217  
##  3rd Qu.:-0.498   3rd Qu.: 0.786   3rd Qu.: 0.1345   3rd Qu.: 0.1771  
##  Max.   : 0.214   Max.   : 0.974   Max.   : 0.8807   Max.   : 0.7078  
##       V225              V226              V227             V228       
##  Min.   :-0.9004   Min.   :-0.8220   Min.   :-0.999   Min.   :-1.000  
##  1st Qu.:-0.1162   1st Qu.:-0.2323   1st Qu.:-0.988   1st Qu.:-0.989  
##  Median : 0.0506   Median :-0.0461   Median :-0.933   Median :-0.896  
##  Mean   : 0.0533   Mean   :-0.0559   Mean   :-0.647   Mean   :-0.616  
##  3rd Qu.: 0.2223   3rd Qu.: 0.1170   3rd Qu.:-0.316   3rd Qu.:-0.272  
##  Max.   : 1.0000   Max.   : 0.7946   Max.   : 0.277   Max.   : 0.867  
##       V229             V230             V231             V232       
##  Min.   :-1.000   Min.   :-0.999   Min.   :-1.000   Min.   :-0.999  
##  1st Qu.:-0.990   1st Qu.:-0.988   1st Qu.:-0.982   1st Qu.:-0.988  
##  Median :-0.911   Median :-0.887   Median :-0.952   Median :-0.933  
##  Mean   :-0.636   Mean   :-0.629   Mean   :-0.792   Mean   :-0.647  
##  3rd Qu.:-0.308   3rd Qu.:-0.299   3rd Qu.:-0.620   3rd Qu.:-0.316  
##  Max.   : 0.642   Max.   : 1.000   Max.   : 0.179   Max.   : 0.277  
##       V233              V234             V235              V236        
##  Min.   :-1.0000   Min.   :-0.999   Min.   :-0.9774   Min.   :-0.7068  
##  1st Qu.:-0.9998   1st Qu.:-0.991   1st Qu.:-0.7786   1st Qu.:-0.0947  
##  Median :-0.9960   Median :-0.937   Median :-0.2068   Median : 0.0954  
##  Mean   :-0.8540   Mean   :-0.692   Mean   :-0.0305   Mean   : 0.0772  
##  3rd Qu.:-0.7434   3rd Qu.:-0.409   3rd Qu.: 0.6990   3rd Qu.: 0.2553  
##  Max.   : 0.0518   Max.   : 0.298   Max.   : 0.9131   Max.   : 1.0000  
##       V237              V238              V239              V240       
##  Min.   :-0.7783   Min.   :-1.0000   Min.   :-0.8922   Min.   :-0.998  
##  1st Qu.:-0.2007   1st Qu.:-0.2772   1st Qu.:-0.2020   1st Qu.:-0.974  
##  Median :-0.0532   Median :-0.1141   Median :-0.0286   Median :-0.772  
##  Mean   :-0.0273   Mean   :-0.1082   Mean   :-0.0224   Mean   :-0.611  
##  3rd Qu.: 0.1328   3rd Qu.: 0.0599   3rd Qu.: 0.1529   3rd Qu.:-0.277  
##  Max.   : 0.9691   Max.   : 1.0000   Max.   : 1.0000   Max.   : 0.405  
##       V241             V242             V243             V244       
##  Min.   :-0.999   Min.   :-0.999   Min.   :-0.999   Min.   :-1.000  
##  1st Qu.:-0.973   1st Qu.:-0.970   1st Qu.:-0.976   1st Qu.:-0.986  
##  Median :-0.786   Median :-0.773   Median :-0.810   Median :-0.841  
##  Mean   :-0.679   Mean   :-0.649   Mean   :-0.703   Mean   :-0.718  
##  3rd Qu.:-0.441   3rd Qu.:-0.378   3rd Qu.:-0.475   3rd Qu.:-0.506  
##  Max.   : 0.863   Max.   : 0.977   Max.   : 0.162   Max.   : 0.800  
##       V245             V246              V247             V248        
##  Min.   :-0.998   Min.   :-1.0000   Min.   :-0.999   Min.   :-0.9034  
##  1st Qu.:-0.974   1st Qu.:-0.9995   1st Qu.:-0.974   1st Qu.:-0.0682  
##  Median :-0.772   Median :-0.9696   Median :-0.782   Median : 0.3516  
##  Mean   :-0.611   Mean   :-0.8481   Mean   :-0.671   Mean   : 0.2986  
##  3rd Qu.:-0.277   3rd Qu.:-0.7336   3rd Qu.:-0.411   3rd Qu.: 0.7193  
##  Max.   : 0.405   Max.   : 0.0278   Max.   : 1.000   Max.   : 1.0000  
##       V249              V250              V251              V252        
##  Min.   :-0.8729   Min.   :-0.7987   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.1977   1st Qu.:-0.2546   1st Qu.:-0.0698   1st Qu.:-0.2102  
##  Median :-0.0164   Median :-0.0754   Median : 0.0947   Median :-0.0322  
##  Mean   :-0.0106   Mean   :-0.0758   Mean   : 0.0978   Mean   :-0.0438  
##  3rd Qu.: 0.1719   3rd Qu.: 0.0939   3rd Qu.: 0.2612   3rd Qu.: 0.1287  
##  Max.   : 1.0000   Max.   : 0.9603   Max.   : 1.0000   Max.   : 0.8333  
##       V253              V254             V255             V256       
##  Min.   :-0.9996   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.9899   1st Qu.:-0.990   1st Qu.:-0.990   1st Qu.:-0.990  
##  Median :-0.9371   Median :-0.912   Median :-0.925   Median :-0.908  
##  Mean   :-0.7667   Mean   :-0.778   Mean   :-0.794   Mean   :-0.784  
##  3rd Qu.:-0.5681   3rd Qu.:-0.613   3rd Qu.:-0.640   3rd Qu.:-0.626  
##  Max.   : 0.0747   Max.   : 0.200   Max.   : 0.085   Max.   : 0.428  
##       V257             V258              V259             V260        
##  Min.   :-0.999   Min.   :-0.9996   Min.   :-1.000   Min.   :-0.9998  
##  1st Qu.:-0.989   1st Qu.:-0.9899   1st Qu.:-1.000   1st Qu.:-0.9916  
##  Median :-0.964   Median :-0.9371   Median :-0.997   Median :-0.9398  
##  Mean   :-0.804   Mean   :-0.7667   Mean   :-0.939   Mean   :-0.8099  
##  3rd Qu.:-0.651   3rd Qu.:-0.5681   3rd Qu.:-0.909   3rd Qu.:-0.6566  
##  Max.   : 0.519   Max.   : 0.0747   Max.   :-0.429   Max.   :-0.0026  
##       V261             V262             V263             V264        
##  Min.   :-0.980   Min.   :-0.645   Min.   :-1.000   Min.   :-0.8638  
##  1st Qu.:-0.474   1st Qu.: 0.159   1st Qu.:-0.375   1st Qu.:-0.2255  
##  Median : 0.220   Median : 0.311   Median :-0.242   Median :-0.0841  
##  Mean   : 0.181   Mean   : 0.303   Mean   :-0.238   Mean   :-0.0797  
##  3rd Qu.: 0.837   3rd Qu.: 0.465   3rd Qu.:-0.111   3rd Qu.: 0.0690  
##  Max.   : 0.970   Max.   : 1.000   Max.   : 0.579   Max.   : 1.0000  
##       V265              V266             V267             V268       
##  Min.   :-0.9187   Min.   :-1.000   Min.   :-0.998   Min.   :-0.999  
##  1st Qu.:-0.2623   1st Qu.:-0.990   1st Qu.:-0.976   1st Qu.:-0.981  
##  Median :-0.0970   Median :-0.928   Median :-0.829   Median :-0.872  
##  Mean   :-0.0822   Mean   :-0.623   Mean   :-0.534   Mean   :-0.676  
##  3rd Qu.: 0.0724   3rd Qu.:-0.287   3rd Qu.:-0.139   3rd Qu.:-0.389  
##  Max.   : 1.0000   Max.   : 0.424   Max.   : 1.000   Max.   : 0.427  
##       V269             V270             V271             V272       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-0.999   Min.   :-1.000  
##  1st Qu.:-0.992   1st Qu.:-0.974   1st Qu.:-0.975   1st Qu.:-0.991  
##  Median :-0.929   Median :-0.782   Median :-0.815   Median :-0.930  
##  Mean   :-0.611   Mean   :-0.528   Mean   :-0.641   Mean   :-0.592  
##  3rd Qu.:-0.264   3rd Qu.:-0.142   3rd Qu.:-0.332   3rd Qu.:-0.224  
##  Max.   : 0.543   Max.   : 1.000   Max.   : 0.436   Max.   : 0.597  
##       V273             V274             V275             V276       
##  Min.   :-1.000   Min.   :-0.998   Min.   :-1.000   Min.   :-0.999  
##  1st Qu.:-0.977   1st Qu.:-0.978   1st Qu.:-0.994   1st Qu.:-0.977  
##  Median :-0.823   Median :-0.857   Median :-0.938   Median :-0.825  
##  Mean   :-0.521   Mean   :-0.646   Mean   :-0.662   Mean   :-0.654  
##  3rd Qu.:-0.121   3rd Qu.:-0.329   3rd Qu.:-0.368   3rd Qu.:-0.384  
##  Max.   : 1.000   Max.   : 0.611   Max.   : 0.549   Max.   : 0.729  
##       V277             V278             V279             V280       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.970   1st Qu.:-0.994   1st Qu.:-0.991   1st Qu.:-0.991  
##  Median :-0.774   Median :-0.974   Median :-0.967   Median :-0.973  
##  Mean   :-0.661   Mean   :-0.864   Mean   :-0.881   Mean   :-0.917  
##  3rd Qu.:-0.392   3rd Qu.:-0.797   3rd Qu.:-0.826   3rd Qu.:-0.887  
##  Max.   : 0.867   Max.   : 0.733   Max.   : 0.618   Max.   : 0.427  
##       V281             V282              V283             V284       
##  Min.   :-0.999   Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.984   1st Qu.:-0.9999   1st Qu.:-0.999   1st Qu.:-0.999  
##  Median :-0.874   Median :-0.9973   Median :-0.976   Median :-0.983  
##  Mean   :-0.558   Mean   :-0.8393   Mean   :-0.754   Mean   :-0.863  
##  3rd Qu.:-0.142   3rd Qu.:-0.7297   3rd Qu.:-0.595   3rd Qu.:-0.755  
##  Max.   : 0.577   Max.   : 0.0751   Max.   : 1.000   Max.   : 0.116  
##       V285             V286             V287             V288       
##  Min.   :-0.998   Min.   :-1.000   Min.   :-0.995   Min.   :-1.000  
##  1st Qu.:-0.989   1st Qu.:-0.985   1st Qu.:-0.982   1st Qu.:-0.946  
##  Median :-0.924   Median :-0.901   Median :-0.919   Median :-0.378  
##  Mean   :-0.644   Mean   :-0.642   Mean   :-0.747   Mean   :-0.174  
##  3rd Qu.:-0.334   3rd Qu.:-0.320   3rd Qu.:-0.537   3rd Qu.: 0.547  
##  Max.   : 0.789   Max.   : 0.874   Max.   : 0.446   Max.   : 0.975  
##       V289             V290             V291             V292       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.850   1st Qu.:-0.810   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.275   Median :-0.317   Median :-0.806   Median :-0.800  
##  Mean   :-0.160   Mean   :-0.191   Mean   :-0.744   Mean   :-0.800  
##  3rd Qu.: 0.499   3rd Qu.: 0.408   3rd Qu.:-0.742   3rd Qu.:-0.733  
##  Max.   : 1.000   Max.   : 0.833   Max.   : 0.935   Max.   : 0.400  
##       V293             V294              V295              V296        
##  Min.   :-1.000   Min.   :-0.9295   Min.   :-0.8771   Min.   :-0.9990  
##  1st Qu.:-1.000   1st Qu.:-0.4072   1st Qu.:-0.1376   1st Qu.:-0.1238  
##  Median :-0.923   Median :-0.2268   Median : 0.0094   Median : 0.0563  
##  Mean   :-0.843   Mean   :-0.2069   Mean   : 0.0199   Mean   : 0.0523  
##  3rd Qu.:-0.769   3rd Qu.:-0.0107   3rd Qu.: 0.1788   3rd Qu.: 0.2396  
##  Max.   : 1.000   Max.   : 1.0000   Max.   : 0.8645   Max.   : 0.9656  
##       V297             V298             V299             V300       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-0.910   Min.   :-0.992  
##  1st Qu.:-0.497   1st Qu.:-0.853   1st Qu.:-0.531   1st Qu.:-0.852  
##  Median :-0.202   Median :-0.616   Median :-0.365   Median :-0.723  
##  Mean   :-0.154   Mean   :-0.484   Mean   :-0.279   Mean   :-0.593  
##  3rd Qu.: 0.140   3rd Qu.:-0.186   3rd Qu.:-0.104   3rd Qu.:-0.467  
##  Max.   : 0.960   Max.   : 0.945   Max.   : 1.000   Max.   : 1.000  
##       V301              V302             V303             V304        
##  Min.   :-0.9916   Min.   :-0.997   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.:-0.5586   1st Qu.:-0.805   1st Qu.:-1.000   1st Qu.:-0.9999  
##  Median :-0.3207   Median :-0.609   Median :-0.997   Median :-0.9981  
##  Mean   :-0.2484   Mean   :-0.486   Mean   :-0.838   Mean   :-0.8853  
##  3rd Qu.: 0.0166   3rd Qu.:-0.249   3rd Qu.:-0.736   3rd Qu.:-0.8222  
##  Max.   : 1.0000   Max.   : 1.000   Max.   : 0.244   Max.   :-0.0878  
##       V305             V306             V307             V308       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.997   Median :-0.997   Median :-0.997   Median :-0.998  
##  Mean   :-0.858   Mean   :-0.888   Mean   :-0.919   Mean   :-0.919  
##  3rd Qu.:-0.781   3rd Qu.:-0.852   3rd Qu.:-0.884   3rd Qu.:-0.877  
##  Max.   : 0.568   Max.   : 1.000   Max.   : 0.116   Max.   : 0.594  
##       V309             V310             V311              V312       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.9999   1st Qu.:-1.000  
##  Median :-0.998   Median :-1.000   Median :-0.9973   Median :-0.996  
##  Mean   :-0.951   Mean   :-0.962   Mean   :-0.8366   Mean   :-0.845  
##  3rd Qu.:-0.931   3rd Qu.:-0.975   3rd Qu.:-0.7243   3rd Qu.:-0.761  
##  Max.   : 0.199   Max.   : 0.117   Max.   : 0.0932   Max.   : 0.460  
##       V313              V314             V315              V316       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.9999   1st Qu.:-1.000   1st Qu.:-0.9999   1st Qu.:-1.000  
##  Median :-0.9972   Median :-0.998   Median :-0.9974   Median :-0.996  
##  Mean   :-0.9187   Mean   :-0.955   Mean   :-0.8381   Mean   :-0.881  
##  3rd Qu.:-0.8781   3rd Qu.:-0.942   3rd Qu.:-0.7265   3rd Qu.:-0.827  
##  Max.   : 0.0265   Max.   : 0.159   Max.   : 0.0795   Max.   : 0.570  
##       V317             V318             V319             V320       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.999   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.971   Median :-0.995   Median :-0.995   Median :-0.995  
##  Mean   :-0.789   Mean   :-0.852   Mean   :-0.857   Mean   :-0.894  
##  3rd Qu.:-0.646   3rd Qu.:-0.774   3rd Qu.:-0.777   3rd Qu.:-0.841  
##  Max.   : 0.723   Max.   : 1.000   Max.   : 0.668   Max.   : 1.000  
##       V321             V322             V323             V324       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.993   Median :-0.992   Median :-0.991   Median :-0.999  
##  Mean   :-0.898   Mean   :-0.885   Mean   :-0.904   Mean   :-0.951  
##  3rd Qu.:-0.850   3rd Qu.:-0.826   3rd Qu.:-0.871   3rd Qu.:-0.968  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 0.993   Max.   : 0.963  
##       V325             V326             V327             V328       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.999   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.975   Median :-0.994   Median :-0.992   Median :-0.992  
##  Mean   :-0.762   Mean   :-0.831   Mean   :-0.881   Mean   :-0.921  
##  3rd Qu.:-0.613   3rd Qu.:-0.729   3rd Qu.:-0.820   3rd Qu.:-0.902  
##  Max.   : 1.000   Max.   : 0.937   Max.   : 0.716   Max.   : 0.969  
##       V329             V330             V331              V332        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.999   1st Qu.:-1.000   1st Qu.:-0.9993   1st Qu.:-0.9997  
##  Median :-0.976   Median :-0.994   Median :-0.9793   Median :-0.9952  
##  Mean   :-0.757   Mean   :-0.884   Mean   :-0.8804   Mean   :-0.9095  
##  3rd Qu.:-0.601   3rd Qu.:-0.822   3rd Qu.:-0.7991   3rd Qu.:-0.8711  
##  Max.   : 1.000   Max.   : 0.923   Max.   : 0.0487   Max.   : 0.0424  
##       V333              V334             V335             V336       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.9997   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.9965   Median :-0.998   Median :-0.997   Median :-0.995  
##  Mean   :-0.9356   Mean   :-0.967   Mean   :-0.970   Mean   :-0.948  
##  3rd Qu.:-0.9068   3rd Qu.:-0.954   3rd Qu.:-0.958   3rd Qu.:-0.922  
##  Max.   :-0.0472   Max.   :-0.345   Max.   :-0.466   Max.   :-0.129  
##       V337             V338             V339              V340       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.9994   1st Qu.:-1.000  
##  Median :-0.994   Median :-0.999   Median :-0.9824   Median :-0.997  
##  Mean   :-0.949   Mean   :-0.963   Mean   :-0.8752   Mean   :-0.947  
##  3rd Qu.:-0.930   3rd Qu.:-0.975   3rd Qu.:-0.7805   3rd Qu.:-0.921  
##  Max.   :-0.151   Max.   : 0.163   Max.   : 0.0724   Max.   :-0.309  
##       V341             V342             V343             V344       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.999   1st Qu.:-1.000  
##  Median :-0.997   Median :-0.994   Median :-0.982   Median :-0.998  
##  Mean   :-0.962   Mean   :-0.953   Mean   :-0.866   Mean   :-0.966  
##  3rd Qu.:-0.943   3rd Qu.:-0.938   3rd Qu.:-0.763   3rd Qu.:-0.950  
##  Max.   :-0.404   Max.   :-0.101   Max.   : 0.106   Max.   :-0.408  
##       V345             V346             V347             V348       
##  Min.   :-0.999   Min.   :-0.997   Min.   :-0.999   Min.   :-0.999  
##  1st Qu.:-0.990   1st Qu.:-0.983   1st Qu.:-0.986   1st Qu.:-0.991  
##  Median :-0.932   Median :-0.901   Median :-0.929   Median :-0.938  
##  Mean   :-0.650   Mean   :-0.622   Mean   :-0.750   Mean   :-0.644  
##  3rd Qu.:-0.329   3rd Qu.:-0.278   3rd Qu.:-0.524   3rd Qu.:-0.315  
##  Max.   : 0.455   Max.   : 1.000   Max.   : 0.136   Max.   : 0.450  
##       V349             V350              V351             V352       
##  Min.   :-0.998   Min.   :-0.9993   Min.   :-0.999   Min.   :-0.998  
##  1st Qu.:-0.984   1st Qu.:-0.9887   1st Qu.:-0.988   1st Qu.:-0.984  
##  Median :-0.903   Median :-0.9438   Median :-0.921   Median :-0.903  
##  Mean   :-0.607   Mean   :-0.7864   Mean   :-0.583   Mean   :-0.616  
##  3rd Qu.:-0.243   3rd Qu.:-0.5971   3rd Qu.:-0.202   3rd Qu.:-0.266  
##  Max.   : 0.952   Max.   : 0.0732   Max.   : 0.697   Max.   : 1.000  
##       V353             V354             V355             V356        
##  Min.   :-0.999   Min.   :-1.000   Min.   :-0.997   Min.   :-0.9989  
##  1st Qu.:-0.988   1st Qu.:-0.993   1st Qu.:-0.987   1st Qu.:-0.9889  
##  Median :-0.937   Median :-0.952   Median :-0.921   Median :-0.9503  
##  Mean   :-0.769   Mean   :-0.704   Mean   :-0.685   Mean   :-0.8086  
##  3rd Qu.:-0.564   3rd Qu.:-0.440   3rd Qu.:-0.400   3rd Qu.:-0.6457  
##  Max.   : 0.197   Max.   : 0.375   Max.   : 0.705   Max.   : 0.0311  
##       V357             V358             V359             V360       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-0.999  
##  1st Qu.:-0.995   1st Qu.:-0.990   1st Qu.:-0.988   1st Qu.:-0.987  
##  Median :-0.978   Median :-0.968   Median :-0.967   Median :-0.914  
##  Mean   :-0.885   Mean   :-0.857   Mean   :-0.888   Mean   :-0.617  
##  3rd Qu.:-0.825   3rd Qu.:-0.788   3rd Qu.:-0.851   3rd Qu.:-0.256  
##  Max.   : 0.414   Max.   : 0.812   Max.   : 0.236   Max.   : 0.608  
##       V361              V362             V363             V364       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.9999   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.988  
##  Median :-0.9972   Median :-0.994   Median :-0.997   Median :-0.924  
##  Mean   :-0.8499   Mean   :-0.826   Mean   :-0.939   Mean   :-0.627  
##  3rd Qu.:-0.7490   3rd Qu.:-0.703   3rd Qu.:-0.897   3rd Qu.:-0.303  
##  Max.   : 0.0325   Max.   : 1.000   Max.   :-0.385   Max.   : 0.751  
##       V365             V366             V367             V368       
##  Min.   :-0.998   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.986   1st Qu.:-0.985   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.922   Median :-0.935   Median :-0.557   Median :-0.513  
##  Mean   :-0.713   Mean   :-0.777   Mean   :-0.238   Mean   :-0.244  
##  3rd Qu.:-0.461   3rd Qu.:-0.597   3rd Qu.: 0.514   3rd Qu.: 0.502  
##  Max.   : 1.000   Max.   : 0.143   Max.   : 0.958   Max.   : 1.000  
##       V369             V370             V371             V372      
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.00  
##  1st Qu.:-1.000   1st Qu.:-0.600   1st Qu.:-0.560   1st Qu.:-0.48  
##  Median :-0.573   Median :-0.360   Median :-0.400   Median :-0.28  
##  Mean   :-0.352   Mean   :-0.394   Mean   :-0.392   Mean   :-0.31  
##  3rd Qu.: 0.281   3rd Qu.:-0.160   3rd Qu.:-0.240   3rd Qu.:-0.12  
##  Max.   : 0.825   Max.   : 1.000   Max.   : 0.960   Max.   : 1.00  
##       V373              V374              V375              V376       
##  Min.   :-0.8166   Min.   :-0.9791   Min.   :-0.9612   Min.   :-0.926  
##  1st Qu.:-0.3024   1st Qu.:-0.4200   1st Qu.:-0.3342   1st Qu.:-0.491  
##  Median :-0.0454   Median :-0.2379   Median :-0.1188   Median :-0.337  
##  Mean   :-0.0507   Mean   :-0.2178   Mean   :-0.1269   Mean   :-0.302  
##  3rd Qu.: 0.2052   3rd Qu.:-0.0167   3rd Qu.: 0.0799   3rd Qu.:-0.149  
##  Max.   : 0.8679   Max.   : 0.6803   Max.   : 1.0000   Max.   : 1.000  
##       V377             V378             V379             V380       
##  Min.   :-0.983   Min.   :-0.847   Min.   :-0.996   Min.   :-0.929  
##  1st Qu.:-0.850   1st Qu.:-0.538   1st Qu.:-0.915   1st Qu.:-0.626  
##  Median :-0.767   Median :-0.431   Median :-0.863   Median :-0.517  
##  Mean   :-0.707   Mean   :-0.409   Mean   :-0.832   Mean   :-0.490  
##  3rd Qu.:-0.626   3rd Qu.:-0.307   3rd Qu.:-0.788   3rd Qu.:-0.386  
##  Max.   : 1.000   Max.   : 0.860   Max.   : 0.736   Max.   : 0.515  
##       V381             V382             V383             V384       
##  Min.   :-0.996   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.913   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.857   Median :-0.999   Median :-0.998   Median :-0.997  
##  Mean   :-0.822   Mean   :-0.882   Mean   :-0.880   Mean   :-0.872  
##  3rd Qu.:-0.775   3rd Qu.:-0.822   3rd Qu.:-0.814   3rd Qu.:-0.806  
##  Max.   : 0.255   Max.   : 0.221   Max.   :-0.107   Max.   : 0.474  
##       V385             V386             V387             V388        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.9999  
##  Median :-0.997   Median :-0.998   Median :-0.998   Median :-0.9986  
##  Mean   :-0.890   Mean   :-0.924   Mean   :-0.907   Mean   :-0.9475  
##  3rd Qu.:-0.861   3rd Qu.:-0.892   3rd Qu.:-0.862   3rd Qu.:-0.9269  
##  Max.   : 0.949   Max.   : 0.158   Max.   : 0.552   Max.   :-0.0735  
##       V389             V390             V391             V392       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-1.000   Median :-0.999   Median :-0.996   Median :-0.998  
##  Mean   :-0.986   Mean   :-0.870   Mean   :-0.850   Mean   :-0.911  
##  3rd Qu.:-0.991   3rd Qu.:-0.784   3rd Qu.:-0.775   3rd Qu.:-0.867  
##  Max.   :-0.471   Max.   :-0.105   Max.   : 0.545   Max.   : 0.170  
##       V393              V394             V395             V396       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.9999   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.9986   Median :-0.998   Median :-0.996   Median :-0.992  
##  Mean   :-0.9457   Mean   :-0.847   Mean   :-0.859   Mean   :-0.826  
##  3rd Qu.:-0.9236   3rd Qu.:-0.742   3rd Qu.:-0.796   3rd Qu.:-0.741  
##  Max.   :-0.0464   Max.   : 0.125   Max.   : 0.687   Max.   : 1.000  
##       V397             V398             V399             V400       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.996   Median :-0.995   Median :-0.996   Median :-0.996  
##  Mean   :-0.873   Mean   :-0.831   Mean   :-0.900   Mean   :-0.917  
##  3rd Qu.:-0.800   3rd Qu.:-0.738   3rd Qu.:-0.852   3rd Qu.:-0.881  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##       V401             V402              V403             V404       
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-0.9997   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.995   Median :-0.9962   Median :-0.999   Median :-0.995  
##  Mean   :-0.880   Mean   :-0.9260   Mean   :-0.972   Mean   :-0.844  
##  3rd Qu.:-0.817   3rd Qu.:-0.8891   3rd Qu.:-0.983   3rd Qu.:-0.753  
##  Max.   : 0.670   Max.   : 0.0589   Max.   : 0.524   Max.   : 1.000  
##       V405             V406             V407              V408       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.9997   1st Qu.:-1.000  
##  Median :-0.995   Median :-0.995   Median :-0.9965   Median :-0.994  
##  Mean   :-0.830   Mean   :-0.881   Mean   :-0.9319   Mean   :-0.812  
##  3rd Qu.:-0.727   3rd Qu.:-0.817   3rd Qu.:-0.8976   3rd Qu.:-0.681  
##  Max.   : 1.000   Max.   : 0.930   Max.   :-0.0747   Max.   : 1.000  
##       V409             V410              V411             V412       
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-0.9998   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.996   Median :-0.9958   Median :-0.996   Median :-0.998  
##  Mean   :-0.891   Mean   :-0.9102   Mean   :-0.907   Mean   :-0.940  
##  3rd Qu.:-0.830   3rd Qu.:-0.8578   3rd Qu.:-0.873   3rd Qu.:-0.911  
##  Max.   : 1.000   Max.   :-0.0301   Max.   : 0.115   Max.   :-0.111  
##       V413             V414             V415             V416        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.9994  
##  Median :-0.998   Median :-0.998   Median :-0.997   Median :-0.9961  
##  Mean   :-0.969   Mean   :-0.973   Mean   :-0.952   Mean   :-0.9407  
##  3rd Qu.:-0.957   3rd Qu.:-0.962   3rd Qu.:-0.928   3rd Qu.:-0.9195  
##  Max.   :-0.334   Max.   :-0.512   Max.   :-0.127   Max.   :-0.0369  
##       V417             V418             V419             V420       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.999   Median :-0.995   Median :-0.998   Median :-0.998  
##  Mean   :-0.976   Mean   :-0.888   Mean   :-0.954   Mean   :-0.965  
##  3rd Qu.:-0.987   3rd Qu.:-0.832   3rd Qu.:-0.931   3rd Qu.:-0.947  
##  Max.   :-0.102   Max.   : 0.159   Max.   :-0.433   Max.   :-0.435  
##       V421              V422              V423             V424       
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000   Min.   :-0.999  
##  1st Qu.:-0.9994   1st Qu.:-0.9997   1st Qu.:-1.000   1st Qu.:-0.983  
##  Median :-0.9961   Median :-0.9959   Median :-0.998   Median :-0.842  
##  Mean   :-0.9410   Mean   :-0.9094   Mean   :-0.967   Mean   :-0.670  
##  3rd Qu.:-0.9196   3rd Qu.:-0.8515   3rd Qu.:-0.952   3rd Qu.:-0.381  
##  Max.   :-0.0718   Max.   : 0.0529   Max.   :-0.426   Max.   : 0.462  
##       V425             V426             V427             V428       
##  Min.   :-0.999   Min.   :-1.000   Min.   :-1.000   Min.   :-0.999  
##  1st Qu.:-0.982   1st Qu.:-0.981   1st Qu.:-0.986   1st Qu.:-0.976  
##  Median :-0.896   Median :-0.867   Median :-0.867   Median :-0.886  
##  Mean   :-0.717   Mean   :-0.640   Mean   :-0.740   Mean   :-0.694  
##  3rd Qu.:-0.495   3rd Qu.:-0.338   3rd Qu.:-0.534   3rd Qu.:-0.465  
##  Max.   : 0.405   Max.   : 0.681   Max.   : 0.472   Max.   : 0.545  
##       V429             V430             V431             V432       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-0.999   Min.   :-1.000  
##  1st Qu.:-0.982   1st Qu.:-0.983   1st Qu.:-0.981   1st Qu.:-0.980  
##  Median :-0.869   Median :-0.845   Median :-0.895   Median :-0.867  
##  Mean   :-0.689   Mean   :-0.690   Mean   :-0.726   Mean   :-0.639  
##  3rd Qu.:-0.429   3rd Qu.:-0.424   3rd Qu.:-0.519   3rd Qu.:-0.333  
##  Max.   : 0.417   Max.   : 0.555   Max.   : 0.369   Max.   : 0.627  
##       V433             V434             V435             V436       
##  Min.   :-1.000   Min.   :-0.999   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.986   1st Qu.:-0.980   1st Qu.:-0.985   1st Qu.:-0.997  
##  Median :-0.881   Median :-0.906   Median :-0.897   Median :-0.980  
##  Mean   :-0.738   Mean   :-0.754   Mean   :-0.763   Mean   :-0.930  
##  3rd Qu.:-0.555   3rd Qu.:-0.600   3rd Qu.:-0.588   3rd Qu.:-0.905  
##  Max.   : 0.721   Max.   : 0.596   Max.   : 0.410   Max.   : 1.000  
##       V437             V438             V439             V440       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-0.999   Min.   :-1.000  
##  1st Qu.:-0.994   1st Qu.:-0.994   1st Qu.:-0.980   1st Qu.:-1.000  
##  Median :-0.974   Median :-0.970   Median :-0.875   Median :-0.990  
##  Mean   :-0.906   Mean   :-0.911   Mean   :-0.663   Mean   :-0.920  
##  3rd Qu.:-0.869   3rd Qu.:-0.870   3rd Qu.:-0.381   3rd Qu.:-0.872  
##  Max.   : 1.000   Max.   : 0.444   Max.   : 0.281   Max.   : 0.103  
##       V441              V442              V443             V444       
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000   Min.   :-0.999  
##  1st Qu.:-0.9997   1st Qu.:-0.9997   1st Qu.:-0.987   1st Qu.:-0.987  
##  Median :-0.9934   Median :-0.9899   Median :-0.887   Median :-0.918  
##  Mean   :-0.9040   Mean   :-0.8732   Mean   :-0.702   Mean   :-0.759  
##  3rd Qu.:-0.8613   3rd Qu.:-0.7880   3rd Qu.:-0.436   3rd Qu.:-0.563  
##  Max.   : 0.0478   Max.   : 0.0525   Max.   : 0.484   Max.   : 0.418  
##       V445             V446              V447              V448       
##  Min.   :-0.999   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.987   1st Qu.:-0.6631   1st Qu.:-0.5866   1st Qu.:-0.707  
##  Median :-0.917   Median :-0.0425   Median :-0.0364   Median :-0.190  
##  Mean   :-0.691   Mean   :-0.0568   Mean   :-0.0159   Mean   :-0.117  
##  3rd Qu.:-0.437   3rd Qu.: 0.5242   3rd Qu.: 0.5702   3rd Qu.: 0.455  
##  Max.   : 0.832   Max.   : 0.8988   Max.   : 0.9078   Max.   : 0.888  
##       V449             V450             V451             V452        
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-0.9135  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.2676  
##  Median :-0.933   Median :-0.935   Median :-0.931   Median :-0.0983  
##  Mean   :-0.890   Mean   :-0.777   Mean   :-0.814   Mean   :-0.1006  
##  3rd Qu.:-0.867   3rd Qu.:-0.613   3rd Qu.:-0.724   3rd Qu.: 0.0635  
##  Max.   : 0.533   Max.   : 1.000   Max.   : 1.000   Max.   : 0.7839  
##       V453              V454              V455              V456       
##  Min.   :-0.9764   Min.   :-1.0000   Min.   :-0.9410   Min.   :-0.979  
##  1st Qu.:-0.3498   1st Qu.:-0.2432   1st Qu.:-0.4210   1st Qu.:-0.753  
##  Median :-0.1662   Median :-0.0629   Median :-0.2264   Median :-0.591  
##  Mean   :-0.1671   Mean   :-0.0587   Mean   :-0.1819   Mean   :-0.501  
##  3rd Qu.: 0.0192   3rd Qu.: 0.1158   3rd Qu.: 0.0219   3rd Qu.:-0.321  
##  Max.   : 1.0000   Max.   : 0.9368   Max.   : 1.0000   Max.   : 1.000  
##       V457              V458             V459              V460       
##  Min.   :-0.8575   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.4579   1st Qu.:-0.826   1st Qu.:-0.4447   1st Qu.:-0.782  
##  Median :-0.2641   Median :-0.677   Median :-0.2670   Median :-0.635  
##  Mean   :-0.1926   Mean   :-0.545   Mean   :-0.2060   Mean   :-0.526  
##  3rd Qu.: 0.0197   3rd Qu.:-0.367   3rd Qu.:-0.0029   3rd Qu.:-0.352  
##  Max.   : 1.0000   Max.   : 1.000   Max.   : 1.0000   Max.   : 1.000  
##       V461             V462             V463              V464       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.9999   1st Qu.:-1.000  
##  Median :-0.992   Median :-0.995   Median :-0.9960   Median :-0.997  
##  Mean   :-0.931   Mean   :-0.923   Mean   :-0.9258   Mean   :-0.957  
##  3rd Qu.:-0.895   3rd Qu.:-0.873   3rd Qu.:-0.8862   3rd Qu.:-0.939  
##  Max.   : 0.103   Max.   :-0.184   Max.   :-0.0021   Max.   :-0.222  
##       V465             V466              V467             V468       
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-0.9999   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.997   Median :-0.9965   Median :-0.997   Median :-0.999  
##  Mean   :-0.950   Mean   :-0.9536   Mean   :-0.965   Mean   :-0.975  
##  3rd Qu.:-0.934   3rd Qu.:-0.9329   3rd Qu.:-0.957   3rd Qu.:-0.981  
##  Max.   : 0.544   Max.   :-0.0876   Max.   : 0.197   Max.   : 0.316  
##       V469             V470              V471             V472       
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-0.9999   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.990   Median :-0.9958   Median :-0.996   Median :-0.997  
##  Mean   :-0.924   Mean   :-0.9229   Mean   :-0.946   Mean   :-0.970  
##  3rd Qu.:-0.881   3rd Qu.:-0.8759   3rd Qu.:-0.925   3rd Qu.:-0.967  
##  Max.   : 0.100   Max.   :-0.0581   Max.   : 0.238   Max.   : 0.249  
##       V473             V474              V475             V476        
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.:-1.000   1st Qu.:-0.9999   1st Qu.:-1.000   1st Qu.:-1.0000  
##  Median :-0.990   Median :-0.9971   Median :-0.992   Median :-0.9983  
##  Mean   :-0.921   Mean   :-0.9538   Mean   :-0.900   Mean   :-0.9625  
##  3rd Qu.:-0.876   3rd Qu.:-0.9286   3rd Qu.:-0.861   3rd Qu.:-0.9534  
##  Max.   : 0.103   Max.   :-0.0803   Max.   : 0.157   Max.   :-0.0605  
##       V477             V478             V479             V480       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.999   Median :-0.999   Median :-0.999   Median :-0.998  
##  Mean   :-0.967   Mean   :-0.971   Mean   :-0.980   Mean   :-0.963  
##  3rd Qu.:-0.967   3rd Qu.:-0.966   3rd Qu.:-0.976   3rd Qu.:-0.954  
##  Max.   :-0.249   Max.   :-0.494   Max.   :-0.422   Max.   :-0.283  
##       V481             V482             V483              V484       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-0.9997   1st Qu.:-1.000  
##  Median :-0.997   Median :-1.000   Median :-0.9931   Median :-0.999  
##  Mean   :-0.959   Mean   :-0.979   Mean   :-0.9082   Mean   :-0.960  
##  3rd Qu.:-0.951   3rd Qu.:-0.987   3rd Qu.:-0.8679   3rd Qu.:-0.953  
##  Max.   : 0.265   Max.   : 0.402   Max.   :-0.0998   Max.   :-0.223  
##       V485             V486             V487             V488       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.999   Median :-0.997   Median :-0.993   Median :-0.999  
##  Mean   :-0.977   Mean   :-0.962   Mean   :-0.899   Mean   :-0.971  
##  3rd Qu.:-0.971   3rd Qu.:-0.957   3rd Qu.:-0.854   3rd Qu.:-0.963  
##  Max.   :-0.462   Max.   : 0.497   Max.   : 0.128   Max.   :-0.453  
##       V489              V490             V491             V492       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.9998   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.9909   Median :-0.997   Median :-0.998   Median :-0.999  
##  Mean   :-0.9017   Mean   :-0.935   Mean   :-0.937   Mean   :-0.962  
##  3rd Qu.:-0.8443   3rd Qu.:-0.919   3rd Qu.:-0.913   3rd Qu.:-0.954  
##  Max.   : 0.0453   Max.   : 0.239   Max.   : 0.110   Max.   : 0.116  
##       V493             V494              V495             V496       
##  Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-1.000   1st Qu.:-0.9999   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.998   Median :-0.9967   Median :-0.994   Median :-0.999  
##  Mean   :-0.970   Mean   :-0.9601   Mean   :-0.951   Mean   :-0.971  
##  3rd Qu.:-0.965   3rd Qu.:-0.9476   3rd Qu.:-0.944   3rd Qu.:-0.982  
##  Max.   : 0.258   Max.   : 0.0961   Max.   : 0.641   Max.   : 0.507  
##       V497              V498             V499             V500       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.9997   1st Qu.:-1.000   1st Qu.:-1.000   1st Qu.:-1.000  
##  Median :-0.9901   Median :-0.997   Median :-0.998   Median :-0.995  
##  Mean   :-0.8848   Mean   :-0.922   Mean   :-0.967   Mean   :-0.960  
##  3rd Qu.:-0.8116   3rd Qu.:-0.888   3rd Qu.:-0.960   3rd Qu.:-0.958  
##  Max.   : 0.0269   Max.   : 0.376   Max.   : 0.186   Max.   : 0.341  
##       V501              V502             V503             V504       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.9997   1st Qu.:-1.000   1st Qu.:-0.982   1st Qu.:-0.980  
##  Median :-0.9901   Median :-0.998   Median :-0.840   Median :-0.828  
##  Mean   :-0.8769   Mean   :-0.964   Mean   :-0.587   Mean   :-0.667  
##  3rd Qu.:-0.7954   3rd Qu.:-0.953   3rd Qu.:-0.245   3rd Qu.:-0.392  
##  Max.   : 0.0423   Max.   : 0.137   Max.   : 0.562   Max.   : 0.311  
##       V505             V506             V507             V508       
##  Min.   :-0.999   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.979   1st Qu.:-0.984   1st Qu.:-0.991   1st Qu.:-0.982  
##  Median :-0.832   Median :-0.852   Median :-0.965   Median :-0.840  
##  Mean   :-0.601   Mean   :-0.765   Mean   :-0.890   Mean   :-0.587  
##  3rd Qu.:-0.266   3rd Qu.:-0.585   3rd Qu.:-0.838   3rd Qu.:-0.245  
##  Max.   : 0.606   Max.   : 0.132   Max.   : 0.390   Max.   : 0.562  
##       V509              V510             V511             V512       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.9996   1st Qu.:-0.986   1st Qu.:-0.854   1st Qu.:-1.000  
##  Median :-0.9802   Median :-0.905   Median :-0.265   Median :-0.793  
##  Mean   :-0.8329   Mean   :-0.695   Mean   :-0.171   Mean   :-0.756  
##  3rd Qu.:-0.7245   3rd Qu.:-0.447   3rd Qu.: 0.477   3rd Qu.:-0.517  
##  Max.   : 0.0588   Max.   : 0.529   Max.   : 0.918   Max.   : 0.793  
##       V513              V514             V515             V516       
##  Min.   :-0.9410   Min.   :-0.966   Min.   :-0.987   Min.   :-1.000  
##  1st Qu.:-0.0904   1st Qu.:-0.577   1st Qu.:-0.843   1st Qu.:-0.988  
##  Median : 0.0754   Median :-0.428   Median :-0.740   Median :-0.898  
##  Mean   : 0.0862   Mean   :-0.365   Mean   :-0.646   Mean   :-0.612  
##  3rd Qu.: 0.2530   3rd Qu.:-0.221   3rd Qu.:-0.557   3rd Qu.:-0.263  
##  Max.   : 0.9169   Max.   : 0.974   Max.   : 0.966   Max.   : 0.838  
##       V517             V518             V519             V520       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-0.999   Min.   :-1.000  
##  1st Qu.:-0.989   1st Qu.:-0.987   1st Qu.:-0.992   1st Qu.:-0.986  
##  Median :-0.894   Median :-0.889   Median :-0.905   Median :-0.949  
##  Mean   :-0.623   Mean   :-0.603   Mean   :-0.661   Mean   :-0.796  
##  3rd Qu.:-0.291   3rd Qu.:-0.255   3rd Qu.:-0.364   3rd Qu.:-0.666  
##  Max.   : 0.888   Max.   : 0.944   Max.   : 0.689   Max.   : 0.686  
##       V521             V522             V523             V524       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.988   1st Qu.:-1.000   1st Qu.:-0.987   1st Qu.:-1.000  
##  Median :-0.898   Median :-0.994   Median :-0.918   Median :-0.517  
##  Mean   :-0.612   Mean   :-0.838   Mean   :-0.672   Mean   :-0.316  
##  3rd Qu.:-0.263   3rd Qu.:-0.728   3rd Qu.:-0.371   3rd Qu.: 0.338  
##  Max.   : 0.838   Max.   : 0.744   Max.   : 0.440   Max.   : 0.847  
##       V525             V526              V527              V528       
##  Min.   :-1.000   Min.   :-0.7581   Min.   :-0.9986   Min.   :-0.998  
##  1st Qu.:-0.968   1st Qu.:-0.0153   1st Qu.:-0.5851   1st Qu.:-0.872  
##  Median :-0.905   Median : 0.1495   Median :-0.2928   Median :-0.670  
##  Mean   :-0.877   Mean   : 0.1608   Mean   :-0.2627   Mean   :-0.567  
##  3rd Qu.:-0.873   3rd Qu.: 0.3418   3rd Qu.:-0.0109   3rd Qu.:-0.369  
##  Max.   : 0.714   Max.   : 1.0000   Max.   : 0.9712   Max.   : 0.949  
##       V529             V530             V531             V532       
##  Min.   :-0.999   Min.   :-0.999   Min.   :-0.999   Min.   :-0.999  
##  1st Qu.:-0.978   1st Qu.:-0.974   1st Qu.:-0.974   1st Qu.:-0.976  
##  Median :-0.841   Median :-0.793   Median :-0.799   Median :-0.814  
##  Mean   :-0.708   Mean   :-0.718   Mean   :-0.696   Mean   :-0.754  
##  3rd Qu.:-0.482   3rd Qu.:-0.514   3rd Qu.:-0.467   3rd Qu.:-0.593  
##  Max.   : 0.197   Max.   : 0.977   Max.   : 0.490   Max.   : 1.000  
##       V533              V534             V535             V536       
##  Min.   :-1.0000   Min.   :-0.999   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.9930   1st Qu.:-0.978   1st Qu.:-1.000   1st Qu.:-0.982  
##  Median :-0.9563   Median :-0.841   Median :-0.976   Median :-0.875  
##  Mean   :-0.8977   Mean   :-0.708   Mean   :-0.899   Mean   :-0.728  
##  3rd Qu.:-0.8456   3rd Qu.:-0.482   3rd Qu.:-0.842   3rd Qu.:-0.521  
##  Max.   : 0.0234   Max.   : 0.197   Max.   : 0.735   Max.   : 0.334  
##       V537              V538             V539              V540       
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.0000   Min.   :-0.889  
##  1st Qu.:-0.6172   1st Qu.:-1.000   1st Qu.:-0.2211   1st Qu.:-0.515  
##  Median :-0.0541   Median :-0.949   Median :-0.0293   Median :-0.342  
##  Mean   :-0.0473   Mean   :-0.881   Mean   :-0.0292   Mean   :-0.291  
##  3rd Qu.: 0.5111   3rd Qu.:-0.846   3rd Qu.: 0.1599   3rd Qu.:-0.122  
##  Max.   : 0.8773   Max.   : 0.128   Max.   : 0.9778   Max.   : 1.000  
##       V541             V542             V543             V544       
##  Min.   :-0.995   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.817   1st Qu.:-0.989   1st Qu.:-0.990   1st Qu.:-0.989  
##  Median :-0.688   Median :-0.916   Median :-0.912   Median :-0.907  
##  Mean   :-0.602   Mean   :-0.781   Mean   :-0.792   Mean   :-0.775  
##  3rd Qu.:-0.474   3rd Qu.:-0.614   3rd Qu.:-0.646   3rd Qu.:-0.615  
##  Max.   : 1.000   Max.   : 0.234   Max.   : 0.286   Max.   : 0.389  
##       V545             V546             V547             V548       
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.992   1st Qu.:-0.992   1st Qu.:-0.989   1st Qu.:-1.000  
##  Median :-0.920   Median :-0.963   Median :-0.916   Median :-0.996  
##  Mean   :-0.806   Mean   :-0.869   Mean   :-0.781   Mean   :-0.943  
##  3rd Qu.:-0.672   3rd Qu.:-0.798   3rd Qu.:-0.614   3rd Qu.:-0.924  
##  Max.   : 0.380   Max.   : 0.557   Max.   : 0.234   Max.   :-0.278  
##       V549             V550             V551             V552        
##  Min.   :-0.999   Min.   :-1.000   Min.   :-1.000   Min.   :-0.7855  
##  1st Qu.:-0.989   1st Qu.:-0.896   1st Qu.:-0.968   1st Qu.:-0.0084  
##  Median :-0.913   Median :-0.290   Median :-0.905   Median : 0.1427  
##  Mean   :-0.776   Mean   :-0.249   Mean   :-0.903   Mean   : 0.1302  
##  3rd Qu.:-0.606   3rd Qu.: 0.339   3rd Qu.:-0.873   3rd Qu.: 0.2883  
##  Max.   : 0.387   Max.   : 0.838   Max.   : 1.000   Max.   : 1.0000  
##       V553              V554             V555              V556        
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.0000   Min.   :-0.9934  
##  1st Qu.:-0.5175   1st Qu.:-0.830   1st Qu.:-0.1305   1st Qu.:-0.2826  
##  Median :-0.3110   Median :-0.684   Median : 0.0052   Median : 0.0068  
##  Mean   :-0.2776   Mean   :-0.599   Mean   : 0.0053   Mean   : 0.0038  
##  3rd Qu.:-0.0836   3rd Qu.:-0.458   3rd Qu.: 0.1462   3rd Qu.: 0.2881  
##  Max.   : 1.0000   Max.   : 1.000   Max.   : 0.9989   Max.   : 0.9863  
##       V557              V558              V559             V560        
##  Min.   :-0.9989   Min.   :-0.9911   Min.   :-0.984   Min.   :-0.9137  
##  1st Qu.:-0.5189   1st Qu.:-0.4284   1st Qu.:-0.830   1st Qu.: 0.0221  
##  Median : 0.0471   Median :-0.0267   Median :-0.730   Median : 0.1816  
##  Mean   : 0.0400   Mean   :-0.0173   Mean   :-0.514   Mean   : 0.0749  
##  3rd Qu.: 0.6222   3rd Qu.: 0.3944   3rd Qu.:-0.546   3rd Qu.: 0.2603  
##  Max.   : 1.0000   Max.   : 1.0000   Max.   : 0.833   Max.   : 1.0000  
##       V561        
##  Min.   :-0.9492  
##  1st Qu.:-0.0985  
##  Median :-0.0107  
##  Mean   :-0.0487  
##  3rd Qu.: 0.0924  
##  Max.   : 0.9731
```

#### testLabel:

```r
summary(testLabel)
```

```
##        V1      
##  Min.   :1.00  
##  1st Qu.:2.00  
##  Median :4.00  
##  Mean   :3.58  
##  3rd Qu.:5.00  
##  Max.   :6.00
```


#### trainSubject:

```r
summary(testSubject)
```

```
##        V1    
##  Min.   : 2  
##  1st Qu.: 9  
##  Median :12  
##  Mean   :13  
##  3rd Qu.:18  
##  Max.   :24
```


Merge the training and the test sets
------------------------------------

Concatenate the data tables.


```r
joinData <- rbind(trainData, testData)
joinLabel <- rbind(trainLabel, testLabel)
joinSubject <- rbind(trainSubject, testSubject)
```




Extract only the mean and standard deviation
--------------------------------------------




```r
features <- read.table("./data/features.txt")
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices)
```

```
## [1] 66
```

```r
joinData <- joinData[, meanStdIndices]
dim(joinData)
```

```
## [1] 10299    66
```

```r
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2])
names(joinData) <- gsub("mean", "Mean", names(joinData))
names(joinData) <- gsub("std", "Std", names(joinData))
names(joinData) <- gsub("-", "", names(joinData))
```

Read activity_labels.txt file


```r
activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"
```



Subset only measurements for the mean and standard deviation.

```r
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanedData)
```

```
## [1] 10299    68
```


Merged Data With Descriptive Activity dataset data structure

```r
summary(cleanedData)
```

```
##     subject       activity         tBodyAccMeanX    tBodyAccMeanY    
##  Min.   : 1.0   Length:10299       Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.: 9.0   Class :character   1st Qu.: 0.263   1st Qu.:-0.0249  
##  Median :17.0   Mode  :character   Median : 0.277   Median :-0.0172  
##  Mean   :16.1                      Mean   : 0.274   Mean   :-0.0177  
##  3rd Qu.:24.0                      3rd Qu.: 0.288   3rd Qu.:-0.0106  
##  Max.   :30.0                      Max.   : 1.000   Max.   : 1.0000  
##  tBodyAccMeanZ      tBodyAccStdX     tBodyAccStdY      tBodyAccStdZ   
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.1210   1st Qu.:-0.992   1st Qu.:-0.9770   1st Qu.:-0.979  
##  Median :-0.1086   Median :-0.943   Median :-0.8350   Median :-0.851  
##  Mean   :-0.1089   Mean   :-0.608   Mean   :-0.5102   Mean   :-0.613  
##  3rd Qu.:-0.0976   3rd Qu.:-0.250   3rd Qu.:-0.0573   3rd Qu.:-0.279  
##  Max.   : 1.0000   Max.   : 1.000   Max.   : 1.0000   Max.   : 1.000  
##  tGravityAccMeanX tGravityAccMeanY tGravityAccMeanZ  tGravityAccStdX 
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.: 0.812   1st Qu.:-0.243   1st Qu.:-0.1167   1st Qu.:-0.995  
##  Median : 0.922   Median :-0.144   Median : 0.0368   Median :-0.982  
##  Mean   : 0.669   Mean   : 0.004   Mean   : 0.0922   Mean   :-0.965  
##  3rd Qu.: 0.955   3rd Qu.: 0.119   3rd Qu.: 0.2162   3rd Qu.:-0.962  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.0000   Max.   : 1.000  
##  tGravityAccStdY  tGravityAccStdZ  tBodyAccJerkMeanX tBodyAccJerkMeanY
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.991   1st Qu.:-0.987   1st Qu.: 0.0630   1st Qu.:-0.0186  
##  Median :-0.976   Median :-0.967   Median : 0.0760   Median : 0.0108  
##  Mean   :-0.954   Mean   :-0.939   Mean   : 0.0789   Mean   : 0.0079  
##  3rd Qu.:-0.946   3rd Qu.:-0.930   3rd Qu.: 0.0913   3rd Qu.: 0.0335  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.0000   Max.   : 1.0000  
##  tBodyAccJerkMeanZ tBodyAccJerkStdX tBodyAccJerkStdY tBodyAccJerkStdZ
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.0316   1st Qu.:-0.991   1st Qu.:-0.985   1st Qu.:-0.989  
##  Median :-0.0012   Median :-0.951   Median :-0.925   Median :-0.954  
##  Mean   :-0.0047   Mean   :-0.640   Mean   :-0.608   Mean   :-0.763  
##  3rd Qu.: 0.0246   3rd Qu.:-0.291   3rd Qu.:-0.222   3rd Qu.:-0.548  
##  Max.   : 1.0000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##  tBodyGyroMeanX    tBodyGyroMeanY    tBodyGyroMeanZ    tBodyGyroStdX   
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000  
##  1st Qu.:-0.0458   1st Qu.:-0.1040   1st Qu.: 0.0648   1st Qu.:-0.987  
##  Median :-0.0278   Median :-0.0748   Median : 0.0863   Median :-0.902  
##  Mean   :-0.0310   Mean   :-0.0747   Mean   : 0.0884   Mean   :-0.721  
##  3rd Qu.:-0.0106   3rd Qu.:-0.0511   3rd Qu.: 0.1104   3rd Qu.:-0.482  
##  Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.000  
##  tBodyGyroStdY    tBodyGyroStdZ    tBodyGyroJerkMeanX tBodyGyroJerkMeanY
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000    Min.   :-1.0000   
##  1st Qu.:-0.982   1st Qu.:-0.985   1st Qu.:-0.1172    1st Qu.:-0.0587   
##  Median :-0.911   Median :-0.882   Median :-0.0982    Median :-0.0406   
##  Mean   :-0.683   Mean   :-0.654   Mean   :-0.0967    Mean   :-0.0423   
##  3rd Qu.:-0.446   3rd Qu.:-0.338   3rd Qu.:-0.0793    3rd Qu.:-0.0252   
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.0000    Max.   : 1.0000   
##  tBodyGyroJerkMeanZ tBodyGyroJerkStdX tBodyGyroJerkStdY tBodyGyroJerkStdZ
##  Min.   :-1.0000    Min.   :-1.000    Min.   :-1.000    Min.   :-1.000   
##  1st Qu.:-0.0794    1st Qu.:-0.991    1st Qu.:-0.992    1st Qu.:-0.993   
##  Median :-0.0546    Median :-0.935    Median :-0.955    Median :-0.950   
##  Mean   :-0.0548    Mean   :-0.731    Mean   :-0.786    Mean   :-0.740   
##  3rd Qu.:-0.0317    3rd Qu.:-0.486    3rd Qu.:-0.627    3rd Qu.:-0.510   
##  Max.   : 1.0000    Max.   : 1.000    Max.   : 1.000    Max.   : 1.000   
##  tBodyAccMagMean  tBodyAccMagStd   tGravityAccMagMean tGravityAccMagStd
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000     Min.   :-1.000   
##  1st Qu.:-0.982   1st Qu.:-0.982   1st Qu.:-0.982     1st Qu.:-0.982   
##  Median :-0.875   Median :-0.844   Median :-0.875     Median :-0.844   
##  Mean   :-0.548   Mean   :-0.591   Mean   :-0.548     Mean   :-0.591   
##  3rd Qu.:-0.120   3rd Qu.:-0.242   3rd Qu.:-0.120     3rd Qu.:-0.242   
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000     Max.   : 1.000   
##  tBodyAccJerkMagMean tBodyAccJerkMagStd tBodyGyroMagMean tBodyGyroMagStd 
##  Min.   :-1.000      Min.   :-1.000     Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.990      1st Qu.:-0.991     1st Qu.:-0.978   1st Qu.:-0.978  
##  Median :-0.948      Median :-0.929     Median :-0.822   Median :-0.826  
##  Mean   :-0.649      Mean   :-0.628     Mean   :-0.605   Mean   :-0.662  
##  3rd Qu.:-0.296      3rd Qu.:-0.273     3rd Qu.:-0.245   3rd Qu.:-0.394  
##  Max.   : 1.000      Max.   : 1.000     Max.   : 1.000   Max.   : 1.000  
##  tBodyGyroJerkMagMean tBodyGyroJerkMagStd fBodyAccMeanX   
##  Min.   :-1.000       Min.   :-1.000      Min.   :-1.000  
##  1st Qu.:-0.992       1st Qu.:-0.992      1st Qu.:-0.991  
##  Median :-0.956       Median :-0.940      Median :-0.946  
##  Mean   :-0.762       Mean   :-0.778      Mean   :-0.623  
##  3rd Qu.:-0.550       3rd Qu.:-0.609      3rd Qu.:-0.265  
##  Max.   : 1.000       Max.   : 1.000      Max.   : 1.000  
##  fBodyAccMeanY    fBodyAccMeanZ     fBodyAccStdX     fBodyAccStdY    
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.:-0.979   1st Qu.:-0.983   1st Qu.:-0.993   1st Qu.:-0.9769  
##  Median :-0.864   Median :-0.895   Median :-0.942   Median :-0.8326  
##  Mean   :-0.537   Mean   :-0.665   Mean   :-0.603   Mean   :-0.5284  
##  3rd Qu.:-0.103   3rd Qu.:-0.366   3rd Qu.:-0.249   3rd Qu.:-0.0922  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.0000  
##   fBodyAccStdZ    fBodyAccJerkMeanX fBodyAccJerkMeanY fBodyAccJerkMeanZ
##  Min.   :-1.000   Min.   :-1.000    Min.   :-1.000    Min.   :-1.000   
##  1st Qu.:-0.978   1st Qu.:-0.991    1st Qu.:-0.985    1st Qu.:-0.987   
##  Median :-0.840   Median :-0.952    Median :-0.926    Median :-0.948   
##  Mean   :-0.618   Mean   :-0.657    Mean   :-0.629    Mean   :-0.744   
##  3rd Qu.:-0.302   3rd Qu.:-0.327    3rd Qu.:-0.264    3rd Qu.:-0.513   
##  Max.   : 1.000   Max.   : 1.000    Max.   : 1.000    Max.   : 1.000   
##  fBodyAccJerkStdX fBodyAccJerkStdY fBodyAccJerkStdZ fBodyGyroMeanX  
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.992   1st Qu.:-0.987   1st Qu.:-0.990   1st Qu.:-0.985  
##  Median :-0.956   Median :-0.928   Median :-0.959   Median :-0.892  
##  Mean   :-0.655   Mean   :-0.612   Mean   :-0.781   Mean   :-0.672  
##  3rd Qu.:-0.320   3rd Qu.:-0.236   3rd Qu.:-0.590   3rd Qu.:-0.384  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##  fBodyGyroMeanY   fBodyGyroMeanZ   fBodyGyroStdX    fBodyGyroStdY   
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.985   1st Qu.:-0.985   1st Qu.:-0.988   1st Qu.:-0.981  
##  Median :-0.920   Median :-0.888   Median :-0.905   Median :-0.906  
##  Mean   :-0.706   Mean   :-0.644   Mean   :-0.739   Mean   :-0.674  
##  3rd Qu.:-0.473   3rd Qu.:-0.323   3rd Qu.:-0.522   3rd Qu.:-0.438  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##  fBodyGyroStdZ    fBodyAccMagMean  fBodyAccMagStd  
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.986   1st Qu.:-0.985   1st Qu.:-0.983  
##  Median :-0.891   Median :-0.875   Median :-0.855  
##  Mean   :-0.690   Mean   :-0.586   Mean   :-0.659  
##  3rd Qu.:-0.417   3rd Qu.:-0.217   3rd Qu.:-0.382  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##  fBodyBodyAccJerkMagMean fBodyBodyAccJerkMagStd fBodyBodyGyroMagMean
##  Min.   :-1.000          Min.   :-1.000         Min.   :-1.000      
##  1st Qu.:-0.990          1st Qu.:-0.991         1st Qu.:-0.983      
##  Median :-0.929          Median :-0.925         Median :-0.876      
##  Mean   :-0.621          Mean   :-0.640         Mean   :-0.697      
##  3rd Qu.:-0.260          3rd Qu.:-0.308         3rd Qu.:-0.451      
##  Max.   : 1.000          Max.   : 1.000         Max.   : 1.000      
##  fBodyBodyGyroMagStd fBodyBodyGyroJerkMagMean fBodyBodyGyroJerkMagStd
##  Min.   :-1.000      Min.   :-1.000           Min.   :-1.000         
##  1st Qu.:-0.978      1st Qu.:-0.992           1st Qu.:-0.993         
##  Median :-0.828      Median :-0.945           Median :-0.938         
##  Mean   :-0.700      Mean   :-0.780           Mean   :-0.792         
##  3rd Qu.:-0.471      3rd Qu.:-0.612           3rd Qu.:-0.644         
##  Max.   : 1.000      Max.   : 1.000           Max.   : 1.000
```


Merged Data With Descriptive Activity dataset first 3 lines

```r
head(cleanedData, 3)
```

```
##   subject activity tBodyAccMeanX tBodyAccMeanY tBodyAccMeanZ tBodyAccStdX
## 1       1 standing        0.2886      -0.02029       -0.1329      -0.9953
## 2       1 standing        0.2784      -0.01641       -0.1235      -0.9982
## 3       1 standing        0.2797      -0.01947       -0.1135      -0.9954
##   tBodyAccStdY tBodyAccStdZ tGravityAccMeanX tGravityAccMeanY
## 1      -0.9831      -0.9135           0.9634          -0.1408
## 2      -0.9753      -0.9603           0.9666          -0.1416
## 3      -0.9672      -0.9789           0.9669          -0.1420
##   tGravityAccMeanZ tGravityAccStdX tGravityAccStdY tGravityAccStdZ
## 1           0.1154         -0.9852         -0.9817         -0.8776
## 2           0.1094         -0.9974         -0.9894         -0.9316
## 3           0.1019         -0.9996         -0.9929         -0.9929
##   tBodyAccJerkMeanX tBodyAccJerkMeanY tBodyAccJerkMeanZ tBodyAccJerkStdX
## 1           0.07800          0.005001         -0.067831          -0.9935
## 2           0.07401          0.005771          0.029377          -0.9955
## 3           0.07364          0.003104         -0.009046          -0.9907
##   tBodyAccJerkStdY tBodyAccJerkStdZ tBodyGyroMeanX tBodyGyroMeanY
## 1          -0.9884          -0.9936      -0.006101       -0.03136
## 2          -0.9811          -0.9918      -0.016112       -0.08389
## 3          -0.9810          -0.9897      -0.031698       -0.10234
##   tBodyGyroMeanZ tBodyGyroStdX tBodyGyroStdY tBodyGyroStdZ
## 1        0.10773       -0.9853       -0.9766       -0.9922
## 2        0.10058       -0.9831       -0.9890       -0.9891
## 3        0.09613       -0.9763       -0.9936       -0.9864
##   tBodyGyroJerkMeanX tBodyGyroJerkMeanY tBodyGyroJerkMeanZ
## 1           -0.09917           -0.05552           -0.06199
## 2           -0.11050           -0.04482           -0.05924
## 3           -0.10849           -0.04241           -0.05583
##   tBodyGyroJerkStdX tBodyGyroJerkStdY tBodyGyroJerkStdZ tBodyAccMagMean
## 1           -0.9921           -0.9925           -0.9921         -0.9594
## 2           -0.9899           -0.9973           -0.9939         -0.9793
## 3           -0.9885           -0.9956           -0.9915         -0.9837
##   tBodyAccMagStd tGravityAccMagMean tGravityAccMagStd tBodyAccJerkMagMean
## 1        -0.9506            -0.9594           -0.9506             -0.9933
## 2        -0.9761            -0.9793           -0.9761             -0.9913
## 3        -0.9880            -0.9837           -0.9880             -0.9885
##   tBodyAccJerkMagStd tBodyGyroMagMean tBodyGyroMagStd tBodyGyroJerkMagMean
## 1            -0.9943          -0.9690         -0.9643              -0.9942
## 2            -0.9917          -0.9807         -0.9838              -0.9951
## 3            -0.9904          -0.9763         -0.9861              -0.9934
##   tBodyGyroJerkMagStd fBodyAccMeanX fBodyAccMeanY fBodyAccMeanZ
## 1             -0.9914       -0.9948       -0.9830       -0.9393
## 2             -0.9961       -0.9975       -0.9769       -0.9735
## 3             -0.9951       -0.9936       -0.9725       -0.9833
##   fBodyAccStdX fBodyAccStdY fBodyAccStdZ fBodyAccJerkMeanX
## 1      -0.9954      -0.9831      -0.9062           -0.9923
## 2      -0.9987      -0.9749      -0.9554           -0.9950
## 3      -0.9963      -0.9655      -0.9770           -0.9910
##   fBodyAccJerkMeanY fBodyAccJerkMeanZ fBodyAccJerkStdX fBodyAccJerkStdY
## 1           -0.9872           -0.9897          -0.9958          -0.9909
## 2           -0.9813           -0.9897          -0.9967          -0.9821
## 3           -0.9816           -0.9876          -0.9912          -0.9814
##   fBodyAccJerkStdZ fBodyGyroMeanX fBodyGyroMeanY fBodyGyroMeanZ
## 1          -0.9971        -0.9866        -0.9818        -0.9895
## 2          -0.9926        -0.9774        -0.9925        -0.9896
## 3          -0.9904        -0.9754        -0.9937        -0.9868
##   fBodyGyroStdX fBodyGyroStdY fBodyGyroStdZ fBodyAccMagMean fBodyAccMagStd
## 1       -0.9850       -0.9739       -0.9940         -0.9522        -0.9561
## 2       -0.9849       -0.9872       -0.9898         -0.9809        -0.9759
## 3       -0.9766       -0.9934       -0.9873         -0.9878        -0.9890
##   fBodyBodyAccJerkMagMean fBodyBodyAccJerkMagStd fBodyBodyGyroMagMean
## 1                 -0.9937                -0.9938              -0.9801
## 2                 -0.9903                -0.9920              -0.9883
## 3                 -0.9893                -0.9909              -0.9893
##   fBodyBodyGyroMagStd fBodyBodyGyroJerkMagMean fBodyBodyGyroJerkMagStd
## 1             -0.9613                  -0.9920                 -0.9907
## 2             -0.9833                  -0.9959                 -0.9964
## 3             -0.9860                  -0.9950                 -0.9951
```


write out the Merged Data With Descriptive Activity dataset

```r
write.table(cleanedData, "MergedDataWithDescriptiveActivity.txt")
```


Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

```r
subjectLen <- length(table(joinSubject))
activityLen <- dim(activity)[1]
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow = subjectLen * activityLen, ncol = columnLen)
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for (i in 1:subjectLen) {
    for (j in 1:activityLen) {
        result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        bool1 <- i == cleanedData$subject
        bool2 <- activity[j, 2] == cleanedData$activity
        result[row, 3:columnLen] <- colMeans(cleanedData[bool1 & bool2, 3:columnLen])
        row <- row + 1
    }
}
```


tidy dataset dimensions

```r
dim(result)
```

```
## [1] 180  68
```


tidy dataset data structure

```r
summary(result)
```

```
##     subject       activity         tBodyAccMeanX   tBodyAccMeanY     
##  Min.   : 1.0   Length:180         Min.   :0.222   Min.   :-0.04051  
##  1st Qu.: 8.0   Class :character   1st Qu.:0.271   1st Qu.:-0.02002  
##  Median :15.5   Mode  :character   Median :0.277   Median :-0.01726  
##  Mean   :15.5                      Mean   :0.274   Mean   :-0.01788  
##  3rd Qu.:23.0                      3rd Qu.:0.280   3rd Qu.:-0.01494  
##  Max.   :30.0                      Max.   :0.301   Max.   :-0.00131  
##  tBodyAccMeanZ      tBodyAccStdX     tBodyAccStdY      tBodyAccStdZ   
##  Min.   :-0.1525   Min.   :-0.996   Min.   :-0.9902   Min.   :-0.988  
##  1st Qu.:-0.1121   1st Qu.:-0.980   1st Qu.:-0.9421   1st Qu.:-0.950  
##  Median :-0.1082   Median :-0.753   Median :-0.5090   Median :-0.652  
##  Mean   :-0.1092   Mean   :-0.558   Mean   :-0.4605   Mean   :-0.576  
##  3rd Qu.:-0.1044   3rd Qu.:-0.198   3rd Qu.:-0.0308   3rd Qu.:-0.231  
##  Max.   :-0.0754   Max.   : 0.627   Max.   : 0.6169   Max.   : 0.609  
##  tGravityAccMeanX tGravityAccMeanY  tGravityAccMeanZ  tGravityAccStdX 
##  Min.   :-0.680   Min.   :-0.4799   Min.   :-0.4951   Min.   :-0.997  
##  1st Qu.: 0.838   1st Qu.:-0.2332   1st Qu.:-0.1173   1st Qu.:-0.983  
##  Median : 0.921   Median :-0.1278   Median : 0.0238   Median :-0.970  
##  Mean   : 0.698   Mean   :-0.0162   Mean   : 0.0741   Mean   :-0.964  
##  3rd Qu.: 0.942   3rd Qu.: 0.0877   3rd Qu.: 0.1495   3rd Qu.:-0.951  
##  Max.   : 0.975   Max.   : 0.9566   Max.   : 0.9579   Max.   :-0.830  
##  tGravityAccStdY  tGravityAccStdZ  tBodyAccJerkMeanX tBodyAccJerkMeanY 
##  Min.   :-0.994   Min.   :-0.991   Min.   :0.0427    Min.   :-0.03869  
##  1st Qu.:-0.971   1st Qu.:-0.961   1st Qu.:0.0740    1st Qu.: 0.00047  
##  Median :-0.959   Median :-0.945   Median :0.0764    Median : 0.00947  
##  Mean   :-0.952   Mean   :-0.936   Mean   :0.0795    Mean   : 0.00757  
##  3rd Qu.:-0.937   3rd Qu.:-0.918   3rd Qu.:0.0833    3rd Qu.: 0.01340  
##  Max.   :-0.644   Max.   :-0.610   Max.   :0.1302    Max.   : 0.05682  
##  tBodyAccJerkMeanZ  tBodyAccJerkStdX tBodyAccJerkStdY tBodyAccJerkStdZ
##  Min.   :-0.06746   Min.   :-0.995   Min.   :-0.990   Min.   :-0.993  
##  1st Qu.:-0.01060   1st Qu.:-0.983   1st Qu.:-0.972   1st Qu.:-0.983  
##  Median :-0.00386   Median :-0.810   Median :-0.776   Median :-0.884  
##  Mean   :-0.00495   Mean   :-0.595   Mean   :-0.565   Mean   :-0.736  
##  3rd Qu.: 0.00196   3rd Qu.:-0.223   3rd Qu.:-0.148   3rd Qu.:-0.512  
##  Max.   : 0.03805   Max.   : 0.544   Max.   : 0.355   Max.   : 0.031  
##  tBodyGyroMeanX    tBodyGyroMeanY    tBodyGyroMeanZ    tBodyGyroStdX   
##  Min.   :-0.2058   Min.   :-0.2042   Min.   :-0.0724   Min.   :-0.994  
##  1st Qu.:-0.0471   1st Qu.:-0.0896   1st Qu.: 0.0747   1st Qu.:-0.974  
##  Median :-0.0287   Median :-0.0732   Median : 0.0851   Median :-0.789  
##  Mean   :-0.0324   Mean   :-0.0743   Mean   : 0.0874   Mean   :-0.692  
##  3rd Qu.:-0.0168   3rd Qu.:-0.0611   3rd Qu.: 0.1018   3rd Qu.:-0.441  
##  Max.   : 0.1927   Max.   : 0.0275   Max.   : 0.1791   Max.   : 0.268  
##  tBodyGyroStdY    tBodyGyroStdZ    tBodyGyroJerkMeanX tBodyGyroJerkMeanY
##  Min.   :-0.994   Min.   :-0.986   Min.   :-0.1572    Min.   :-0.0768   
##  1st Qu.:-0.963   1st Qu.:-0.961   1st Qu.:-0.1032    1st Qu.:-0.0455   
##  Median :-0.802   Median :-0.801   Median :-0.0987    Median :-0.0411   
##  Mean   :-0.653   Mean   :-0.616   Mean   :-0.0961    Mean   :-0.0427   
##  3rd Qu.:-0.420   3rd Qu.:-0.311   3rd Qu.:-0.0911    3rd Qu.:-0.0384   
##  Max.   : 0.476   Max.   : 0.565   Max.   :-0.0221    Max.   :-0.0132   
##  tBodyGyroJerkMeanZ tBodyGyroJerkStdX tBodyGyroJerkStdY tBodyGyroJerkStdZ
##  Min.   :-0.09250   Min.   :-0.997    Min.   :-0.997    Min.   :-0.995   
##  1st Qu.:-0.06172   1st Qu.:-0.980    1st Qu.:-0.983    1st Qu.:-0.985   
##  Median :-0.05343   Median :-0.840    Median :-0.894    Median :-0.861   
##  Mean   :-0.05480   Mean   :-0.704    Mean   :-0.764    Mean   :-0.710   
##  3rd Qu.:-0.04898   3rd Qu.:-0.463    3rd Qu.:-0.586    3rd Qu.:-0.474   
##  Max.   :-0.00694   Max.   : 0.179    Max.   : 0.296    Max.   : 0.193   
##  tBodyAccMagMean   tBodyAccMagStd   tGravityAccMagMean tGravityAccMagStd
##  Min.   :-0.9865   Min.   :-0.987   Min.   :-0.9865    Min.   :-0.987   
##  1st Qu.:-0.9573   1st Qu.:-0.943   1st Qu.:-0.9573    1st Qu.:-0.943   
##  Median :-0.4829   Median :-0.607   Median :-0.4829    Median :-0.607   
##  Mean   :-0.4973   Mean   :-0.544   Mean   :-0.4973    Mean   :-0.544   
##  3rd Qu.:-0.0919   3rd Qu.:-0.209   3rd Qu.:-0.0919    3rd Qu.:-0.209   
##  Max.   : 0.6446   Max.   : 0.428   Max.   : 0.6446    Max.   : 0.428   
##  tBodyAccJerkMagMean tBodyAccJerkMagStd tBodyGyroMagMean tBodyGyroMagStd 
##  Min.   :-0.993      Min.   :-0.995     Min.   :-0.981   Min.   :-0.981  
##  1st Qu.:-0.981      1st Qu.:-0.977     1st Qu.:-0.946   1st Qu.:-0.948  
##  Median :-0.817      Median :-0.801     Median :-0.655   Median :-0.742  
##  Mean   :-0.608      Mean   :-0.584     Mean   :-0.565   Mean   :-0.630  
##  3rd Qu.:-0.246      3rd Qu.:-0.217     3rd Qu.:-0.216   3rd Qu.:-0.360  
##  Max.   : 0.434      Max.   : 0.451     Max.   : 0.418   Max.   : 0.300  
##  tBodyGyroJerkMagMean tBodyGyroJerkMagStd fBodyAccMeanX   
##  Min.   :-0.9973      Min.   :-0.998      Min.   :-0.995  
##  1st Qu.:-0.9852      1st Qu.:-0.981      1st Qu.:-0.979  
##  Median :-0.8648      Median :-0.881      Median :-0.769  
##  Mean   :-0.7364      Mean   :-0.755      Mean   :-0.576  
##  3rd Qu.:-0.5119      3rd Qu.:-0.577      3rd Qu.:-0.217  
##  Max.   : 0.0876      Max.   : 0.250      Max.   : 0.537  
##  fBodyAccMeanY     fBodyAccMeanZ     fBodyAccStdX     fBodyAccStdY    
##  Min.   :-0.9890   Min.   :-0.990   Min.   :-0.997   Min.   :-0.9907  
##  1st Qu.:-0.9536   1st Qu.:-0.962   1st Qu.:-0.982   1st Qu.:-0.9404  
##  Median :-0.5950   Median :-0.724   Median :-0.747   Median :-0.5134  
##  Mean   :-0.4887   Mean   :-0.630   Mean   :-0.552   Mean   :-0.4815  
##  3rd Qu.:-0.0634   3rd Qu.:-0.318   3rd Qu.:-0.197   3rd Qu.:-0.0791  
##  Max.   : 0.5242   Max.   : 0.281   Max.   : 0.658   Max.   : 0.5602  
##   fBodyAccStdZ    fBodyAccJerkMeanX fBodyAccJerkMeanY fBodyAccJerkMeanZ
##  Min.   :-0.987   Min.   :-0.995    Min.   :-0.989    Min.   :-0.992   
##  1st Qu.:-0.946   1st Qu.:-0.983    1st Qu.:-0.973    1st Qu.:-0.980   
##  Median :-0.644   Median :-0.813    Median :-0.782    Median :-0.871   
##  Mean   :-0.582   Mean   :-0.614    Mean   :-0.588    Mean   :-0.714   
##  3rd Qu.:-0.266   3rd Qu.:-0.282    3rd Qu.:-0.196    3rd Qu.:-0.470   
##  Max.   : 0.687   Max.   : 0.474    Max.   : 0.277    Max.   : 0.158   
##  fBodyAccJerkStdX fBodyAccJerkStdY fBodyAccJerkStdZ  fBodyGyroMeanX  
##  Min.   :-0.995   Min.   :-0.991   Min.   :-0.9931   Min.   :-0.993  
##  1st Qu.:-0.985   1st Qu.:-0.974   1st Qu.:-0.9837   1st Qu.:-0.970  
##  Median :-0.825   Median :-0.785   Median :-0.8951   Median :-0.730  
##  Mean   :-0.612   Mean   :-0.571   Mean   :-0.7565   Mean   :-0.637  
##  3rd Qu.:-0.247   3rd Qu.:-0.169   3rd Qu.:-0.5438   3rd Qu.:-0.339  
##  Max.   : 0.477   Max.   : 0.350   Max.   :-0.0062   Max.   : 0.475  
##  fBodyGyroMeanY   fBodyGyroMeanZ   fBodyGyroStdX    fBodyGyroStdY   
##  Min.   :-0.994   Min.   :-0.986   Min.   :-0.995   Min.   :-0.994  
##  1st Qu.:-0.970   1st Qu.:-0.962   1st Qu.:-0.975   1st Qu.:-0.960  
##  Median :-0.814   Median :-0.791   Median :-0.809   Median :-0.796  
##  Mean   :-0.677   Mean   :-0.604   Mean   :-0.711   Mean   :-0.645  
##  3rd Qu.:-0.446   3rd Qu.:-0.264   3rd Qu.:-0.481   3rd Qu.:-0.415  
##  Max.   : 0.329   Max.   : 0.492   Max.   : 0.197   Max.   : 0.646  
##  fBodyGyroStdZ    fBodyAccMagMean  fBodyAccMagStd  
##  Min.   :-0.987   Min.   :-0.987   Min.   :-0.988  
##  1st Qu.:-0.964   1st Qu.:-0.956   1st Qu.:-0.945  
##  Median :-0.822   Median :-0.670   Median :-0.651  
##  Mean   :-0.658   Mean   :-0.536   Mean   :-0.621  
##  3rd Qu.:-0.392   3rd Qu.:-0.162   3rd Qu.:-0.365  
##  Max.   : 0.522   Max.   : 0.587   Max.   : 0.179  
##  fBodyBodyAccJerkMagMean fBodyBodyAccJerkMagStd fBodyBodyGyroMagMean
##  Min.   :-0.994          Min.   :-0.994         Min.   :-0.987      
##  1st Qu.:-0.977          1st Qu.:-0.975         1st Qu.:-0.962      
##  Median :-0.794          Median :-0.813         Median :-0.766      
##  Mean   :-0.576          Mean   :-0.599         Mean   :-0.667      
##  3rd Qu.:-0.187          3rd Qu.:-0.267         3rd Qu.:-0.409      
##  Max.   : 0.538          Max.   : 0.316         Max.   : 0.204      
##  fBodyBodyGyroMagStd fBodyBodyGyroJerkMagMean fBodyBodyGyroJerkMagStd
##  Min.   :-0.982      Min.   :-0.998           Min.   :-0.998         
##  1st Qu.:-0.949      1st Qu.:-0.981           1st Qu.:-0.980         
##  Median :-0.773      Median :-0.878           Median :-0.894         
##  Mean   :-0.672      Mean   :-0.756           Mean   :-0.771         
##  3rd Qu.:-0.428      3rd Qu.:-0.583           3rd Qu.:-0.608         
##  Max.   : 0.237      Max.   : 0.147           Max.   : 0.288
```


tidy dataset first 3 lines

```r
head(result, 3)
```

```
##   subject          activity tBodyAccMeanX tBodyAccMeanY tBodyAccMeanZ
## 1       1           walking        0.2773     -0.017384       -0.1111
## 2       1   walkingUpstairs        0.2555     -0.023953       -0.0973
## 3       1 walkingDownstairs        0.2892     -0.009919       -0.1076
##   tBodyAccStdX tBodyAccStdY tBodyAccStdZ tGravityAccMeanX tGravityAccMeanY
## 1     -0.28374      0.11446     -0.26003           0.9352          -0.2822
## 2     -0.35471     -0.00232     -0.01948           0.8934          -0.3622
## 3      0.03004     -0.03194     -0.23043           0.9319          -0.2666
##   tGravityAccMeanZ tGravityAccStdX tGravityAccStdY tGravityAccStdZ
## 1         -0.06810         -0.9766         -0.9713         -0.9477
## 2         -0.07540         -0.9564         -0.9528         -0.9124
## 3         -0.06212         -0.9506         -0.9370         -0.8959
##   tBodyAccJerkMeanX tBodyAccJerkMeanY tBodyAccJerkMeanZ tBodyAccJerkStdX
## 1           0.07404           0.02827         -0.004168         -0.11362
## 2           0.10137           0.01949         -0.045563         -0.44684
## 3           0.05416           0.02965         -0.010972         -0.01228
##   tBodyAccJerkStdY tBodyAccJerkStdZ tBodyGyroMeanX tBodyGyroMeanY
## 1           0.0670          -0.5027       -0.04183       -0.06953
## 2          -0.3783          -0.7066        0.05055       -0.16617
## 3          -0.1016          -0.3457       -0.03508       -0.09094
##   tBodyGyroMeanZ tBodyGyroStdX tBodyGyroStdY tBodyGyroStdZ
## 1        0.08494       -0.4735     -0.054608       -0.3443
## 2        0.05836       -0.5449      0.004105       -0.5072
## 3        0.09009       -0.4580     -0.126349       -0.1247
##   tBodyGyroJerkMeanX tBodyGyroJerkMeanY tBodyGyroJerkMeanZ
## 1           -0.09000           -0.03984           -0.04613
## 2           -0.12223           -0.04215           -0.04071
## 3           -0.07396           -0.04399           -0.02705
##   tBodyGyroJerkStdX tBodyGyroJerkStdY tBodyGyroJerkStdZ tBodyAccMagMean
## 1           -0.2074           -0.3045           -0.4043        -0.13697
## 2           -0.6148           -0.6017           -0.6063        -0.12993
## 3           -0.4870           -0.2388           -0.2688         0.02719
##   tBodyAccMagStd tGravityAccMagMean tGravityAccMagStd tBodyAccJerkMagMean
## 1       -0.21969           -0.13697          -0.21969            -0.14143
## 2       -0.32497           -0.12993          -0.32497            -0.46650
## 3        0.01988            0.02719           0.01988            -0.08945
##   tBodyAccJerkMagStd tBodyGyroMagMean tBodyGyroMagStd tBodyGyroJerkMagMean
## 1           -0.07447         -0.16098         -0.1870              -0.2987
## 2           -0.47899         -0.12674         -0.1486              -0.5949
## 3           -0.02579         -0.07574         -0.2257              -0.2955
##   tBodyGyroJerkMagStd fBodyAccMeanX fBodyAccMeanY fBodyAccMeanZ
## 1             -0.3253      -0.20279       0.08971       -0.3316
## 2             -0.6486      -0.40432      -0.19098       -0.4333
## 3             -0.3065       0.03823       0.00155       -0.2256
##   fBodyAccStdX fBodyAccStdY fBodyAccStdZ fBodyAccJerkMeanX
## 1     -0.31913      0.05604     -0.27969          -0.17055
## 2     -0.33743      0.02177      0.08596          -0.47988
## 3      0.02433     -0.11296     -0.29793          -0.02766
##   fBodyAccJerkMeanY fBodyAccJerkMeanZ fBodyAccJerkStdX fBodyAccJerkStdY
## 1          -0.03523           -0.4690         -0.13359           0.1067
## 2          -0.41344           -0.6855         -0.46191          -0.3818
## 3          -0.12867           -0.2883         -0.08633          -0.1346
##   fBodyAccJerkStdZ fBodyGyroMeanX fBodyGyroMeanY fBodyGyroMeanZ
## 1          -0.5347        -0.3390        -0.1031       -0.25594
## 2          -0.7260        -0.4926        -0.3195       -0.45360
## 3          -0.4017        -0.3524        -0.0557       -0.03187
##   fBodyGyroStdX fBodyGyroStdY fBodyGyroStdZ fBodyAccMagMean fBodyAccMagStd
## 1       -0.5167      -0.03351       -0.4366        -0.12862        -0.3980
## 2       -0.5659       0.15154       -0.5717        -0.35240        -0.4163
## 3       -0.4954      -0.18141       -0.2384         0.09658        -0.1865
##   fBodyBodyAccJerkMagMean fBodyBodyAccJerkMagStd fBodyBodyGyroMagMean
## 1                -0.05712                -0.1035              -0.1993
## 2                -0.44265                -0.5331              -0.3260
## 3                 0.02622                -0.1041              -0.1857
##   fBodyBodyGyroMagStd fBodyBodyGyroJerkMagMean fBodyBodyGyroJerkMagStd
## 1             -0.3210                  -0.3193                 -0.3816
## 2             -0.1830                  -0.6347                 -0.6939
## 3             -0.3984                  -0.2820                 -0.3919
```


write out the Tidy Data With Means dataset


```r
write.table(result, "TidyDataWithMeans.txt")  # write out the 2nd dataset
```


