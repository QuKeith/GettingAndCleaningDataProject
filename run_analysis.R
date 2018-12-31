##This script creates a tidy data set involving smarphone recognition of human data set
    ##...by averaging each variable for each subject and each activity.

##read and fix ./UCI HAR Dataset/activity_labels.txt
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="", col.names=c("number","activity"))
activityLabels$activity <- tolower(activityLabels$activity)
activityLabels$activity <- sub("_", " ", activityLabels$activity)

##read and fix ./UCI HAR Dataset/features.txt
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, sep="", col.names=c("number","name"))

##create train data frame
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="", col.names=c("subject"))

xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")
colnames(xTrain) = features$name

yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, sep="", col.names=c("number"))

dataTrain1 <- cbind(subjectTrain, yTrain, xTrain)

dataTrain <- merge(activityLabels, dataTrain1, by.x="number", by.y="number", all=TRUE)
dataTrain$number = NULL

##create test data frame
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="", col.names="subject")

xTest <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")
colnames(xTest) = features$name

yTest <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, sep="", col.names="number")

dataTest1 <- cbind(subjectTest, yTest, xTest)

dataTest <- merge(activityLabels, dataTest1, by.x="number", by.y="number", all=TRUE)
dataTest$number = NULL


##merge train and test data frames
dataMerged <- rbind(dataTrain, dataTest)

##tidying dataMerged more to produce final data
data <- dataMerged[,colnames(dataMerged) %in% c("subject", "activity", grep("(.*)mean\\(+(.*)|(.*)std\\(+(.*)",colnames(dataMerged), value=TRUE))]

fix <- function(x) {            
    ##fixes variable names
    x <- gsub("-","", x)
    x <- gsub("mean\\(\\)+","Mean", x)
    x <- gsub("std\\(\\)","Std", x)
    x <- gsub("Acc","Acceleration", x)
    x <- gsub("Ang", "Angular", x)
    x <- gsub("Mag", "Magnitude", x)
    x <- gsub("BodyBody", "Body", x)
    
    initial <- function(y) {
        if (y=="subject" | y=="activity") {
            y
        }
        else if (substr(y,1,1)=="t") {
            y <- paste0("time",substr(y,2,nchar(y)))
        }
        else if (substr(y,1,1)=="f") {
            y <- paste0("frequency",substr(y,2,nchar(y)))
        }
        y
    }
    x <- sapply(x,initial)
    x
}

colnames(data) <- fix(colnames(data))

##summary: independent data set with the average of each variable for each activity and each subject
library(reshape2)
dataMelt <- melt(data, id=c("activity", "subject"), measure.vars=colnames(data)[colnames(data)!="activity" & colnames(data)!="subject"])
summary <- dcast(dataMelt, activity + subject~variable,mean)

##write table
write.table(summary, file="./summary.txt", row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
