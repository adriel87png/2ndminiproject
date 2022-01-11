library(data.table)
library(dplyr)
library(stringr)
#1

#a.)Merges the training and the test sets to create one data set

#Get data from text files

#From train folder

subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
#head(subjectTrain)

yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
#head(yTrain)

xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
#head(xTrain)


#From test folder

subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
#head(subjectTest)

yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
#head(yTest)

xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
#head(xTest)

#from main folder
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")[2]
#head(activityLabels)

#only selecting to the second column for the naming convention
features <- read.table("UCI HAR Dataset/features.txt")[,2]
#head(features)

#y contains activity and x contains features
#bind them together by row
subject <- rbind(subjectTrain, subjectTest)
y <- rbind(yTrain, yTest)
x <- rbind(xTrain, xTest)



#as mentioned above, therefore renamed as such
#features has about 563, so it matches for the column names of x
colnames(x) <- features
colnames(y) <- "Activity"
colnames(subject) <- "Subject"

combinedData <- cbind(subject, y, x)

#head(combinedData)
#ncol(combinedData)
#ncol(combinedData)

#.b.)  Extracts only the measurements on the mean and 
#standard deviation for each measurement

#Get columns with standard deviation and mean using grepl
combinedDataSD <- combinedData[,grepl("std()", colnames(combinedData), ignore.case = TRUE)]
#ncol(combinedDataSD) #33
combinedDataMEAN <- combinedData[,grepl("mean()", colnames(combinedData), ignore.case = TRUE)]
#ncol(combinedDataMEAN) #53

#combine both of the findings with cbind
combinedDataSDMEAN <- cbind(combinedDataSD, combinedDataMEAN)

#combinedData2 will be the updated combinedData with only 88 columns left
combinedData2 <- cbind(subject, y, combinedDataSDMEAN)

#nrow(combinedData2)
#ncol(combinedData2)
#head(combinedData2)

#.c.) Uses descriptive activity names 
#to name the activities in the dataset

#activity labels are stored in a vector to properly distribute them later
activityNameVector <- activityLabels$V2

#set activity names using this loop
#set to up to 6 since there are only 6
#this changes all the names for activities
for (i in 1:6){
  combinedData2$Activity[combinedData2$Activity == i] <- activityNameVector[i]
}


#View(combinedData2)
#head(combinedData2)

#d.)
#Names for the variables are based from features_info.txt
#gsub to change substrings
#this is to change the column names
#This is run in chornological order to avoid any weird replacements
#i.e. Doubling of changes
#DONT RUN EACH OF THESE LINES MORE THAN ONCE
names(combinedData2) <- gsub("-X", "Axis=X", names(combinedData2))
names(combinedData2) <- gsub("-Y", "Axis=Y", names(combinedData2))
names(combinedData2) <- gsub("-Z", "Axis=Z", names(combinedData2))
names(combinedData2) <- gsub("Acc", "Accelerometer", names(combinedData2))
names(combinedData2) <- gsub("Gyro", "Gyroscope", names(combinedData2))
names(combinedData2) <- gsub("Mag", "Magnitude", names(combinedData2))
names(combinedData2) <- gsub("std", "StandardDeviation", names(combinedData2))
names(combinedData2) <- gsub("Freq", "Frequency", names(combinedData2))
names(combinedData2) <- gsub("-", "", names(combinedData2))
names(combinedData2) <- gsub("()", "", names(combinedData2))
names(combinedData2) <- gsub("tBody", "TimeBody", names(combinedData2))
names(combinedData2) <- gsub("fBody", "FrequencyBody", names(combinedData2))
names(combinedData2) <- gsub("BodyBody", "Body", names(combinedData2))
names(combinedData2) <- gsub("tgravity", "TimeGravity", names(combinedData2))
names(combinedData2) <- gsub("angle", "Angle", names(combinedData2))
names(combinedData2) <- gsub("gravity", "Gravity", names(combinedData2))
names(combinedData2) <- gsub("mean", "Mean", names(combinedData2))


#e.) From the data set in step 4, create a second, 
#independent tidy data set with the average of each variable
#for each activity and each subject.
