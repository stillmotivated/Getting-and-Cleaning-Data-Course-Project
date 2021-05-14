library(stringr)
library(dplyr)
# Setting the working direktory
setwd("C:/Daten/CP intern/Coursera/GettingAndCleaningData/Final Project")

# Reading X_train data into R and checking dimensions

X_train <- read.delim(file = "C:/Daten/CP intern/Coursera/GettingAndCleaningData/Final Project/UCI HAR Dataset/train/X_train.txt",
                      header = FALSE, sep = "")
dim(X_train)

# Reading X_test data into R and checking dimensions
X_test <- read.delim(file = "C:/Daten/CP intern/Coursera/GettingAndCleaningData/Final Project/UCI HAR Dataset/test/X_test.txt",
                     header = FALSE, sep = "")
dim(X_test)

# Merging X_train & X_test, both data sets have the same number of variables, described in the file 'features.txt'
X_merged <- as.data.frame(rbind(X_train, X_test))
dim(X_merged)

################################################################################
# Reading variable names into R (features file) and checking dimensions
columnnames <- read.delim(file = "C:/Daten/CP intern/Coursera/GettingAndCleaningData/Final Project/UCI HAR Dataset/features.txt",
                          header = FALSE)
dim(columnnames)
# Cleaning variable names
# Converting columnnames to a vector
columnnamesvector <- as.vector(columnnames$V1)
## Splitting number and name
## The result is a list
columnnameslist <- strsplit(x = columnnamesvector, split = "^[0-9]+")

## We need second element from the list
secondElemennt <- function(x){x[2]}
columnnames <- sapply(X = columnnameslist, FUN = secondElemennt)
# Removing white spaces
columnnamesclean <- str_trim(columnnames)

# Naming columns in merged data set X_merged with columnnamesclean
# Appropriately labeling the data set with descriptive variable names
names(X_merged) <- columnnamesclean
################################################################################

# Extracting only the measurements on the mean and standard deviation for each measurement
# 86 columns left
X_mergedSelection <- X_merged[,grepl("[Mm]ean|[Ss]td", colnames(X_merged))]

################################################################################

# Reading y_train data into R and checking dimension
y_train <- read.delim(file = "C:/Daten/CP intern/Coursera/GettingAndCleaningData/Final Project/UCI HAR Dataset/train/y_train.txt",
                      header = FALSE)

dim(y_train)

# Reading y_test data into R and checking dimension
y_test <- read.delim(file = "C:/Daten/CP intern/Coursera/GettingAndCleaningData/Final Project/UCI HAR Dataset/test/y_test.txt",
                     header = FALSE)
dim(y_test)

# Merging y_train and y_test
y_merged <- as.data.frame(rbind(y_train, y_test))
dim(y_merged)

# Merging X_merged and y_merged and renaming the column from y_merged from V1 to 'Activity'
Xy_merged <- as.data.frame(cbind(y_merged, X_mergedSelection))  %>% rename(Activity = V1)

# Reading subject_train.txt and checking dimension
subject_train <- read.delim(file = "C:/Daten/CP intern/Coursera/GettingAndCleaningData/Final Project/UCI HAR Dataset/train/subject_train.txt",
                            header = FALSE)
dim(subject_train)

# Reading ssubject_test.txt and checking dimension
subject_test <- read.delim(file = "C:/Daten/CP intern/Coursera/GettingAndCleaningData/Final Project/UCI HAR Dataset/test/subject_test.txt",
                           header = FALSE)
dim(subject_test)

# Merging subject_train and subject_test
subject_merged <- as.data.frame(rbind(subject_train, subject_test))
dim(subject_merged)

# Merging subject_merged and Xy_merged
XySubject_merged <- as.data.frame(cbind(subject_merged, Xy_merged))  %>% rename(Subject = V1)

# Reading activity_labelx.txt
activity_labels <- read.delim(file = "C:/Daten/CP intern/Coursera/GettingAndCleaningData/Final Project/UCI HAR Dataset/activity_labels.txt",
                              header = FALSE)

# Cleaning activity_labels
# Converting activity_labels to a vector
ActivityLabelsVector <- as.vector(activity_labels$V1)
## Splitting number and name
## The result is a list
ActivityLabelList <- strsplit(x = ActivityLabelsVector, split = "^[0-9]+")

## We need second element from the list
secondElemennt <- function(x){x[2]}
activity_labels <- sapply(X = ActivityLabelList, FUN = secondElemennt)
# Removing white spaces
activity_labels_clean <- data.frame(Activity = c(1:6), Activity_label = str_trim(activity_labels))

# Using descriptive activity names to name the activities in the data set - Xy_merged
Xy_merged2 <- XySubject_merged %>% left_join(activity_labels_clean) %>% select(Activity_label, Subject, names(X_mergedSelection))

# Checking if we have 30 subjects
sort(unique(XySubject_merged$Subject))

# Calculating the average of each variable for each activity and each subject
AVG_Calculation <- Xy_merged2 %>% group_by(Subject, Activity_label) %>% 
        summarise_at(names(X_mergedSelection), mean, na.rm = TRUE)





