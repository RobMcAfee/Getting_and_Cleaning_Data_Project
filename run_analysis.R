# run_analysis.R
# 
# Rob McAfee
# Aug 2015
# Project for Getting and Cleaning Data

##############################################################################################
##  Initial Setup: Download data files if necessary.            
##############################################################################################

# set the current working directory to the project directory.  
# change as neeeded to match your project directory
# or remove the line to use the current working directory.
setwd("~/Rob/Coursera/Getting_and_Cleaning_Data/project")

# set the data subdirectory path
dataPath <- file.path("./data")

# create the data subdirectory if it doesn't exist.
if(!file.exists(dataPath)){dir.create(dataPath)}

# if the zip archive with the data files doesn't exist already, download it 
zipfileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfileDownload <- file.path(dataPath, "UCHARDataset.zip")
if(!file.exists(zipfileDownload)) {download.file(zipfileURL,destfile=zipfileDownload)}

# Unzip all the files. They will be placed in the "/UCI HAR Dataset"
# subdirectory of the data subdirectory this will overwrite any data files that
# were previously unzipped
unzip(zipfile=zipfileDownload,exdir=dataPath)
UCI_HAR_dataPath <- file.path(dataPath, "UCI HAR Dataset")

##############################################################################################
##  Requirement 1: Merge the training and the test sets to create one data set.
##  Requirement 3: Uses descriptive activity names to name the activities in the data set
##  Requirement 4: Appropriately labels the data set with descriptive variable names.
##
##  I found it easier to do these requirements together during the processing the features,
##  subject identifier, and activity data
##############################################################################################

### Process feature data ###

  # read in the feature value files
X_test <- read.table(file.path(UCI_HAR_dataPath, "test/X_test.txt"), header = FALSE)
X_train <- read.table(file.path(UCI_HAR_dataPath, "train/X_train.txt"), header = FALSE)

  # combine the feature value files
  # important to note that X_test is listed first, then X_train
data.features <- rbind(X_test, X_train)  

  # remove X_test and X_train.  They won't be needed and it's good to delete objects 
  # from memory that are no longer needed
rm(X_test)
rm(X_train)

  # add the column names 
feature_names <- read.table(file.path(UCI_HAR_dataPath, "features.txt"), header = FALSE)
names(data.features) <- feature_names[,2]

### Process subject identifier data ###

  # Read in the Subject value files
subject_test <- read.table(file.path(UCI_HAR_dataPath, "test/subject_test.txt"), header = FALSE)
subject_train <- read.table(file.path(UCI_HAR_dataPath, "train/subject_train.txt"), header = FALSE)

  # combine them into a single column data table
  # important to note that subject_test is listed first, then subject_train to match order
  # feature rows were combined
data.subject <- rbind(subject_test, subject_train)

  # remove subject_test and subject_train from memory.
rm(subject_test)
rm(subject_train)

  # name the column "Subject"
names(data.subject) <- c("Subject")

### Process the activity data ###

  # Read in the Activity value files
Y_test <- read.table(file.path(UCI_HAR_dataPath, "test/Y_test.txt"), header = FALSE)
Y_train <- read.table(file.path(UCI_HAR_dataPath, "train/Y_train.txt"), header = FALSE)

  # combine the feature value files
  # important to note that Y_test is listed first, then Y_train to match order
  # other data were combined
data.activity <- rbind(Y_test, Y_train) 

  # remove Y_test and Y_train from memory.
rm(Y_test)
rm(Y_train)

  # name the column "ActivityCode"
names(data.activity) <- c("ActivityCode")

### Add the activity labels (for requirement 3) ###
  # Read in the Activity labels file
ActivityLabels <- read.table(file.path(UCI_HAR_dataPath, "activity_labels.txt"), header = FALSE)

  # name the columns "ActivityCode" and "Activity"
names(ActivityLabels) <- c("ActivityCode", "Activity")

  # merge the Activity Labels 
data.activity <- merge(data.activity, ActivityLabels, by="ActivityCode", all.x = T)

### Combine all the data ###
UCI_HAR_data <- cbind(data.subject, data.activity, data.features)



### Subset the data to only keep the feature columns with mean() or std() as part of the name
FeatureNamesToKeep <- feature_names$V2[grep("mean\\(\\)|std\\(\\)", feature_names$V2)]
UCI_HAR_data <- subset(UCI_HAR_data, select = c("Subject", "ActivityCode", "Activity", 
                                                as.character(FeatureNamesToKeep)))


# Read in the Activity labels file
ActivityLabels <- read.table(file.path(UCI_HAR_dataPath, "activity_labels.txt"), header = FALSE)

# name the columns "ActivityCode" and "Activity"
names(ActivityLabels) <- c("ActivityCode", "Activity")

# merge the Activity Labels 
data.activity <- merge(data.activity, ActivityLabels, by="ActivityCode", all.x = T)
