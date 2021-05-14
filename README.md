# Getting-and-Cleaning-Data-Course-Project
GitHub Directory contains just two files:
1) run_analysis.R script, containing the code
2) Codebook.Rmd, containing information about variables, created in run_analysis.R

Decription of the steps, performed in run_analysis.R script to get tidy data:

There are three types of data:
- Measurements (files X_train.txt and X_test.txt)
- Activities (files y_train.txt and y_test.txt)
- Subjects (files subject_train.txt and subject_test.txt)

Steps:
1) read measuremet data (train and test sets) and check the dimensions of the data sets.
2) merge the measuremet data sets together via rbind() to create one data set - X_merged
3) read features.txt file with the names of variables. All variables contain number and actual name.
4) clean the variable names: separate the name into two parts number and name, select just the name of the variable.
5) rename the merged data set - X_merged - with cleaned variable names. So that the data set is appropriately labeled with descriptive variable names.
6) select only the measurements on the mean and standard deviation for each measurement (=reducing number of columns)
7) read activitities data (train and test sets) and check the dimensions of the data sets.
8) merge the activitities data sets together via rbind() to create one data set - y_merged
9) merge X_merged and y_merged to one data set - Xy_merged - via cbind()
10) read subjects data (train and test sets) and check the dimensions of the data sets.
11) merge the subjects data sets together via rbind() to create one data set - subject_merged
12) merge Xy_merged with subject_merged to one data set - XySubject_merged - via cbind()
13) read activity_labels.txt file with activity names. All activities contian number and actual  activity name.
14) clean the activity_labels names: separate the name into two parts number and name. Result is a dataframe with 2 columns: 1) Number of the Activity 2) Descriptive Name of Activity
15) use descriptive activity names to name the activities in the data set - this is done via left_join (dplyr package). 
16) grouping data by subject and Activity_Label
17) Calculating mean for each variable via summarise_at() function from dplyr package

