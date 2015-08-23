# Getting and Cleaning Data Project Codebook 

This Codebook details the data used in the project for the **_Getting and Cleaning Data_** Coursera course.
Topics covered here include:
* Description of the raw source data
* Data transformations performed 
* Description of the tidy dataset produced 

## Raw Source Data
### Background information
The source data is from a study that collected measure from the accelerometers of participants that were performing a variety of activities while wearing the Samsung Galaxy S smartphone. A full description of the study is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### Raw data files
The data files are available as a zip archive that the run_analysis.R script will download from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The archive will then be unzipped into a subdirectory named **/data**.  The subdirectory will be created if 
it does note exist.  The unzipped files will be placed into a subdirectory named **/data/UCI HAR Dataset**.
The complete listing of unzipped files is:

```
 [1] "activity_labels.txt"                         
 [2] "features.txt"                                
 [3] "features_info.txt"                           
 [4] "README.txt"                                  
 [5] "test/Inertial Signals/body_acc_x_test.txt"   
 [6] "test/Inertial Signals/body_acc_y_test.txt"   
 [7] "test/Inertial Signals/body_acc_z_test.txt"   
 [8] "test/Inertial Signals/body_gyro_x_test.txt"  
 [9] "test/Inertial Signals/body_gyro_y_test.txt"  
[10] "test/Inertial Signals/body_gyro_z_test.txt"  
[11] "test/Inertial Signals/total_acc_x_test.txt"  
[12] "test/Inertial Signals/total_acc_y_test.txt"  
[13] "test/Inertial Signals/total_acc_z_test.txt"  
[14] "test/subject_test.txt"                       
[15] "test/X_test.txt"                             
[16] "test/y_test.txt"                             
[17] "train/Inertial Signals/body_acc_x_train.txt" 
[18] "train/Inertial Signals/body_acc_y_train.txt" 
[19] "train/Inertial Signals/body_acc_z_train.txt" 
[20] "train/Inertial Signals/body_gyro_x_train.txt"
[21] "train/Inertial Signals/body_gyro_y_train.txt"
[22] "train/Inertial Signals/body_gyro_z_train.txt"
[23] "train/Inertial Signals/total_acc_x_train.txt"
[24] "train/Inertial Signals/total_acc_y_train.txt"
[25] "train/Inertial Signals/total_acc_z_train.txt"
[26] "train/subject_train.txt"                     
[27] "train/X_train.txt"                           
[28] "train/y_train.txt"    
```
Of these files, the only ones that are of interest for this project are:

```
        "README.txt"              ->  Description of UCI HAR Dataset files
        
        "test/X_test.txt"         ->  Feature values.  These are measures summarizing the 
        "train/X_train.txt"           subject data and include mean, std, cor, and other 
                                      descriptive measures detailed in features_info.txt
 
        "features.txt"            ->  Feature variable names
        "features_info.txt"       ->  Description of Features
        
        "test/subject_test.txt"   ->  Subject Identifiers
        "train/subject_train.txt"
        
        "test/Y_test.txt"         ->  Activity Identifiers
        "train/Y_train.txt"
        "activity_labels.txt"     ->  Labels for Activity Identifiers
```
## Data Transformations

### Process the features data
There are 561 columns of feature measures.  The values for all of these measures are standardized and range from -1 to +1.  A complete listing of the features names is in "features_info.txt".  The features will make up most of the columns in the combined data.

The steps followed by the script to process the features data are:

1. X_test and X_train datasets are read in and appended by the rbind() function to create the
   data.features data frame.
2. The names from features.txt are read in and then added as the column names for the features.

### Process the subject identity data
There are 30 subjects in the study and each is identified with an integer value from 1 to 30.  Each row of the combined data should include a subject value to indicate which of the 30 partipants the observation is for.

The steps followed by the script to process the subject identity data are:

1. subject_test.tx and subject_train.txt are appended by the rbind() function to create the
   data.activity data frame.
2. The name "ActivityCode" is added to the single column of subject identities

### Process the activty data
There are 6 activities in the study.  They are:
Acvity | Activity 
 Code  |
-------|----------
   1   | WALKING
   2   | WALKING_UPSTAIRS
   3   | WALKING_DOWNSTAIRS
   4   | SITTING
   5   | STANDING
   6   | LAYING
-------|----------   

Each row of fhe combined data should include an activity code and activity value to indicate which of the activities the observation is for.

The steps followed by the script to process the activity identity data are:

1. Y_test.tx and Y_train.txt are appended by the rbind() function to create the
   data.activty data frame.
2. The name "Activity Code" is added to the single column of subject identities

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
