## Human Activity Recognition Using Smartphones Dataset

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