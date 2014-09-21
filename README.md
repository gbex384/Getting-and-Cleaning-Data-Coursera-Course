Getting-and-Cleaning-Data-Coursera-Course
=========================================
The code provided in this repository was designed specifically to answer the questions pertaining
to the data set provided by the Getting and Cleaning Data Course, taught by Jeff Leek as of the
September 1st, 2014 session.  

The data set can be found in this link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The data in the .zip file contains a significant amount of data concerning the metrics of 30 different people with regards
to excercise.  

Each person in the experiment wore a sensor that recorded data from accelerometers and gyroscopes and had a series 
of pre-processed data techniques applied.  By the time we have obtained the data, these pre-processed techniques
had already been applied.  

DESCRIPTION OF ANALYSIS CODE:
The code was written in 5 separate sections, detailing the reasoning and the objectives of each section.  However, for easy
access, a description is provided below.

Section 1:
Students were asked to take the data set provided in the .zip file and merge 'training' and 'test' sets into one
massive data set.  

For clarification, students were asked to unzip the .zip file, find a .txt file denoted as "X_train" and "X_test",
read in the data provided, and then combined the two into an organized format.  For this reason, a majority of 
Section 1 involves changing working directories, creating data sets via "read.table()", and renaming column names.

Towards the end of the section, the "rbind()" function is used to combine the "X_train" and "X_test" data sets.

Section 2:
Being asked to extract standard deviation and mean variables from teh combined "X_train" and "X_test" data sets, 
this section utilizes the "grepl" function and a .txt file called "features", provided in the .zip file.  
"features" is used to apply column names to the combined data sets from section 1, and from that "grepl()" is used to 
find all column names that use "mean" or "std".  

It should be noted that the results of this section are not used throughout the entire project, due to user interpretation 
of the following questions and sections.

Section 3:
This section details obtaining files "y_train" and "y_test" and naming them appropriately via the .txt file "activity_labels".
This is done within five lines of code, and the results are used in section 4. 

Section 4:
This section involves combining the combined "X_train" and "X_test" data sets, with the y "train" and "test' data sets, and an 
unmentioned (in this README.md) subject "train" and "test" data set.  All data sets were requested to be appropriately named
with regards to .txt files known as "features" and "activity_labels", respectively.  
The result has a data set that combines all read in data and has appropriately named them in such a way where there is a
data frame of 10299 rows and 563 columns.  The first two columns have the subject number and activity, respectively, whereas
the remaining 561 columns contain various variables.  

Section 5: 
This section involves reducing the amount of rows to 180 rows for the previous data set.  Question 5 asks for using the data
set obtained in Section 4, and finding the average for each activity for each subject.  Considering that there are 30 subjects,
with 6 activities each, that would mean there should be 180 rows in total.  These 180 rows will have 561 columns, each containing
the average of each variable for each activity.  

