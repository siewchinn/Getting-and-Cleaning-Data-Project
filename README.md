# Getting-and-Cleaning-Data-Project

Getting and Cleaning Data Course Project

Data Source:
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The R script “run_analysis.R” does the following:

1. Set working directory.

2. Load the required library (data.table, dplyr).

3. Download the dataset from the given URL:
  - Check if the zipped file does not already exist in the directory called “data”
  - If file not exist, create a directory called “data”
  - Download the zipped file into the “data” directory and unzipped it
  - Remove the zipped file
  - View the list of files in the unzipped folder named “UCI HAR Dataset”

4. Read the required data (train and test) into R: 
  - 2 train datasets (train.x and train.y) and the subject_train
  - 2 test datasets (test.x and test.y) and the subject_test

5. Merge the train and test sets as one dataset:
  - Concatenate all the train sets by column using (in the order of subject_train, train.x, train.y). Repeat for test sets
  - Concatenate both sets by row to get a single data frame

6. Extracts only the measurements on the mean and standard deviation for each measurement:
  - Read features.txt into R. Get the feature names in the second column.
  - Subset the features names by grepping only names with “mean” and “standard deviation”. 
  - Subset the data frame by the selected feature names (represented as index).
  - Rename the column names of the subset data frame

7. Uses descriptive activity names to name the activities in the data set
	- Read activity_labels.txt (descriptive activity names) into R 
  - Match the activity variable of subset data frame with the descriptive activity names

8. Appropriately labels the data set with descriptive variable names:
  - Use gsub to re-label the subset data frame with descriptive variable names 

9. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:
  -  Require dplyr package
  - Group_by Subject and Activity and summarise each variable using “mean” function 
  - Print to screen to check the final table 

10. Writes the tidy dataset as a comma delimited file called tidy.data.txt.
