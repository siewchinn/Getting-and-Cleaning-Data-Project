## Week4:Programming Project
## Download data from web and unzip it 
## 1.Merges the training and the test sets to create one data set.
## 2.Extracts only the measurements on the mean and standard deviation for each measurement.
## 3.Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive variable names.
## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#set working directory
setwd("/Users/cffong-i7/Desktop/coursera/data.cleaning")

#load libraries
library(data.table)
library(dplyr)

##Download data from web and unzip it

#Check "data" directory is created and download zip file from web
if(!file.exists("./data")) dir.create("./data") 
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./data/dataset.zip")

#unzip file and remove the zip file
listZip <- unzip("./data/dataset.zip", exdir = "./data")
file.remove("./data/dataset.zip")

#View the files
pathIn <- file.path("/Users/cffong-i7/Desktop/coursera/data.cleaning/data", "UCI HAR Dataset")
list.files(pathIn, recursive=TRUE)

#load data into R
train.x <- read.table("./data/UCI HAR Dataset/train/X_train.txt") #dim 7352x561
train.y <- read.table("./data/UCI HAR Dataset/train/y_train.txt") #dim 7352x1
train.subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt") #dim 7352x1

test.x <- read.table("./data/UCI HAR Dataset/test/X_test.txt") # dim 2947x561
test.y <- read.table("./data/UCI HAR Dataset/test/y_test.txt") # dim 2947x1
test.subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

## 1.Merges the training and the test sets to create one data set.
train.data <- cbind(train.subject, train.y, train.x)
test.data <- cbind(test.subject, test.y, test.x)
full.data <- rbind(train.data, test.data) #dim 10299X563

## 2.Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./data/UCI HAR Dataset/features.txt")
features.names <- features[,2]
features.idx <- grep(("mean\\(\\)|std\\(\\)"), features.names)
sub.data <- full.data[,c(1,2,features.idx+2)] #remove the non mean or std columns dim 10299x68
colnames(sub.data) <- c("Subject", "Activity", as.vector(features.names[features.idx])) 

## 3. Uses descriptive activity names to name the activities in the data set
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
sub.data$Activity<-as.factor(activities[match(sub.data$Activity, activities[,1]),2])

## 4.Appropriately labels the data set with descriptive variable names.
names(sub.data) <- gsub("\\()", "", names(sub.data))
names(sub.data) <- gsub("^t", "time", names(sub.data))
names(sub.data) <- gsub("^f", "frequence", names(sub.data))
names(sub.data) <- gsub("-mean", "Mean", names(sub.data))
names(sub.data) <- gsub("-std", "Std", names(sub.data))
names(sub.data)<-gsub("Acc", "Accelerometer", names(sub.data))
names(sub.data)<-gsub("Gyro", "Gyroscope", names(sub.data))
names(sub.data)<-gsub("BodyBody", "Body", names(sub.data))
names(sub.data)<-gsub("Mag", "Magnitude", names(sub.data))

## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#group by subject and activity, then summarise using "mean" function
group.sub.data<-sub.data%>% #dim 180x68
  group_by(Subject, Activity)%>%
  summarise_each(funs(mean))%>%
  #print()

#write table into file
write.table(group.sub.data, file="./data/tidy.data.txt", sep=",",row.names=FALSE)
  

