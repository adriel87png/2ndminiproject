# 2ndminiproject
2nd mini project for Data Science (CMSC 197-2)

More in depth explanations in the code itself as comments

NOTE: The code contains a lot of ncol, Views, nrow, head, tail etc. Just commented
them out. They were used to see if the data is still in place and changes were expected

a.)Merges the training and the test sets to create one data set

  Data is read using read.table and stored into variable names such as
  -subjectTrain             -activity lavels
  -yTrain                   -features
  -xTrain
  -subjectTest
  -yTest
  -xTest
  
  The following were binded using rbind
  -subject <- subjectTrain and subjectTest (contains subject)
  -y <- yTrain and yTest (contains activity)
  -x <- xTrain and xTest (contains features)
  
  Colnames for the following were then changed
  For x, the feature names that were contained in 'features' were all set to their respective place
  
  'combinedData' contained all of the following that were rbinded, by using cbind on them
  
#.b.)  Extracts only the measurements on the mean and standard deviation for each measurement
  
  Columns that contained "std()" and "mean()" were extracted using the 'grepl'. They are saved
  in two different variables. These two were then binded by cbind as the final data set to be used
  
#.c.) Uses descriptive activity names to name the activities in the dataset
  
  Activity labels fromm the second column of the data text file were stored in a vector
  Using a loop, these were distributed into their appropriate destinations
  
#.d.) Appropriately labels the data set with descriptive variable names

  Names for the variables are based from features_info.txt. 'gsub' was used to change substrings
  in the column names
  The code  is run in chornological order to avoid any weird replacements
  Like possible Doubling of changes
  
 #.e.)  From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
 
  To be made...
