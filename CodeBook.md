## Human Activity Recognition Using Smartphones Dataset
This book describes the study observed, variables included, and transformations done in the tidy data in "/summary.txt"

### Study Observed
The data was obtained from [Human Activity Recognition Using Smartphones Dataset(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

Experiments have been done with a group of 30 volunteers with ages ranging from 18 to 48 years. Six activities were performed by eahc person, namely: walking, walking upstairs, walking downstairs, sitting, standing, and laying. Each person wore a Samsung Galaxy S II smartphone.

Three-axial linear acceleration and three-axial angular velocity at a constant rate of 50Hz were recorded using the embedded accelerometer and gyroscope of the smartphone. A video recording was done to label the data manually. Furthermore, the dataset has been randomly partitioned into two sets: 70% for training and 30% for test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

For each record it is provided:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.


More information on the experiment may be found in the [website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### Raw data files used for the tidy data

* "/UCI HAR Dataset/features.txt" - A text file that lists all features.
* "/UCI HAR Dataset/activity_labels.txt" - A text file that matches activity labels with activity number.
* "/UCI HAR Dataset/train/y_train.txt" - A text file that contains data of activity done per record in the training group.
* "/UCI HAR Dataset/train/X_train.text" - A text file containing measurements of features for the training group.
* "/UCI HAR Dataset/train/y_test.txt" - A text file that contains data of activity done per record in the test group.
* "/UCI HAR Dataset/train/X_test.text" - A text file containing measurements of features for the test group.

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

### Study's Feature Selection
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals timeAccelerationXYZ and timeGyro-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (timeBodyAccelerationXYZ and timeGravityAccelerationXYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timeBodyAccelerationJerkXYZ and timeBodyGyroJerkXYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (timeBodyAccelerationMagnitude, timeGravityAccelerationMagnitude, timeBodyAccelerationJerkMagnitude, timeBodyGyroMagnitude, timeBodyGyroJerkMagnitude). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequencyBodyAccelerationXYZ, frequencyBodyAccJerkXYZ, frequencyBodyGyroXYZ, frequencyBodyAccJerkMagnitude, frequencyBodyGyroMagnitude, frequencyBodyGyroJerkMagnitude.

Features are normalized and bounded within [-1,1].

### Complete list of variables (Total: 68)

1. activity - activity performed ("walking", "walking upstairs", "walking downstairs", "sitting", "standing", and "laying")
2. subject - identifier of the subject performing the activity (range: 1-30)
3. timeBodyAccelerationMeanX
	* mean value of body acceleration in the X-axis
	* obtained from time domain signals
	* unit: standard gravity units g
4. timeBodyAccelerationMeanY
	* mean value of body acceleration in the Y-axis
	* obtained from time domain signals
	* unit: g
5. timeBodyAccelerationMeanZ
	* mean value of body acceleration in the z-axis
	* obtained from time domain signals
	* unit: g
6. timeBodyAccelerationStdX
	* standard deviation of body acceleration in the X-axis
	* obtained from time domain signals
	* unit: g
7. timeBodyAccelerationStdY
	* standard deviation of body acceleration in the Y-axis
	* obtained from time domain signals
	* unit: g
8. timeBodyAccelerationStdZ
	* standard deviation of body acceleration in the Z-axis
	* obtained from time domain signals
	* unit: g
9. timeGravityAccelerationMeanX
	* mean value of gravity acceleration in the X-axis
	* obtained from time domain signals
	* unit: g
10. timeGravityAccelerationMeanY
	* mean value of gravity acceleration in the Y-axis
	* obtained from time domain signals
	* unit: g
11. timeGravityAccelerationMeanZ
	* mean value of gravity acceleration in the Z-axis
	* obtained from time domain signals
	* unit: g
12. timeGravityAccelerationStdX
	* standard deviation of gravity acceleration in the X-axis
	* obtained from time domain signals
	* unit: g
13. timeGravityAccelerationStdY
	* standard deviation of gravity acceleration in the Y-axis
	* obtained from time domain signals
	* unit: g
14. timeGravityAccelerationStdZ
	* standard deviation of gravity acceleration in the Z-axis
	* obtained from time domain signals
	* unit: g
15. timeBodyAccelerationJerkMeanX
	* mean value of Jerk of body linear acceleration in the X-axis
	* obtained from time domain signals
	* unit: g/s
16. timeBodyAccelerationJerkMeanY
	* mean value of jerk of body linear acceleration in the Y-axis
	* obtained from time domain signals
	* unit: g/s
17. timeBodyAccelerationJerkMeanZ
	* mean value of jerk of body linear acceleration in the Z-axis
	* obtained from time domain signals
	* unit: g/s
18. timeBodyAccelerationJerkStdX
	* standard deviation of jerk of body linear acceleration in the X-axis
	* obtained from time domain signals
	* unit: g/s
19. timeBodyAccelerationJerkStdY
	* standard deviation of jerk of body linear acceleration in the Y-axis
	* obtained from time domain signals
	* unit: g/s
20. timeBodyAccelerationJerkStdZ
	* standard deviation of jerk of body linear acceleration in the Z-axis
	* obtained from time domain signals
	* unit: g/s
21. timeBodyGyroMeanX
	* mean value of angular velocity in the X-axis
	* obtained from time domain signals
	* unit: radians/second
22. timeBodyGyroMeanY
	* mean value of angular velocity in the Y-axis
	* obtained from time domain signals
	* unit: radians/second
23. timeBodyGyroMeanZ
	* mean value of angular velocity in the Z-axis
	* obtained from time domain signals
	* unit: radians/second
24. timeBodyGyroStdX
	* standard deviation of angular velocity in the X-axis
	* obtained from time domain signals
	* unit: radians/second
25. timeBodyGyroStdY
	standard deviation of angular velocity in the Y-axis
	* obtained from time domain signals
	* unit: radians/second
26. timeBodyGyroStdZ
	* standard deviation of angular velocity in the Z-axis
	* obtained from time domain signals
	* unit: radians/second
27. timeBodyGyroJerkMeanX
	* mean value of jerk of angular velocity in the X-axis
	* obtained from time domain signals
	* unit: rad/s^2
28. timeBodyGyroJerkMeanY
	* mean value of jerk of angular velocity in the Y-axis
	* obtained from time domain signals
	* unit: rad/s^2
29. timeBodyGyroJerkMeanZ
	* mean value of jerk of angular velocity in the Z-axis
	* obtained from time domain signals
	* unit: rad/s^2
30. timeBodyGyroJerkStdX
	* standard deviation of jerk of angular velocity in the X-axis
	* obtained from time domain signals
	* unit: rad/s^2
31. timeBodyGyroJerkStdY
	* standard deviation of jerk of angular velocity in the Y-axis
	* obtained from time domain signals
	* unit: rad/s^2
32. timeBodyGyroJerkStdZ
	* standard deviation of jerk of angular velocity in the Z-axis
	* obtained from time domain signals
	* unit: rad/s^2
33. timeBodyAccelerationMagnitudeMean
	* mean value of magnitude of body acceleration obtained from time domain signals
34. timeBodyAccelerationMagnitudeStd
	* standard deviation of magnitude of body acceleration obtained from time domain signals
35. timeGravityAccelerationMagnitudeMean
	* mean value of magnitude of gravity acceleration obtained from time domain signals
36. timeGravityAccelerationMagnitudeStd
	* standard deviation of magnitude of gravity acceleration obtained from  time domain signals
37. timeBodyAccelerationJerkMagnitudeMean
	* mean value of magnitude of jerk of body acceleration obtained from time domain signals
38. timeBodyAccelerationJerkMagnitudeStd
	* standard deviation value of magnitude of jerk of body acceleration obtained from time domain signals
39. timeBodyGyroMagnitudeMean
	* mean value of magnitude of angular velocity obtained from time domain signals
40. timeBodyGyroMagnitudeStd
	* standard deviation of magnitude of angular velocity obtained from time domain signals
41. timeBodyGyroJerkMagnitudeMean
	* mean value of magnitude of jerk of angular velocity obtained from time domain signals
42. timeBodyGyroJerkMagnitudeStd
	* standard deviation of value of magnitude of jerk of angular velocity obtained from time domain signals
43. frequencyBodyAccelerationMeanX
	* mean value of body acceleration in the X-axis
	* obtained from frequency domain signals
	* unit: g
44. frequencyBodyAccelerationMeanY
	* mean value of body acceleration in the Y-axis
	* obtained from frequency domain signals
	* unit: g
45. frequencyBodyAccelerationMeanZ
	* mean value of body acceleration in the Z-axis
	* obtained from frequency domain signals
	* unit: g
46. frequencyBodyAccelerationStdX
	* standard deviation of body acceleration in the X-axis
	* obtained from frequency domain signals
	* unit: g
47. frequencyBodyAccelerationStdY
	* standard deviation of body acceleration in the Y-axis
	* obtained from frequency domain signals
	* unit: g
48. frequencyBodyAccelerationStdZ
	* standard deviation of body acceleration in the Z-axis
	* obtained from frequency domain signals
	* unit: g
49. frequencyBodyAccelerationJerkMeanX
	* mean value of jerk of body linear acceleration in the X-axis
	* obtained from frequency domain signals
	* unit: g/s
50. frequencyBodyAccelerationJerkMeanY
	* mean value of jerk of body linear acceleration in the Y-axis
	* obtained from frequency domain signals
	* unit: g/s
51. frequencyBodyAccelerationJerkMeanZ
	* mean value of jerk of body linear acceleration in the Z-axis
	* obtained from frequency domain signals
	* unit: g/s
52. frequencyBodyAccelerationJerkStdX
	* standard deviation of jerk of body linear acceleration in the X-axis
	* obtained from frequency domain signals
	* unit: g/s
53. frequencyBodyAccelerationJerkStdY
	* standard deviation of jerk of body linear acceleration in the Y-axis
	* obtained from frequency domain signals
	* unit: g/s
54. frequencyBodyAccelerationJerkStdZ
	* standard deviation of jerk of body linear acceleration in the Z-axis
	* obtained from frequency domain signals
	* unit: g/s
55. frequencyBodyGyroMeanX
	* mean value of angular velocity in the X-axis
	* obtained from frequency domain signals
	* unit: radians/second
56. frequencyBodyGyroMeanY
	* mean value of angular velocity in the Y-axis
	* obtained from frequency domain signals
	* unit: radians/second
57. frequencyBodyGyroMeanZ
	* mean value of angular velocity in the Z-axis
	* obtained from frequency domain signals
	* unit: radians/second
58. frequencyBodyGyroStdX
	* standard deviation of angular velocity in the X-axis
	* obtained from frequency domain signals
	* unit: radians/second
59. frequencyBodyGyroStdY
	* standard deviation of angular velocity in the Y-axis
	* obtained from frequency domain signals
	* unit: radians/second
60. frequencyBodyGyroStdZ
	* standard deviation of angular velocity in the Z-axis
	* obtained from frequency domain signals
	* unit: radians/second
61. frequencyBodyAccelerationMagnitudeMean
	* mean value of magnitude of body acceleration obtained from frequency domain signals
62. frequencyBodyAccelerationMagnitudeStd
	* standard deviation of magnitude of body acceleration obtained from frequenct domain signals
63. frequencyBodyAccelerationJerkMagnitudeMean
	* mean value of magnitude of jerk of body acceleration obtained from frequency domain signals
64. frequencyBodyAccelerationJerkMagnitudeStd
	* standard deviation of magnitude of jerk body acceleration obtained from frequency domain signals
65. frequencyBodyGyroMagnitudeMean
	* mean value of magnitude of angular velocity obtained from frequency domain signals
66. frequencyBodyGyroMagnitudeStd
	* standard deviation of magnitude of angular velocity obtained from frequency domain signals
67. frequencyBodyGyroJerkMagnitudeMean
	* mean value of magnitude of jerk of angular velocity obtained from frequency domain signals
68. frequencyBodyGyroJerkMagnitudeStd
	* standard deviation of magnitude of jerk of angular velocity obtained from frequency domain signals

### Sources
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012