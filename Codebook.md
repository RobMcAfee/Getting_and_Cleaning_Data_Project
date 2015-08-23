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

1. X_test and X_train datasets are read in and appended to create the features columns of data.
2. The names from features.txt are read in and then added as the column names for the features.

### Process the subject identity data
There are 30 subjects in the study and each is identified with an integer value from 1 to 30.  Each row of the combined data should include a subject value to indicate which of the 30 partipants the observation is for.

The steps followed by the script to process the subject identity data are:

1. subject_test.tx and subject_train.txt are appended to create the column of subject identities.
2. The name "ActivityCode" is added to the single column of subject identities

### Process the activty data
There are 6 activities in the study.  They are:
```
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
```
Each row of the combined data should include an activity code and activity value to indicate which of the activities the observation is for.

The steps followed by the script to process the activity identity data are:

1. Y_test.tx and Y_train.txt are appended to create the activity code column.
2. The name "ActivityCode" is added to the single column of activity codes.
3. Eventually the activity_labels.txt is read in and merged by ActivityCode to match the activity value with the appropriate activity code.

### Combine and then subset the data
The subject, activity, and features data are combined and then subset to keep only the feature data that are for mean or standard deviations.  This is indicated by a "mean()" or "std()" at the end of the feature column name.  The mean and std feature columns, along with the Subject, ActivityCode, and Activity columns, create a combined data set of 10299 observations and 69 columns.

### Add descriptive names

After expanding the naming scheme used by the source data to have more descriptive names, The complete list of columns is:
```
 [1] "ActivityCode"                                   "Subject"                                       
 [3] "timeBodyAccelerometer-mean()-X"                 "timeBodyAccelerometer-mean()-Y"                
 [5] "timeBodyAccelerometer-mean()-Z"                 "timeBodyAccelerometer-std()-X"                 
 [7] "timeBodyAccelerometer-std()-Y"                  "timeBodyAccelerometer-std()-Z"                 
 [9] "timeGravityAccelerometer-mean()-X"              "timeGravityAccelerometer-mean()-Y"             
[11] "timeGravityAccelerometer-mean()-Z"              "timeGravityAccelerometer-std()-X"              
[13] "timeGravityAccelerometer-std()-Y"               "timeGravityAccelerometer-std()-Z"              
[15] "timeBodyAccelerometerJerk-mean()-X"             "timeBodyAccelerometerJerk-mean()-Y"            
[17] "timeBodyAccelerometerJerk-mean()-Z"             "timeBodyAccelerometerJerk-std()-X"             
[19] "timeBodyAccelerometerJerk-std()-Y"              "timeBodyAccelerometerJerk-std()-Z"             
[21] "timeBodyGyroscope-mean()-X"                     "timeBodyGyroscope-mean()-Y"                    
[23] "timeBodyGyroscope-mean()-Z"                     "timeBodyGyroscope-std()-X"                     
[25] "timeBodyGyroscope-std()-Y"                      "timeBodyGyroscope-std()-Z"                     
[27] "timeBodyGyroscopeJerk-mean()-X"                 "timeBodyGyroscopeJerk-mean()-Y"                
[29] "timeBodyGyroscopeJerk-mean()-Z"                 "timeBodyGyroscopeJerk-std()-X"                 
[31] "timeBodyGyroscopeJerk-std()-Y"                  "timeBodyGyroscopeJerk-std()-Z"                 
[33] "timeBodyAccelerometerMagnitude-mean()"          "timeBodyAccelerometerMagnitude-std()"          
[35] "timeGravityAccelerometerMagnitude-mean()"       "timeGravityAccelerometerMagnitude-std()"       
[37] "timeBodyAccelerometerJerkMagnitude-mean()"      "timeBodyAccelerometerJerkMagnitude-std()"      
[39] "timeBodyGyroscopeMagnitude-mean()"              "timeBodyGyroscopeMagnitude-std()"              
[41] "timeBodyGyroscopeJerkMagnitude-mean()"          "timeBodyGyroscopeJerkMagnitude-std()"          
[43] "frequencyBodyAccelerometer-mean()-X"            "frequencyBodyAccelerometer-mean()-Y"           
[45] "frequencyBodyAccelerometer-mean()-Z"            "frequencyBodyAccelerometer-std()-X"            
[47] "frequencyBodyAccelerometer-std()-Y"             "frequencyBodyAccelerometer-std()-Z"            
[49] "frequencyBodyAccelerometerJerk-mean()-X"        "frequencyBodyAccelerometerJerk-mean()-Y"       
[51] "frequencyBodyAccelerometerJerk-mean()-Z"        "frequencyBodyAccelerometerJerk-std()-X"        
[53] "frequencyBodyAccelerometerJerk-std()-Y"         "frequencyBodyAccelerometerJerk-std()-Z"        
[55] "frequencyBodyGyroscope-mean()-X"                "frequencyBodyGyroscope-mean()-Y"               
[57] "frequencyBodyGyroscope-mean()-Z"                "frequencyBodyGyroscope-std()-X"                
[59] "frequencyBodyGyroscope-std()-Y"                 "frequencyBodyGyroscope-std()-Z"                
[61] "frequencyBodyAccelerometerMagnitude-mean()"     "frequencyBodyAccelerometerMagnitude-std()"     
[63] "frequencyBodyAccelerometerJerkMagnitude-mean()" "frequencyBodyAccelerometerJerkMagnitude-std()" 
[65] "frequencyBodyGyroscopeMagnitude-mean()"         "frequencyBodyGyroscopeMagnitude-std()"         
[67] "frequencyBodyGyroscopeJerkMagnitude-mean()"     "frequencyBodyGyroscopeJerkMagnitude-std()"     
[69] "Activity" 
```
Refer to the README.txt and features_info.txt files in the source data for more information about the features.

## Description of the tidy data set

The tidy data set is named **_tidydata.txt_** and consists of:

* 180 observations ordered by Subject and Activity with each observation containing the mean values for 66 features.
* The Subject column has integer values from 1 to 30 and represent which of the 30 study participants the observation is about
* The Activity and Activity Code columns indicate the activity.  The values are indicated in this table:
```
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
```
* The mean feature values range from -1 to 1 and are unitless.  The complete list of the 66 feature columns are:
```
[1] "timeBodyAccelerometer-mean()-X"                 "timeBodyAccelerometer-mean()-Y"                
 [3] "timeBodyAccelerometer-mean()-Z"                 "timeBodyAccelerometer-std()-X"                 
 [5] "timeBodyAccelerometer-std()-Y"                  "timeBodyAccelerometer-std()-Z"                 
 [7] "timeGravityAccelerometer-mean()-X"              "timeGravityAccelerometer-mean()-Y"             
 [9] "timeGravityAccelerometer-mean()-Z"              "timeGravityAccelerometer-std()-X"              
[11] "timeGravityAccelerometer-std()-Y"               "timeGravityAccelerometer-std()-Z"              
[13] "timeBodyAccelerometerJerk-mean()-X"             "timeBodyAccelerometerJerk-mean()-Y"            
[15] "timeBodyAccelerometerJerk-mean()-Z"             "timeBodyAccelerometerJerk-std()-X"             
[17] "timeBodyAccelerometerJerk-std()-Y"              "timeBodyAccelerometerJerk-std()-Z"             
[19] "timeBodyGyroscope-mean()-X"                     "timeBodyGyroscope-mean()-Y"                    
[21] "timeBodyGyroscope-mean()-Z"                     "timeBodyGyroscope-std()-X"                     
[23] "timeBodyGyroscope-std()-Y"                      "timeBodyGyroscope-std()-Z"                     
[25] "timeBodyGyroscopeJerk-mean()-X"                 "timeBodyGyroscopeJerk-mean()-Y"                
[27] "timeBodyGyroscopeJerk-mean()-Z"                 "timeBodyGyroscopeJerk-std()-X"                 
[29] "timeBodyGyroscopeJerk-std()-Y"                  "timeBodyGyroscopeJerk-std()-Z"                 
[31] "timeBodyAccelerometerMagnitude-mean()"          "timeBodyAccelerometerMagnitude-std()"          
[33] "timeGravityAccelerometerMagnitude-mean()"       "timeGravityAccelerometerMagnitude-std()"       
[35] "timeBodyAccelerometerJerkMagnitude-mean()"      "timeBodyAccelerometerJerkMagnitude-std()"      
[37] "timeBodyGyroscopeMagnitude-mean()"              "timeBodyGyroscopeMagnitude-std()"              
[39] "timeBodyGyroscopeJerkMagnitude-mean()"          "timeBodyGyroscopeJerkMagnitude-std()"          
[41] "frequencyBodyAccelerometer-mean()-X"            "frequencyBodyAccelerometer-mean()-Y"           
[43] "frequencyBodyAccelerometer-mean()-Z"            "frequencyBodyAccelerometer-std()-X"            
[45] "frequencyBodyAccelerometer-std()-Y"             "frequencyBodyAccelerometer-std()-Z"            
[47] "frequencyBodyAccelerometerJerk-mean()-X"        "frequencyBodyAccelerometerJerk-mean()-Y"       
[49] "frequencyBodyAccelerometerJerk-mean()-Z"        "frequencyBodyAccelerometerJerk-std()-X"        
[51] "frequencyBodyAccelerometerJerk-std()-Y"         "frequencyBodyAccelerometerJerk-std()-Z"        
[53] "frequencyBodyGyroscope-mean()-X"                "frequencyBodyGyroscope-mean()-Y"               
[55] "frequencyBodyGyroscope-mean()-Z"                "frequencyBodyGyroscope-std()-X"                
[57] "frequencyBodyGyroscope-std()-Y"                 "frequencyBodyGyroscope-std()-Z"                
[59] "frequencyBodyAccelerometerMagnitude-mean()"     "frequencyBodyAccelerometerMagnitude-std()"     
[61] "frequencyBodyAccelerometerJerkMagnitude-mean()" "frequencyBodyAccelerometerJerkMagnitude-std()" 
[63] "frequencyBodyGyroscopeMagnitude-mean()"         "frequencyBodyGyroscopeMagnitude-std()"         
[65] "frequencyBodyGyroscopeJerkMagnitude-mean()"     "frequencyBodyGyroscopeJerkMagnitude-std()"     
```
Refer to the README.txt and features_info.txt files in the source data for more information about the features.

