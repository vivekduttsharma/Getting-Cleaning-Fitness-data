# Getting-Cleaning-Fitness-data
Programming assignment Getting &amp; cleaning data-Week4
run_analysis.R script file prepares tidy data from the fitness dataset.
Raw data files downloaded & corresponding data frames defined:
X_test.txt          -> datatest_X ( measurement corresponding to test data set)
Y_test.txt          -> datatest_Y ( activity ID corresponding to test data set)
subject_test.txt    -> datatest_sub( Subject ID corresponding to test data set)
X_train.txt         -> datatrain_X ( measurement corresponding to train data set)
Y_train.txt         -> datatrain_Y ( activity ID corresponding to train data set)
subject_train.txt   -> datatrain_sub( Subject ID corresponding to train data set)
features.txt        -> data_feature ( measurement names)
activity_labels.txt -> data_actlabel( activity labels)
train/test data (datatrain_X/datatest_X) are first assigned with variable/measurement names using data_feature.
train/test data are added with additional variables names "subjectID" & "activityID" using datatrain_sub/datatest_sub ; datatrain_Y/datatest_Y respectively.Result stored in "datatrain_X" / "datatest_X" data frames.
resulting data frames datatrain_X & datatest_X combined using rowbind to form single data frame train_test ( combined data with measurement names , activity ID & subject ID.
Mean & standard deviation variables are selected to form "mean_sd_data" data frame
Additional variable "Desc_activity_name" with descriptive activity label added to "mean_sd_data" using mutate function then activity ID removed from this data frame
All coloumns/varibles except "subject ID" & "Desc_activity_name" of "mean_sd_data"  arranged to form variable & value coloumns using melt function
Finall tidy data with average corresponding to each measurement for every subject ID & activity description is obtained using dcast function in resulting data frame "tidy_data"
tidy_data exported to text file "tidy_data.txt" using write.table function.
