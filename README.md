## Human Activity Recognition Using Smartphones Dataset

##Overview
This repository contains "run_analysis.R", "summary.txt", "CodeBook.md", and this "README.md" file.

The script "run_analysis.R" reads and makes use of the files below, particularly items 3-8. It merges these files to obtain one tidy data set that lists the activities done by the subjects and their corresponding measurements of features (mean and standard deviation). The script results to data frame that summarizes the obtained tidy data set by averaging the measurements for each activity and subject. This output is written to a file named "/summary.txt".

Data was was obtained from Human Activity Recognition Using Smartphones Dataset(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

Experiments have been done with a group of 30 volunteers with ages ranging from 18 to 48 years. Six activities were performed by eahc person, namely: walking, walking upstairs, walking downstairs, sitting, standing, and laying. Each person wore a Samsung Galaxy S II smartphone.

The relevant (raw) files found in the directory "UCI HAR Dataset" are:
1. "/UCI HAR Dataset/features_info.txt" - A file explaining the features in the study.
2. "/UCI HAR Dataset/README.txt" - A file from the original source explaining details of the raw data used.
3. "/UCI HAR Dataset/features.txt" - A text file that lists all features.
4. "/UCI HAR Dataset/activity_labels.txt" - A text file that matches activity labels with activity number.
5. "/UCI HAR Dataset/train/y_train.txt" - A text file that contains data of activity done per record in the training group.
6. "/UCI HAR Dataset/train/X_train.text" - A text file containing measurements of features for the training group.
7. "/UCI HAR Dataset/train/y_test.txt" - A text file that contains data of activity done per record in the test group.
8. "/UCI HAR Dataset/train/X_test.text" - A text file containing measurements of features for the test group.

Note that these all came from the original source of data as referenced above.

The "CodeBook.md" contained in this repository describes the study observed, variables included, and transformations done in the tidy data in "/summary.txt" in more detail.

### Steps/Transformations to produce tidy data

Note that the directory one must be working on must contain the directory "UCI HAR Dataset" which contains the needed files for the data and analysis and that the "reshape2" package is installed.

1. Read "./UCI HAR Dataset/activity_labels.txt" [activityLabels] and assign the column names "number" and "activity" to its two columns. Edit the labels for tidier data and uniformity by replacing "_" with a space and converting all letters to lowercase.

2. Read "./UCI HAR Dataset/features.txt" [features] and assign the names "number" and "name" to its columns.

3. Read "./UCI HAR Dataset/train/subject_train.txt" and assign column name "subjects".

4. Read "./UCI HAR Dataset/train/X_train.txt" [xTrain] and assign column names using data obtained in [features].

5. Read "./UCI HAR Dataset/train/y_train.txt" [yTrain] and assign column name "number".

6. Join data frames [subjectTrain, yTrain, xTrain] column-wise using cbind() function. Now, we have a data frame named [dataTrain1]

7. We replace the "number" indicating the activity with the labels by merging [dataTrain1] and [activityLabels] and removing the "number" column. We now have the resulting data frame called [dataTrain] with dimensions 7352x563 containing subjects from the training group and their recorded measurements per activity.

8. We do similar steps as steps 4-7 but this time using the corresponding files for the test group. This is to obtain a data frame named [dataTest] with dimensions 2947x563.

9. We merge the rows of [dataTrain] and [dataTest] to obtain a data frame containing all records [dataMerged] using rbind() function.

10. We subset [dataMerged] to exclude columns of measurements that do not refer to the mean and standard deviation of the features. We make use of grep() to find those columns with substring "mean()" and "std()". Note that we require the parantheses to exist since there are measurements that include the word "[Mm]ean" that we are not interested in(i.e. those used on the angle() variable). Also, note that "activity" and "subjects" must be unchanged. Now, we have a data framed named [data] with dimensions 10299x68.

11. We create a function that "fixes" the column names to be more clear and readable. The function "fix" is defined to
	*  replace "_" with ""
	*  capitalize "m" in "mean"
	*  capitalize "s" in "std
	*  complete the word "Acc" to "Acceleration"
	*  complete the word "Ang" to "Angular"
	*  complete the word "Mag" to "Magnitude"
	*  remove redundancy of "BodyBody" and make it "Body" only
	*  complete the initial letters "t" and "f" to "Time" and "Frequency", respectively (for column names that are not "subject" nor "activity").
Then, we apply the function to the column names of [data].

12. Summarize the tidy data [data] by averaging each variable for each subject and each activity. We do this by using melt() and dcast() functions in reshape2 package. Note that the package must be installed for the whole script to work.

13. The summary is the final output that we write into "./summary.txt". Because of how this file is written, it is advised to use header=TRUE and sep="\t" as parameter when reading it in R.