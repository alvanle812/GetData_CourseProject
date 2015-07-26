
# Download file and uzip the file
# For my OS, it is not required to put https for fileURL
# and need to add mod='wb' to be able to unzip the file later

if (!file.exists("GetData_Project.zip")){
      fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
      download.file(fileURL,"GetData_Project.zip", mod="wb")
}  
if (!file.exists("UCI HAR Dataset")) { 
      unzip("GetData_Project.zip") 
}

# Load activity labels + features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
# The label now is in class factor
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
# The feature now is in class factor
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
# grepping only the column names which contain the 'mean' or 'std'
MeanStd <- grep(".*mean.*|.*std.*", features[,2])
MeanStd.names <- features[featuresWanted,2]

# Load train data - only the Mean and Std columns
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")[MeanStd]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainData <- cbind(trainSubjects, trainActivities, trainData)

# Load test data - only the Mean and Std columns
testData <- read.table("UCI HAR Dataset/test/X_test.txt")[MeanStd]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testData <- cbind(testSubjects, testActivities, testData)

# merge train data and test data
MergeDF <- rbind(trainData, testData)
colnames(MergeDF) <- c("subject", "activity", MeanStd.names)

# turn activities & subjects into factors
MergeDF$activity <- factor(MergeDF$activity, levels = activityLabels[,1], labels = activityLabels[,2])
MergeDF$subject <- as.factor(MergeDF$subject)

# long form tidy dataset (melt)
MergeDF.melted <- melt(MergeDF, id = c("subject", "activity"))
MergeDF.mean <- dcast(MergeDF.melted, subject + activity ~ variable, mean)

#create tidy.txt file
write.table(MergeDF.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
