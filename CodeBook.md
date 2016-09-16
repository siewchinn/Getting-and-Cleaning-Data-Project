## Code Book

### Data

* Human Activity Recognition Using Smartphones Dataset.
* The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
* Each person performed six activities: (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
*	The dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
*	The dataset includes the following files:

File | Description |	Details
----- | ---------- | ---------
README.txt |  | 		
train/y_train.txt |	Training labels | Subject identifiers	7352 rows
train/X_train.txt |	Training set | Measurements of all the features	7352 rows x 561 columns
test/y_test.txt	| Test labels | Subject identifiers	2947 rows
test/X_test.txt	| Test set | Measurements of all the features	2947 rows x 561 columns
activity_labels.txt	| Links the class labels with their activity name. | 6 Activity IDs and the descriptive names
train/subject_train.txt | Each row identifies the subject who performed the activity for each window sample. | 1  3  5  6  7  8 11 14 15 16 17 19 21 22 23 25 26 27 28 29 30
test/subject_test.txt	| Each row identifies the subject who performed the activity for each window sample. | 2  4  9 10 12 13 18 20 24
features.txt	| List of all features.	| 561 feature-vector
features_info.txt	| Shows information about the variables used on the feature vector. |	

### Variable and Descriptions:

Variable | Description | Identifier
-------- | ----------- | ------------
Subject | Identifier of 30 volunteers | 1 to 30
Activity | WALKING |	1
	| WALKING_UPSTAIRS	| 2
	| WALKING_DOWNSTAIRS | 3
	| SITTING	| 4
	| STANDING |	5
	| LAYING | 6
Features |	List of 561 feature-vector |	

#### _Feature Selection_ 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  

'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value,
std(): Standard deviation value

### Transformation to Data:
Transformation performed to generate a tidy data set:

Data |	Transformation
----- | ----------------
train/subject_train.txt, train/y_train.txt, train/X_train.txt	| 1.	Read into R as train.subject, train.y and train.x
 | 2. Concatenate all columns as train.data in the order of train.subject, train.y, train.x
test/subject_test.txt, test/y_test.txt, test/X_test.txt	| 1.	Read into R as test.subject, test.y and test.x
 | 2. Concatenate all columns as test.data in the order of test.subject, test.y, test.x
 | 3.	Concatenate rows of train.data and test.data as one single data frame full.data
features.txt	| 1. Read into R as a data frame features. Extracted the descriptive names as features.names. 
 | 2. Select only features.names with “mean” or “std” using grep ()
 | 3. Store as features.idx
 | 4. Subset data frame full.data using festures.idx into data frame sub.data (dimension: 10922 rows x 68 columns)
 | 5. Variable names of sub.data is relabelled with descriptive variable names using gsub ()
activity_labels.txt |	1. Read into R as a data frame activities. 
 | 2. Replace the activity identifier (1 to 6) with descriptive activity names in Activity column of sub.data
tidy.data.txt	|	1. Group the sub.data by Subject and Activity using group_by()
 | 2.	Apply function (mean) to one or more columns using summarise_each()
 | 3. Store final data as group.sub.data and write into comma delimited txt file
