# ASSIGNMENT REQUIREMENTS:
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Load required libraries

install.packages("stringr")
library(stringr)
install.packages("dplyr")
library(dplyr)

#########################################################################################################
# Download and unzip file to current working directory.
#########################################################################################################

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ", destfile = "getdata-projectfiles-UCI HAR Dataset.zip", mode='wb')

unzip("getdata-projectfiles-UCI HAR Dataset.zip" , exdir = ".")


#########################################################################################################
# Requirement 1: Merges the training and the test sets to create one data set.
# +
# Requirement 3: Uses descriptive activity names to name the activities in the data set
#########################################################################################################

# load all 3 training data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
# Create a vector activityName that contains the descriptive activity name following the order given by y_train
activityName <- apply(y_train, 1, function(x) {switch(x,"WALKING","WALKING UPSTAIRS","WALKING DOWNSTAIRS","SITTING","STANDING","LAYING")})
# Merge training data into one single data frame. We omit the y_train data, i.e. activity ID, as it is not required. Instead we use the descriptive activity names.
df_train <- cbind(subject_train, activityName, x_train) 

# load all 3 test data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
# Create a vector activityName that contains the descriptive activity name following the order given by y_test
activityName <- apply(y_test, 1, function(x) {switch(x,"WALKING","WALKING UPSTAIRS","WALKING DOWNSTAIRS","SITTING","STANDING","LAYING")})
# Merge training data into one single data frame. We omit the y_test data, i.e. activity ID, as it is not required. Instead we use the descriptive activity names.
df_test <- cbind(subject_test, activityName, x_test) 

# merge training and test data into one single data frame
df_step1 <- rbind(df_train, df_test)


#########################################################################################################
# Requirement 4: Appropriately labels the data set with descriptive variable names.
#########################################################################################################


# Define labels for the first two variables in the data frame
names <- c("Subject_ID", "Activity_name")
# Retrieve the labels for each variable. This information is stored in features.txt.
features <- read.table("./UCI HAR Dataset/features.txt")
measurement <- as.character(features[,2])
# Merge Subject_ID, Activity_name and all measurement lables. 
allnames <- c(names, measurement)
# Apply new labels to data frame
colnames(df_step1) <- allnames



#########################################################################################################
# Requirement 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# & 
# Requirement 4: Appropriately labels the data set with descriptive variable names.
#########################################################################################################

# Retrieve all column names
columnnames <- names(df_step1)
# Identify only columns with "mean()" in their name
columnWithMean <- grepl("mean()", columnnames, fixed = TRUE)
# Identify only columns with "std()" in their name
columnWithSTD <- grepl("std()", columnnames, fixed = TRUE)
# Merge both logial vectors to one
myColumnWithMeanAndSTD <- columnWithMean | columnWithSTD
# Add first column, i.e. subject ID, to new data frame
myColumnWithMeanAndSTD[1] <- TRUE
# Add second column, i.e. activity name, to new data frame
myColumnWithMeanAndSTD[2] <- TRUE
# Build new data frame
df_step2  <- df_step1[  , myColumnWithMeanAndSTD]


# Modifying variable names to be even more descriptive 
moreDescriptive <- colnames(df_step2)
moreDescriptive <- str_replace_all(moreDescriptive, "mean\\(\\)", "mean")
moreDescriptive <- str_replace_all(moreDescriptive, "BodyAcc", "body acceleration")
moreDescriptive <- str_replace_all(moreDescriptive, "GravityAcc", "gravity acceleration")
moreDescriptive <- str_replace_all(moreDescriptive, "std\\(\\)", "std deviation")
moreDescriptive <- str_replace_all(moreDescriptive, "^t", "time-")
moreDescriptive <- str_replace_all(moreDescriptive, "^f", "frequency-")
moreDescriptive <- str_replace_all(moreDescriptive, "Jerk", " Jerk")
moreDescriptive <- str_replace_all(moreDescriptive, "Mag", " magnitude")
moreDescriptive <- str_replace_all(moreDescriptive, "BodyGyro", "body gyroscope")
colnames(df_step2) <- moreDescriptive


#################################################################################################################################################################
# Requirement 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#################################################################################################################################################################

# Group by Subject_ID and Activity_name
# For all remaining variables calculate the average. summarise_each is used for this purpose.
df_result <- df_step2 %>% group_by(Subject_ID, Activity_name) %>% summarise_each(funs(mean))

# Print and export result data frame
print(df_result)
print(str(df_result))

write.table(df_result, "tidydata.txt", row.name = FALSE)
