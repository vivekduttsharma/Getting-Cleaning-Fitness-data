# Programming assignment Week-4
# Download data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip")
## Read file in tables & view to get an idea of the data
# Test dataset
datatest_X <- read.table("./Data/Dataset/UCI HAR Dataset/test/X_test.txt")
View(datatest_X)
# Test activity labels (walking ,sitting ...) against each observation
datatest_Y <- read.table("./Data/Dataset/UCI HAR Dataset/test/Y_test.txt")
View(datatest_Y) 
# Each row identifies the subject who performed the activity
datatest_sub <- read.table("./Data/Dataset/UCI HAR Dataset/test/subject_test.txt")
View(datatest_sub)
# Training dataset
datatrain_X <- read.table("./Data/Dataset/UCI HAR Dataset/train/X_train.txt")
View(datatrain_X)
# Test activity labels (walking ,sitting ...) against each observation
datatrain_Y <- read.table("./Data/Dataset/UCI HAR Dataset/train/Y_train.txt")
View(datatrain_Y)
# Each row identifies the subject who performed the activity
datatrain_sub <- read.table("./Data/Dataset/UCI HAR Dataset/train/subject_train.txt")
View(datatrain_sub)

# variables for activity measurements
data_feature <- read.table("./Data/Dataset/UCI HAR Dataset/features.txt")
View(data_feature) 

# List of activity labels
data_actlabel <- read.table("./Data/Dataset/UCI HAR Dataset/activity_labels.txt")
View(data_actlabel)

##Merge the training and the test sets to create one data set.

#Step-1 Merging test data with variable names , activity label & subject ID
library(dplyr)
library(reshape2)
X1 <- t(data_feature)
colnames(datatest_X) <- X1[2,]
datatest_X$subjectID <- datatest_sub$V1
datatest_X$activityID <- datatest_Y$V1

#Step-2 Merging train data with variable names , activity label & subject ID

colnames(datatrain_X) <- X1[2,]
datatrain_X$subjectID <- datatrain_sub$V1
datatrain_X$activityID <- datatrain_Y$V1

#Step-3 Combinig Training & Test data

train_test <- rbind(datatest_X,datatrain_X)

## Extracting only the measurements on the mean and standard deviation for each measurement.

#Step-1 - make coloumn names unique

colnames(train_test) <- make.unique(colnames(train_test))
colnames(train_test)

#Step-2 Extract varibles having mean & Standard deviation measurements

mean_sd_data <- select(train_test,contains("mean()"),contains("std()"),"activityID","subjectID")

## Uses descriptive activity names to name the activities in the data set

mean_sd_data <- mutate(mean_sd_data,Desc_activity_name = data_actlabel$V2[mean_sd_data$activityID])
# Remove variable activity ID
mean_sd_data <- select(mean_sd_data,-(activityID))

##Create a second, independent tidy data set with the average of each variable for each activity and each subject
# Step-1 melt as per Subject ID & activity name

mean_sd_datamelt <-melt(mean_sd_data,id=c("subjectID","Desc_activity_name"))

#Step-2 Dcast to get tidy data ser

tidy_data <- dcast(mean_sd_datamelt,subjectID + Desc_activity_name ~ variable,mean)




