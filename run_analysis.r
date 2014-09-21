##The working directory has been set to the folder that contains
##both train and test folders.  

##testPath object contains directory to 'test' folder. Already initialized
##prior to submission of assignment.  
 
##trainPath object contains directory to 'train' folder.  Already initialized
##prior to submission of assignment.

##originalPath object contains directory to the UCI HAR Data set folder.
##Already initialized prior to submission of assignment. 

##Question 1 asks users to read in the data from the UCI HAR Data folder and combine
##test and train data sets.  Reading the README.txt file provided in the UCI HAR folder
## 'sets' are determined to be the "X_train" and "X_test" .txt files.

##This section of code details the pathing and the extraction of subject, y, and x related files
##and the combination of the test and train sets.

##Set working directory path to 'test' folder to read in data frames for
##'test' data set.  Each file is appropriately named for the .txt file
## they were taken from.  

##Name objects 'yTrain','yTest','testSubject','trainSubject' prior to combining data sets to avoid difficulty 
##unneccessary complications later on.

setwd(testPath)
testFiles<-list.files(testPath,pattern="*.txt",full.names=T,recursive=FALSE)

testSubject<-read.table(testFiles[1])
colnames(testSubject)<-"Subject"

xTest<-read.table(testFiles[2])


yTest<-read.table(testFiles[3])
colnames(yTest)<-"Activity"


##Set working directory path to 'train' folder to read in data frames for
##'train' data set.  Each file is appropriately named for the .txt file
## they were taken from. 

setwd(trainPath)
trainFiles<-list.files(trainPath,pattern="*.txt",full.names=T,recursive=FALSE)

trainSubject<-read.table(trainFiles[1])

colnames(trainSubject)<-"Subject"

xTrain<-read.table(trainFiles[2])

yTrain<-read.table(trainFiles[3])

colnames(yTrain)<-"Activity"

##After reading in all data sets provided by both the 'test' and 'train'
##folders,we combine the test and the train data sets into one.

mergedXData<-rbind(xTrain,xTest)


##End Question 1

##Question 2 requires users to extract standard deviation and means from the 
##combined data set acquired from Question 1.  The following section of code
##pertains to answering Question 2. Should not that all 


##Return to the original working directory to name 
setwd(originalPath)

##Read in .txt file for naming purposes for x 'test' and 'train' columns
features<-read.table("features.txt")


##Initialize keyphrase objects that will be used to find mean and standard
##deviation elements in 'features' object.

seekerSTD<-"std"
seekerMEAN<-"mean"

##The following will return a logical vector that will lead us to the index
##locations of STD and Means in features


keeperMEAN<-grepl(seekerMEAN,features[,2])
keeperSTD<-grepl(seekerSTD,features[,2])

##Subsetting the 'features' object will give us a dataframe with 2
##columns; column 1 will indicate which columns we need to reference
##in the merged 'test' and 'train' data.

meanFinal<-subset(features,keeperMEAN)
STDFinal<-subset(features,keeperSTD)

meanXData<-mergedXData[,meanFinal[,1]]
STDXData<-mergedXData[,STDFinal[,1]]

##End Question 2


##Question 3 asks us to associate the numeric values of the y 'test' and 'train' data 
##with their appropriate "WALKING", "STANDING", etc. values.  

mergedYData<-rbind(yTrain,yTest)

activityLabels<-read.table("activity_labels.txt")
match(activityLabels$V1,mergedYData)

mergedYData$Activity.label<-activityLabels$V2[match(mergedYData$Activity,activityLabels$V1)]

##End Question 3

##I am interpretting Question 4 as follows: Combine the data set from Question 3, with the entirety
##of the data set of 'train' and 'test' for x, and ensure the appropriate label names for y, x, and
##subject.  

##Before combining all data sets, ensure that each column for each data frame is appropriately named

filteredYData<-data.frame(mergedYData$Activity.label)
names(filteredYData)<-"Activity"
colnames(mergedXData)<-features[,2]
mergedSubject<-rbind(trainSubject,testSubject)

##Combine all data sets utilizing 'cbind()' function

mergedDataSet<-cbind(mergedSubject,filteredYData,mergedXData)

##End Question 4

##I am interpretting Question 5 as follows: Utilizing the data set acquired from 
##Question 4, determine the average of each activity for each subject.  Effectively:
##go to the subject, take each of their activities, find the average of each.  

##Will need to use library "dplyr"

library(dplyr)

tidyDataSet<-ddply(mergedDataSet, .(Subject,Activity),numcolwise(mean))

write.table(tidyDataSet,"TidyData.txt",row.names=FALSE)
