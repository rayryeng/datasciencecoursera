# Set working directory
# Remove when committing to repo
#setwd("C:/Users/Ray/Dropbox/Course Material/Data Science Specialization - Coursera/Getting and Cleaning Data - John Hopkins School for Public Health/Programming Assignment")

# Load in all necessary data
## Activity Labels
activityLabels <- read.table("./data/activity_labels.txt", 
                             col.names = c("Activity ID", "Activity"))

## Feature labels per column of a feature vector
featureLabels <- read.table("./data/features.txt", 
                            col.names = c("Column", "Feature Name"))

## Training and Test subject numbers
# Each row specifies an observation made by a particular
# subject enumerated in an ID number (from 1 - 30)
subjectTrainNumbers <- read.table("./data/train/subject_train.txt", 
                                  col.names = c("Subject Number"))
subjectTestNumbers <- read.table("./data/test/subject_test.txt", 
                                 col.names = c("Subject Number"))

## Extract activity IDs per observation
# With subjectTrainNumbers and subjectTestNumbers, for
# each subject, they performed a particular action enumerated
# between 1 - 6.  Each number should be replaced with
# the particular action they are performing
# Consult activityLabels for this lookup
subjectTrainActivity <- read.table("./data/train/y_train.txt", col.names = "Activity ID")                                  
subjectTestActivity <- read.table("./data/test/y_test.txt", col.names = "Activity ID")

# Extract the observations per subject per activity
# With subjectTrainActivity and subjectTestActivity,
# for each kind of action the particular subject is doing,
# these are the observation vectors that result
subjectTrainFeatureVectors <- read.table("./data/train/X_train.txt")
subjectTestFeatureVectors <- read.table("./data/test/X_test.txt")

# Cast to a data frame for each, and assign each column a meaningful name
actionLabels <- as.character(featureLabels[,2])
subjectTrainFeatures <- data.frame(subjectTrainFeatureVectors)
subjectTestFeatures <- data.frame(subjectTestFeatureVectors)
names(subjectTrainFeatures) <- actionLabels
names(subjectTestFeatures) <- actionLabels

# Look at the features and convert to a character vector
# Use regex to extract those locations that end in either -mean()
# or -std()
locationsMean <- grep("mean\\(\\)$", actionLabels)
locationsStd <- grep("std\\(\\)$", actionLabels)

# Concatenate into one large index vector
locationsFinal <- c(locationsMean, locationsStd)

# Place the subject number and the activity that they're doing at the beginning
# of each data frame
activityVector <- as.factor(activityLabels[,2])
subjectTrainVector <- as.numeric(subjectTrainActivity[[1]])
subjectTestVector <- as.numeric(subjectTestActivity[[1]])

# This completes Step #3
subjectTrainFinalColumn <- data.frame(Activity=activityVector[subjectTrainVector])
subjectTestFinalColumn <- data.frame(Activity=activityVector[subjectTestVector])

# This completes Step #4
frameTraining <- cbind(subjectTrainNumbers, subjectTrainActivity, subjectTrainFinalColumn, subjectTrainFeatures)
frameTest <- cbind(subjectTestNumbers, subjectTestActivity, subjectTestFinalColumn, subjectTestFeatures)

# Now extract the columns that have mean() and std() only
# This completes Step #2 - mean() columns first followed by std()
# Note: We offset the locationsFinal vector by 3 as we are placing
# 3 new columns before the features themselves
frameTrainingFinal <- frameTraining[,c(1,2,3,locationsFinal + 3)]
frameTestFinal <- frameTest[,c(1,2,3,locationsFinal + 3)]

# All we have to do now is merge the training and test datasets together
# Simply place one data frame on top of another...
mergedFrameBefore <- rbind(frameTrainingFinal, frameTestFinal)
# Then sort based on subject number
# mergedFrame contains the processing steps from 1 - 4
mergedFrame <- mergedFrameBefore[order(mergedFrameBefore$Subject.Number),]

##### Step #5 - This is going to look ugly because I haven't covered the apply functions
# in the other course yet so I'm gonna go with what I know so far

# Obtain total number of subjects
numSubjects <- max(mergedFrame$Subject.Number)
# Obtain total number of actions
numActions <- max(mergedFrame$Activity.ID)

# Create empty data frame
finalFrame <- data.frame()

# For each subject...
for (i in 1 : numSubjects) {
  # For each action...
  for (j in 1 : numActions) {
    # Obtain all data for subject i and action j
    dat <- mergedFrame[mergedFrame$Subject.Number == i & mergedFrame$Activity.ID == j, ]
    # Obtain first three columns to be placed in data frame
    firstThree <- dat[1,1:3]
    # Obtain the rest of the columns for all of the rows
    restColumns <- dat[,c(-1,-2,-3)]
    
    # Build each row one at a time with the mean of each subject for each activity
    # for each part of the feature vector
    # ****
    finalFrame <- rbind(finalFrame, data.frame(c(firstThree, colMeans(restColumns))))
  }
}

# Reset names - Somehow, doing the **** step above screws up the parantheses in the
# names so this is a hack to get them back to how they were before
names(finalFrame) <- names(mergedFrameBefore)

# Write final frame to file (txt and csv)
write.csv(finalFrame, file="tidyDataset_GettingCleaningData.csv")
write.table(finalFrame, file="tidyDataset_GettingCleaningData.txt")