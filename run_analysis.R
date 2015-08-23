# run_analysis.R
# 
# Rob McAfee
# Aug 2015
# Project for Getting and Cleaning Data

# set the current directory to the project directory.  
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

# The files of interest in the "UCI HAR Dataset" subdirectory are: 
#       "README.txt"              ->  Description of UCI HAR Dataset files
#       
#       "test/X_test.txt"         ->  Feature values.  These are measures summarizing the 
#       "train/X_train.txt"           subject data and include mean, std, cor, and other 
#                                     descriptive measures detailed in features_info.txt
#       "features.txt"            ->  Feature variable names
#       "features_info.txt"       ->  Description of Features
#       
#       "test/subject_test.txt"   ->  Subject Identifiers
#       "train/subject_train.txt"
#       
#       "test/y_test.txt"         ->  Activity Identifiers
#       "train/y_train.txt"
#       "activity_labels.txt"     ->  Labels for Activity Identifiers

### Create a data table with the feature values

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

### Create a data table with the subject identifiers

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

### Create a data table with the activity identifiers

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

# Read in the Activity labels file
ActivityLabels <- read.table(file.path(UCI_HAR_dataPath, "activity_labels.txt"), header = FALSE)

# name the columns "ActivityCode" and "Activity"
names(ActivityLabels) <- c("ActivityCode", "Activity")

# merge the Activity Labels 
data.activity <- merge(data.activity, ActivityLabels, by="ActivityCode", all.x = T)

### Combine all the data  
UCI_HAR_data <- cbind(data.subject, data.activity, data.features)

### Subset the data to only keep the feature columns with mean() or std() as part of the name
FeatureNamesToKeep <- feature_names$V2[grep("mean\\(\\)|std\\(\\)", feature_names$V2)]
UCI_HAR_data <- subset(UCI_HAR_data, select = c("Subject", "ActivityCode", "Activity", 
                                                as.character(FeatureNamesToKeep)))

