# Getting and Cleaning Data Project

## Project Background
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The source data is from a study that collected measure from the accelerometers of participants that were performing a variety of activities while wearing the Samsung Galaxy S smartphone. A full description of the study is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data files are available as a zip archive that the run_analysis.R script will download from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Running the run_analysis.R script

The run_analysis.R script is found in this repo and will construct a tidy data set named **tidydata.txt** when run.

The script performs all the requirements in the project assignment:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To run the script:

1. Download run_analyis.R from this repo
2. Edit line 14 to contain the path for the directory you want to use for downloading the data and creating the tidy dataset.  Or comment the line to use the current working directory.
3. Run the run_analysis.R script.  It will download the zip file with the source data, unzip all the files, and create the tidydata.txt file.

For additional information about the tidydata.txt file including the transformations and description of columns, refer to the CodeBook.md file in this repo.

