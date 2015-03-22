## Code book

### Introduction

This code book accompanies the script [`run_analysis.R`](https://github.com/pc8/GettingAndCleaningDataProject/blob/master/run_analysis.R) in this repo. According to the project assignment 

>"[...] a code book describes the variables, the data, and any transformations or work that you performed to clean up the data [...]". 

See also the [README](https://github.com/pc8/GettingAndCleaningDataProject/blob/master/README.md) file for further information. 

### Raw data and study design

The description of the underlying experiment **"Human Activity Recognition Using Smartphones Data Set"** for the raw data set can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

A brief summary/quote of the raw data set and of the experiment:

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The raw data itself can be downloaded from [this source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The folder structure below shows which raw data files are required for the creation of the tidy data set. Not required files are not mentioned in the diagram. 

```
-- UCI HAR Dataset
|  -- features.txt                  <-- contains the original variable names
|  -- test
|  |  -- subject_test.txt           <-- Each row identifies the subject who performed the activity for each window sample
|  |  -- X_test.txt                 <-- Test data set
|  |  -- y_test.txt                 <-- Test activity IDs
|  -- train
|  |  -- subject_train.txt          <-- Each row identifies the subject who performed the activity for each window sample
|  |  -- X_train.txt                <-- Training data set
|  |  -- y_train.txt                <-- Test activity IDs

```

### Transformations

This paragraph lists the different steps to transform the raw data set to the tidy data set. Please also refer to the inline comments in [`run_analysis.R`](https://github.com/pc8/GettingAndCleaningDataProject/blob/master/run_analysis.R) file for more information. 


1. Download the [raw data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzip the files in the current working directory. 

2. Load the required files as described above in the folder structure diagram. 

3. Use the y_test.txt and y_train.txt files to map the activity IDs to their actual activity labels for each observation. Moreover, name the first variable "Subject_ID" and the second variable "Activity_name".

4. Merge, i.e. column-bind, the test files to one single test data frame and the training files to one single training data frame. 

5. Merge, i.e. row-bind, the single test data frame and the single training data frame from step 4. 

6. Set the variable names according to the variable names in `features.txt`.  

7. Subset the data frame and extract only the measurements on the mean and standard deviation for each measurement, i.e. only the variables with `mean()` and `std()` in their names.   

8. Renaming variables

The original variable names were modified to be more descriptive/readable. More precisely, abbreviations were written out and parenthesis removed:

| original parts of variable name | modified parts of variable name |
| ------------------------------- | ------------------------------- |
| t | time |
| f | frequency |
| Acc | acceleration |
| Gyro | gyroscope |
| Mag | magnitude |
| mean() | mean |
| std() | std deviation |

9. Group by "Subject_ID" and "Activity_name", then calculate for each variable the mean value. 

10. Write result to tidy_data.txt.


### Output (tidy) data 

The resulting tidy data set in the file `tidy_data.txt` includes for each subject and each activity the calculated mean for all original variables that contain the string "mean()" or "std()" in their original names. 

It is tidy according to the definition in [Hadley Wickham's paper "Tidy Data"](http://vita.had.co.nz/papers/tidy-data.pdf):

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

The data set has following dimensions **180 observations of 68 variables**

#### List of variables

The 68 variables of the tidy data set are as follows:

```
- Subject_ID 
- Activity_name 
- time-body acceleration-mean-X  
- time-body acceleration-mean-Y  
- time-body acceleration-mean-Z 
- time-body acceleration-std deviation-X  
- time-body acceleration-std deviation-Y  
- time-body acceleration-std deviation-Z  
- time-gravity acceleration-mean-X  
- time-gravity acceleration-mean-Y  
- time-gravity acceleration-mean-Z  
- time-gravity acceleration-std deviation-X  
- time-gravity acceleration-std deviation-Y  
- time-gravity acceleration-std deviation-Z  
- time-body acceleration Jerk-mean-X  
- time-body acceleration Jerk-mean-Y  
- time-body acceleration Jerk-mean-Z  
- time-body acceleration Jerk-std deviation-X  
- time-body acceleration Jerk-std deviation-Y  
- time-body acceleration Jerk-std deviation-Z  
- time-body gyroscope-mean-X  
- time-body gyroscope-mean-Y  
- time-body gyroscope-mean-Z  
- time-body gyroscope-std deviation-X  
- time-body gyroscope-std deviation-Y  
- time-body gyroscope-std deviation-Z  
- time-body gyroscope Jerk-mean-X  
- time-body gyroscope Jerk-mean-Y  
- time-body gyroscope Jerk-mean-Z  
- time-body gyroscope Jerk-std deviation-X  
- time-body gyroscope Jerk-std deviation-Y 
- time-body gyroscope Jerk-std deviation-Z  
- time-body acceleration magnitude-mean  
- time-body acceleration magnitude-std deviation  
- time-gravity acceleration magnitude-mean  
- time-gravity acceleration magnitude-std deviation  
- time-body acceleration Jerk magnitude-mean  
- time-body acceleration Jerk magnitude-std deviation  
- time-body gyroscope magnitude-mean  
- time-body gyroscope magnitude-std deviation  
- time-body gyroscope Jerk magnitude-mean  
- time-body gyroscope Jerk magnitude-std deviation  
- frequency-body acceleration-mean-X 
- frequency-body acceleration-mean-Y 
- frequency-body acceleration-mean-Z 
- frequency-body acceleration-std deviation-X  
- frequency-body acceleration-std deviation-Y 
- frequency-body acceleration-std deviation-Z  
- frequency-body acceleration Jerk-mean-X 
- frequency-body acceleration Jerk-mean-Y 
- frequency-body acceleration Jerk-mean-Z 
- frequency-body acceleration Jerk-std deviation-X 
- frequency-body acceleration Jerk-std deviation-Y  
- frequency-body acceleration Jerk-std deviation-Z  
- frequency-body gyroscope-mean-X  
- frequency-body gyroscope-mean-Y  
- frequency-body gyroscope-mean-Z 
- frequency-body gyroscope-std deviation-X
- frequency-body gyroscope-std deviation-Y 
- frequency-body gyroscope-std deviation-Z  
- frequency-body acceleration magnitude-mean  
- frequency-body acceleration magnitude-std deviation  
- frequency-Bodybody acceleration Jerk magnitude-mean 
- frequency-Bodybody acceleration Jerk magnitude-std deviation 
- frequency-Bodybody gyroscope magnitude-mean  
- frequency-Bodybody gyroscope magnitude-std deviation  
- frequency-Bodybody gyroscope Jerk magnitude-mean  
- frequency-Bodybody gyroscope Jerk magnitude-std deviation 
```


#### Description of variables

This is an extract of the `features_info.txt` included in the [raw data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) with some adapations (*in italics*) on the variable names due to their modifications for the sake of readibility. Please refer to that document for a complete view. 


> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (*time-body acceleration-XYZ and time-gravity acceleration-XYZ*) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (*time-body acceleration Jerk-XYZ and time-body gyroscope Jerk-XYZ*). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (*time-body acceleration magnitude, time-gravity acceleration magnitude, time-body acceleration Jerk magnitude, time-body gyroscope magnitude, time-body gyroscope Jerk magnitude*).

> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing *frequency-body gyroscope-XYZ, frequency-body acceleration Jerk magnitude, frequency-body gyroscope magnitude, frequency-body gyroscope Jerk magnitude*. (Note the 'f' to indicate frequency domain signals).

> These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

> The set of variables that were estimated from these signals are:
> - mean(): Mean value 
> - std(): Standard deviation


#### Type of variables

- Subject_ID: integer with range 1 to 30
- Activity_name: factor with 6 levels (LAYING, SITTING, STANDING, WALKING, WALKING DOWNSTAIRS, WALKING UPSTAIRS)
- All other variables: numeric, normalized and bounded within [-1,1]

## References

- Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
