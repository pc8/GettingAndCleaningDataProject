### Introduction

The script `run_analysis.R` and the [code book](https://github.com/pc8/GettingAndCleaningDataProject/blob/master/codebook.md) are the results of the project assignment for Coursera's "Getting and cleaning data" course (March 2015). 

More information about the underlying experiment "Human Activity Recognition Using Smartphones Data Set" for this assignment can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The underlying raw data set for the assigment can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).


#### Detailed project assignment

>You should create one R script called run_analysis.R that does the following.
>
>1. Merges the training and the test sets to create one data set.
>2. Extracts only the measurements on the mean and standard deviation for each measurement. 
>3. Uses descriptive activity names to name the activities in the data set
>4. Appropriately labels the data set with descriptive variable names. 
>5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### run_analysis.R

The script `run_analysis.R` calculates the average of each variable for each subject and each activity. Please refer to the files `features_info.txt` and `features.txt` included in the [raw data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) for more information about the variables.

#### Input

The script downloads and unzips the [raw data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) automatically. 
Following files of the [raw data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) are required as input files for the script:

```
-- UCI HAR Dataset
|  -- features.txt
|  -- test
|  |  -- subject_test.txt
|  |  -- X_test.txt
|  |  -- y_test.txt
|  -- train
|  |  -- subject_train.txt
|  |  -- X_train.txt
|  |  -- y_train.txt

```

#### Output

The output of the script is a text file `tidydata.txt`.

See the [code book](https://github.com/pc8/GettingAndCleaningDataProject/blob/master/codebook.md) for further details.  

#### Dependencies

The script requires two R packages:
* `scriptr`
* `dplyr`



