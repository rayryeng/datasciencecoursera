# CodeBook.md
---

This Markdown file contains a description of the datasets that were used in this programming assignment, the steps required to obtain the final tidied up dataset and the variables that are used in representing the dataset.

---

## Introduction

This programming assignment used the data collected from the accelerometers from a Samsung Galaxy S smartphone.  30 test subjects were employed to gather various accelerometer readings while they were engaged in multiple activities.  The smartphone was tethered to each subject's waist while readings were taken.  When a subject does a particular action and at a specific time point, 562 features were used to describe each action.

The datasets can be obtained through the following link: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The datasets are part of a machine learning problem and there are separate datasets for training and test data.  As such, the purpose of this programming assignment was to take the training and test datasets and combine them into one dataset while performing tasks to clean up the data.  Specifically, only the features describing on the mean and standard deviation for each measurement were extracted.  The features were stored in separate text files for the training and test datasets.  For each observation in the training or test dataset, two other text files were used to reference which subject was wearing the smartphone and what action they were performing at that time.  The action that was performed is reference by an ID number from 1 to 6.  As such, there were only 6 possible actions performed during these tests, which were:

* Laying
* Sitting
* Standing
* Walking
* Walking downstairs
* Walking upstairs

Another text file was used as a legend to determine which action corresponded to correct ID number for that action.  Once the features for just the mean and standard deviation were extracted with the combined dataset, a final independent and tidied up dataset was created with the average of each mean and standard deviation variable for each activity that each subject was performing.  Because there are 30 subjects and there are 6 actions per subject, this yielded a total of 180 total measurements.

## Data text files used

As such, the following text files from this dataset were used when created the final tidied dataset:

* `subject_train.txt` and `subject_test.txt`: These contain the IDs of the subject that was wearing the smartphone during a particular reading for the training and test datasets.  Each row corresponds which person the readings originated from at that particular time.
* `y_train.txt` and `y_test.txt`: With reference to above, for each subject and during a particular reading, this refers to the IDs of the particular action the subject is performing at that time for the training and test datasets.
* `X_train.txt` and `X_test.txt`: With reference to above, for each subject and during a particular reading, these are the 562 features measured for the particular action at that time for the training and test datasets.
* `features.txt`: This text file contains a description of each of the 562 features measured that make up one measurement
* `activity_labels.txt`: This text file contains a legend of which activity corresponds to what activity ID.

## Variables included with tidied dataset

For each reading in the tidied dataset, there are 21 features / variables used for describing what is being obtained at this particular time.  These were:

1. `Subject.Number`: The ID of the subject that was wearing the smartphone during a reading
2. `Activity.ID`: The activity that the subject was performing - enumerated between 1 to 6
3. `Activity`: The actual activity that the subject was performed referring to the legend in `activity_labels.txt`
4. `tBodyAccMag-mean()`: The average body acceleration magnitude using the accelerometer
5. `tGravityAccMag-mean()`: The average gravity acceleration magnitude using the accelerometer
6. `tBodyAccJerkMag-mean()`: The average body jerk signal using the accelerometer
7. `tBodyGyroMag-mean()`: The average body acceleration magnitude using the gyroscope
8. `tBodyGyroJerkMag-mean()`: The average jerk signal using the gyroscope
9. `fBodyAccMag-mean()`: Signal 4 after the Fast Fourier Transform (FFT) was applied to it.
10. `fBodyBodyAccJerkMag-mean()`: Signal 6 after the FFT was applied to it
11. `fBodyBodyGyroMag-mean()`: Signal 7 after the FFT was applied to it.
12. `fBodyBodyGyroJerkMag-mean()`: Signal 8 after the FFT was applied to it
13. `tBodyAccMag-std()`: The standard deviation of the acceleration magnitude using the accelerometer
14. `tGravityAccMag-std()`: The standard deviation gravity acceleration magnitude using the accelerometer
15. `tBodyAccJerkMag-std()`: The standard devition of the body jerk signal using the accelerometer
16. `tBodyGyroMag-std()`: The standard deviation body acceleration magnitude using the gyroscope
17. `tBodyGyroJerkMag-std()`: The standard deviation jerk signal using the gyroscope
18. `fBodyAccMag-std()`: Signal 13 after the FFT was applied to it
19. `fBodyBodyAccJerkMag-std()`: Signal 15 after the FFT was applied to it
20. `fBodyBodyGyroMag-std()`: Signal 16 after the FFT was applied to it
21. `fBodyBodyGyroJerkMag-std()`: Signal 17 after the FFT was applied to it

## Summary of how the data was tidied

1. All of the files mentioned in the section on which data text files were used were read using the `R` programming language.
2. The text files were read in as tables.  In order for them to become data frames for easier processing, the tables for the features of the training and test data were converted to data frames with each of their columns assigned to the corresponding names found in `features.txt`
3. Using `y_train.txt` and `y_test.txt`, these activity numbers were used to create two new columns that contained the actual actions performed by a subject instead of the numbers with reference to `activity_labels.txt`. 
4. New temporary data frames for the training and test datasets were created that column-wise concatenated the subject ID (from `subject_train.txt` and `subject_test.txt`), the activity numbers (from Step 3) and the features (from Step 2)
5. To combine the test and training datasets into one complete data frame, the two data frames from Step 4 were concatenated row-wise and was reordered by the subject ID.
6. To obtain the final data frame, a double for loop was run so that for each subject and for each activity, all of the readings for this subject and activity were collected, the means of all of the features were computed and thus resulted in one final reading for this particular subject and activity.  As there are 30 subjects and 6 activities per subject, this results in a data frame of 180 rows and 21 columns (referring to the previous section).

## Where to get the final data frame

The data frame was exported as a text file and a CSV file if the final result is to be viewed.  The `R` code written to create this tidied dataset is available as well in the `run_analysis.R` file included in the repo.  Caution is advised here as the datasets are quite extensive and so loading in the datasets into R using the included script is a bit computationally intensive.  Nevertheless, the script file is included in this repo for the sake of completeness.
