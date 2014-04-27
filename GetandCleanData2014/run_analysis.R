
	##Load libraries
	library(data.table)
	library(Hmisc)
	library(plyr)
	library(reshape)
	library(reshape2)
	library(psych)

	##Create folder "assign1"
	if(!file.exists("./assign1")){dir.create("./assign1")}

	##Download zip file
	download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="./assign1/UCI_HAR_Dataset.zip")

	##Create new working directory
	setwd("./assign1")

	##Unzip file
	unzip("./UCI_HAR_Dataset.zip", files = NULL, list = FALSE, overwrite = TRUE,
		  junkpaths = FALSE, exdir = ".", unzip = "internal",
		  setTimes = FALSE)

#1. Merges the training and the test sets to create one data set.
	##Load test and train files into R
		###Test datasets
		subject.test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
		table(subject.test$V1)
		subject.test <- rename(subject.test, c(V1="Subject"))
		colnames(subject.test)
		class(subject.test$Subject)

		Y.test<-read.table("./UCI HAR Dataset/test/y_test.txt")
		table(Y.test$V1)
		Y.test <- rename(Y.test, c(V1="Activity"))
		colnames(Y.test)
		class(Y.test$Activity)

		X.test<-read.table("./UCI HAR Dataset/test/X_test.txt")
		table(X.test$V1)
		sapply(X.test[1,],class)

		###Train datasets
		subject.train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
		table(subject.train$V1)
		subject.train <- rename(subject.train, c(V1="Subject"))
		colnames(subject.train)
		class(subject.train$Subject)

		Y.train<-read.table("./UCI HAR Dataset/train/y_train.txt")
		table(Y.train$V1)
		Y.train <- rename(Y.train, c(V1="Activity"))
		colnames(Y.train)
		class(Y.train$Activity)

		X.train<-read.table("./UCI HAR Dataset/train/X_train.txt")
		table(X.train$V1)
		sapply(X.train[1,],class)

		###Variable names for features
		features<-read.table("./UCI HAR Dataset/features.txt", )
		sapply(features[1,],class)
		features.new <- data.frame(lapply(features, as.character), stringsAsFactors=FALSE)
		sapply(features.new[1,],class)
		features.new$V1<- NULL
		features.new<-data.table(features.new)

		###Determine if any duplicate features
		which(duplicated(features.new))

		###Note: Will need to determine if they are truly duplicate values

	##Apply feature names to column names
  ##Sorry this takes a while; I don't know how else to assign column names
	featuresnames <- c("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", 
					   "tBodyAcc-std()-X",   "tBodyAcc-std()-Y",   "tBodyAcc-std()-Z",   
					   "tBodyAcc-mad()-X",   "tBodyAcc-mad()-Y",   "tBodyAcc-mad()-Z", 
					   "tBodyAcc-max()-X", "tBodyAcc-max()-Y", "tBodyAcc-max()-Z", 
					   "tBodyAcc-min()-X", "tBodyAcc-min()-Y", "tBodyAcc-min()-Z", 
					   "tBodyAcc-sma()", "tBodyAcc-energy()-X", "tBodyAcc-energy()-Y", 
					   "tBodyAcc-energy()-Z", "tBodyAcc-iqr()-X", "tBodyAcc-iqr()-Y", 
					   "tBodyAcc-iqr()-Z", "tBodyAcc-entropy()-X", "tBodyAcc-entropy()-Y", 
					   "tBodyAcc-entropy()-Z", "tBodyAcc-arCoeff()-X,1", "tBodyAcc-arCoeff()-X,2", 
					   "tBodyAcc-arCoeff()-X,3", "tBodyAcc-arCoeff()-X,4", "tBodyAcc-arCoeff()-Y,1", 
					   "tBodyAcc-arCoeff()-Y,2", "tBodyAcc-arCoeff()-Y,3", "tBodyAcc-arCoeff()-Y,4", 
					   "tBodyAcc-arCoeff()-Z,1", "tBodyAcc-arCoeff()-Z,2", "tBodyAcc-arCoeff()-Z,3", 
					   "tBodyAcc-arCoeff()-Z,4", "tBodyAcc-correlation()-X,Y", "tBodyAcc-correlation()-X,Z", 
					   "tBodyAcc-correlation()-Y,Z", "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", 
					   "tGravityAcc-mean()-Z", "tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z", 
					   "tGravityAcc-mad()-X", "tGravityAcc-mad()-Y", "tGravityAcc-mad()-Z", "tGravityAcc-max()-X", 
					   "tGravityAcc-max()-Y", "tGravityAcc-max()-Z", "tGravityAcc-min()-X", "tGravityAcc-min()-Y", 
					   "tGravityAcc-min()-Z", "tGravityAcc-sma()", "tGravityAcc-energy()-X", "tGravityAcc-energy()-Y", 
					   "tGravityAcc-energy()-Z", "tGravityAcc-iqr()-X", "tGravityAcc-iqr()-Y", "tGravityAcc-iqr()-Z", 
					   "tGravityAcc-entropy()-X", "tGravityAcc-entropy()-Y", "tGravityAcc-entropy()-Z", "tGravityAcc-arCoeff()-X,1", 
					   "tGravityAcc-arCoeff()-X,2", "tGravityAcc-arCoeff()-X,3", "tGravityAcc-arCoeff()-X,4", 
					   "tGravityAcc-arCoeff()-Y,1", "tGravityAcc-arCoeff()-Y,2", "tGravityAcc-arCoeff()-Y,3", 
					   "tGravityAcc-arCoeff()-Y,4", "tGravityAcc-arCoeff()-Z,1", "tGravityAcc-arCoeff()-Z,2", 
					   "tGravityAcc-arCoeff()-Z,3", "tGravityAcc-arCoeff()-Z,4", "tGravityAcc-correlation()-X,Y", 
					   "tGravityAcc-correlation()-X,Z", "tGravityAcc-correlation()-Y,Z", "tBodyAccJerk-mean()-X", 
					   "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z", "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", 
					   "tBodyAccJerk-std()-Z", "tBodyAccJerk-mad()-X", "tBodyAccJerk-mad()-Y", "tBodyAccJerk-mad()-Z", 
					   "tBodyAccJerk-max()-X", "tBodyAccJerk-max()-Y", "tBodyAccJerk-max()-Z", "tBodyAccJerk-min()-X", 
					   "tBodyAccJerk-min()-Y", "tBodyAccJerk-min()-Z", "tBodyAccJerk-sma()", "tBodyAccJerk-energy()-X", 
					   "tBodyAccJerk-energy()-Y", "tBodyAccJerk-energy()-Z", "tBodyAccJerk-iqr()-X", "tBodyAccJerk-iqr()-Y", 
					   "tBodyAccJerk-iqr()-Z", "tBodyAccJerk-entropy()-X", "tBodyAccJerk-entropy()-Y", "tBodyAccJerk-entropy()-Z", 
					   "tBodyAccJerk-arCoeff()-X,1", "tBodyAccJerk-arCoeff()-X,2", "tBodyAccJerk-arCoeff()-X,3", "tBodyAccJerk-arCoeff()-X,4", 
					   "tBodyAccJerk-arCoeff()-Y,1", "tBodyAccJerk-arCoeff()-Y,2", "tBodyAccJerk-arCoeff()-Y,3", "tBodyAccJerk-arCoeff()-Y,4", 
					   "tBodyAccJerk-arCoeff()-Z,1", "tBodyAccJerk-arCoeff()-Z,2", "tBodyAccJerk-arCoeff()-Z,3", "tBodyAccJerk-arCoeff()-Z,4", 
					   "tBodyAccJerk-correlation()-X,Y", "tBodyAccJerk-correlation()-X,Z", "tBodyAccJerk-correlation()-Y,Z", "tBodyGyro-mean()-X", 
					   "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z", "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z", "tBodyGyro-mad()-X", 
					   "tBodyGyro-mad()-Y", "tBodyGyro-mad()-Z", "tBodyGyro-max()-X", "tBodyGyro-max()-Y", "tBodyGyro-max()-Z", "tBodyGyro-min()-X", 
					   "tBodyGyro-min()-Y", "tBodyGyro-min()-Z", "tBodyGyro-sma()", "tBodyGyro-energy()-X", "tBodyGyro-energy()-Y", "tBodyGyro-energy()-Z", 
					   "tBodyGyro-iqr()-X", "tBodyGyro-iqr()-Y", "tBodyGyro-iqr()-Z", "tBodyGyro-entropy()-X", "tBodyGyro-entropy()-Y", "tBodyGyro-entropy()-Z", 
					   "tBodyGyro-arCoeff()-X,1", "tBodyGyro-arCoeff()-X,2", "tBodyGyro-arCoeff()-X,3", "tBodyGyro-arCoeff()-X,4", "tBodyGyro-arCoeff()-Y,1", 
					   "tBodyGyro-arCoeff()-Y,2", "tBodyGyro-arCoeff()-Y,3", "tBodyGyro-arCoeff()-Y,4", "tBodyGyro-arCoeff()-Z,1", "tBodyGyro-arCoeff()-Z,2", 
					   "tBodyGyro-arCoeff()-Z,3", "tBodyGyro-arCoeff()-Z,4", "tBodyGyro-correlation()-X,Y", "tBodyGyro-correlation()-X,Z", "tBodyGyro-correlation()-Y,Z", 
					   "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z", "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z", 
					   "tBodyGyroJerk-mad()-X", "tBodyGyroJerk-mad()-Y", "tBodyGyroJerk-mad()-Z", "tBodyGyroJerk-max()-X", "tBodyGyroJerk-max()-Y", "tBodyGyroJerk-max()-Z", 
					   "tBodyGyroJerk-min()-X", "tBodyGyroJerk-min()-Y", "tBodyGyroJerk-min()-Z", "tBodyGyroJerk-sma()", "tBodyGyroJerk-energy()-X", "tBodyGyroJerk-energy()-Y", 
					   "tBodyGyroJerk-energy()-Z", "tBodyGyroJerk-iqr()-X", "tBodyGyroJerk-iqr()-Y", "tBodyGyroJerk-iqr()-Z", "tBodyGyroJerk-entropy()-X", "tBodyGyroJerk-entropy()-Y", 
					   "tBodyGyroJerk-entropy()-Z", "tBodyGyroJerk-arCoeff()-X,1", "tBodyGyroJerk-arCoeff()-X,2", "tBodyGyroJerk-arCoeff()-X,3", "tBodyGyroJerk-arCoeff()-X,4", 
					   "tBodyGyroJerk-arCoeff()-Y,1", "tBodyGyroJerk-arCoeff()-Y,2", "tBodyGyroJerk-arCoeff()-Y,3", "tBodyGyroJerk-arCoeff()-Y,4", "tBodyGyroJerk-arCoeff()-Z,1", 
					   "tBodyGyroJerk-arCoeff()-Z,2", "tBodyGyroJerk-arCoeff()-Z,3", "tBodyGyroJerk-arCoeff()-Z,4", "tBodyGyroJerk-correlation()-X,Y", "tBodyGyroJerk-correlation()-X,Z", 
					   "tBodyGyroJerk-correlation()-Y,Z", "tBodyAccMag-mean()", "tBodyAccMag-std()", "tBodyAccMag-mad()", "tBodyAccMag-max()", "tBodyAccMag-min()", "tBodyAccMag-sma()", 
					   "tBodyAccMag-energy()", "tBodyAccMag-iqr()", "tBodyAccMag-entropy()", "tBodyAccMag-arCoeff()1", "tBodyAccMag-arCoeff()2", "tBodyAccMag-arCoeff()3", "tBodyAccMag-arCoeff()4", 
					   "tGravityAccMag-mean()", "tGravityAccMag-std()", "tGravityAccMag-mad()", "tGravityAccMag-max()", "tGravityAccMag-min()", "tGravityAccMag-sma()", "tGravityAccMag-energy()", 
					   "tGravityAccMag-iqr()", "tGravityAccMag-entropy()", "tGravityAccMag-arCoeff()1", "tGravityAccMag-arCoeff()2", "tGravityAccMag-arCoeff()3", "tGravityAccMag-arCoeff()4", 
					   "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()", "tBodyAccJerkMag-mad()", "tBodyAccJerkMag-max()", "tBodyAccJerkMag-min()", "tBodyAccJerkMag-sma()", "tBodyAccJerkMag-energy()", 
					   "tBodyAccJerkMag-iqr()", "tBodyAccJerkMag-entropy()", "tBodyAccJerkMag-arCoeff()1", "tBodyAccJerkMag-arCoeff()2", "tBodyAccJerkMag-arCoeff()3", "tBodyAccJerkMag-arCoeff()4", 
					   "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroMag-mad()", "tBodyGyroMag-max()", "tBodyGyroMag-min()", "tBodyGyroMag-sma()", "tBodyGyroMag-energy()", "tBodyGyroMag-iqr()", 
					   "tBodyGyroMag-entropy()", "tBodyGyroMag-arCoeff()1", "tBodyGyroMag-arCoeff()2", "tBodyGyroMag-arCoeff()3", "tBodyGyroMag-arCoeff()4", "tBodyGyroJerkMag-mean()", "tBodyGyroJerkMag-std()", 
					   "tBodyGyroJerkMag-mad()", "tBodyGyroJerkMag-max()", "tBodyGyroJerkMag-min()", "tBodyGyroJerkMag-sma()", "tBodyGyroJerkMag-energy()", "tBodyGyroJerkMag-iqr()", "tBodyGyroJerkMag-entropy()", 
					   "tBodyGyroJerkMag-arCoeff()1", "tBodyGyroJerkMag-arCoeff()2", "tBodyGyroJerkMag-arCoeff()3", "tBodyGyroJerkMag-arCoeff()4", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z", 
					   "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z", "fBodyAcc-mad()-X", "fBodyAcc-mad()-Y", "fBodyAcc-mad()-Z", "fBodyAcc-max()-X", "fBodyAcc-max()-Y", "fBodyAcc-max()-Z", 
					   "fBodyAcc-min()-X", "fBodyAcc-min()-Y", "fBodyAcc-min()-Z", "fBodyAcc-sma()", "fBodyAcc-energy()-X", "fBodyAcc-energy()-Y", "fBodyAcc-energy()-Z", "fBodyAcc-iqr()-X", "fBodyAcc-iqr()-Y", 
					   "fBodyAcc-iqr()-Z", "fBodyAcc-entropy()-X", "fBodyAcc-entropy()-Y", "fBodyAcc-entropy()-Z", "fBodyAcc-maxInds-X", "fBodyAcc-maxInds-Y", "fBodyAcc-maxInds-Z", "fBodyAcc-meanFreq()-X", 
					   "fBodyAcc-meanFreq()-Y", "fBodyAcc-meanFreq()-Z", "fBodyAcc-skewness()-X", "fBodyAcc-kurtosis()-X", "fBodyAcc-skewness()-Y", "fBodyAcc-kurtosis()-Y", "fBodyAcc-skewness()-Z", "fBodyAcc-kurtosis()-Z", 
					   "fBodyAcc-bandsEnergy()-1,8", "fBodyAcc-bandsEnergy()-9,16", "fBodyAcc-bandsEnergy()-17,24", "fBodyAcc-bandsEnergy()-25,32", "fBodyAcc-bandsEnergy()-33,40", "fBodyAcc-bandsEnergy()-41,48", "fBodyAcc-bandsEnergy()-49,56", 
					   "fBodyAcc-bandsEnergy()-57,64", "fBodyAcc-bandsEnergy()-1,16", "fBodyAcc-bandsEnergy()-17,32", "fBodyAcc-bandsEnergy()-33,48", "fBodyAcc-bandsEnergy()-49,64", "fBodyAcc-bandsEnergy()-1,24", "fBodyAcc-bandsEnergy()-25,48", 
					   "fBodyAcc-bandsEnergy()-1,8", "fBodyAcc-bandsEnergy()-9,16", "fBodyAcc-bandsEnergy()-17,24", "fBodyAcc-bandsEnergy()-25,32", "fBodyAcc-bandsEnergy()-33,40", "fBodyAcc-bandsEnergy()-41,48", "fBodyAcc-bandsEnergy()-49,56", 
					   "fBodyAcc-bandsEnergy()-57,64", "fBodyAcc-bandsEnergy()-1,16", "fBodyAcc-bandsEnergy()-17,32", "fBodyAcc-bandsEnergy()-33,48", "fBodyAcc-bandsEnergy()-49,64", "fBodyAcc-bandsEnergy()-1,24", "fBodyAcc-bandsEnergy()-25,48", 
					   "fBodyAcc-bandsEnergy()-1,8", "fBodyAcc-bandsEnergy()-9,16", "fBodyAcc-bandsEnergy()-17,24", "fBodyAcc-bandsEnergy()-25,32", "fBodyAcc-bandsEnergy()-33,40", "fBodyAcc-bandsEnergy()-41,48", "fBodyAcc-bandsEnergy()-49,56", 
					   "fBodyAcc-bandsEnergy()-57,64", "fBodyAcc-bandsEnergy()-1,16", "fBodyAcc-bandsEnergy()-17,32", "fBodyAcc-bandsEnergy()-33,48", "fBodyAcc-bandsEnergy()-49,64", "fBodyAcc-bandsEnergy()-1,24", "fBodyAcc-bandsEnergy()-25,48", 
					   "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z", "fBodyAccJerk-mad()-X", "fBodyAccJerk-mad()-Y", "fBodyAccJerk-mad()-Z", 
					   "fBodyAccJerk-max()-X", "fBodyAccJerk-max()-Y", "fBodyAccJerk-max()-Z", "fBodyAccJerk-min()-X", "fBodyAccJerk-min()-Y", "fBodyAccJerk-min()-Z", "fBodyAccJerk-sma()", "fBodyAccJerk-energy()-X", "fBodyAccJerk-energy()-Y", 
					   "fBodyAccJerk-energy()-Z", "fBodyAccJerk-iqr()-X", "fBodyAccJerk-iqr()-Y", "fBodyAccJerk-iqr()-Z", "fBodyAccJerk-entropy()-X", "fBodyAccJerk-entropy()-Y", "fBodyAccJerk-entropy()-Z", "fBodyAccJerk-maxInds-X", "fBodyAccJerk-maxInds-Y", 
					   "fBodyAccJerk-maxInds-Z", "fBodyAccJerk-meanFreq()-X", "fBodyAccJerk-meanFreq()-Y", "fBodyAccJerk-meanFreq()-Z", "fBodyAccJerk-skewness()-X", "fBodyAccJerk-kurtosis()-X", "fBodyAccJerk-skewness()-Y", "fBodyAccJerk-kurtosis()-Y", "fBodyAccJerk-skewness()-Z", 
					   "fBodyAccJerk-kurtosis()-Z", "fBodyAccJerk-bandsEnergy()-1,8", "fBodyAccJerk-bandsEnergy()-9,16", "fBodyAccJerk-bandsEnergy()-17,24", "fBodyAccJerk-bandsEnergy()-25,32", "fBodyAccJerk-bandsEnergy()-33,40", "fBodyAccJerk-bandsEnergy()-41,48", 
					   "fBodyAccJerk-bandsEnergy()-49,56", "fBodyAccJerk-bandsEnergy()-57,64", "fBodyAccJerk-bandsEnergy()-1,16", "fBodyAccJerk-bandsEnergy()-17,32", "fBodyAccJerk-bandsEnergy()-33,48", "fBodyAccJerk-bandsEnergy()-49,64", "fBodyAccJerk-bandsEnergy()-1,24", 
					   "fBodyAccJerk-bandsEnergy()-25,48", "fBodyAccJerk-bandsEnergy()-1,8", "fBodyAccJerk-bandsEnergy()-9,16", "fBodyAccJerk-bandsEnergy()-17,24", "fBodyAccJerk-bandsEnergy()-25,32", "fBodyAccJerk-bandsEnergy()-33,40", "fBodyAccJerk-bandsEnergy()-41,48", 
					   "fBodyAccJerk-bandsEnergy()-49,56", "fBodyAccJerk-bandsEnergy()-57,64", "fBodyAccJerk-bandsEnergy()-1,16", "fBodyAccJerk-bandsEnergy()-17,32", "fBodyAccJerk-bandsEnergy()-33,48", "fBodyAccJerk-bandsEnergy()-49,64", "fBodyAccJerk-bandsEnergy()-1,24", 
					   "fBodyAccJerk-bandsEnergy()-25,48", "fBodyAccJerk-bandsEnergy()-1,8", "fBodyAccJerk-bandsEnergy()-9,16", "fBodyAccJerk-bandsEnergy()-17,24", "fBodyAccJerk-bandsEnergy()-25,32", "fBodyAccJerk-bandsEnergy()-33,40", "fBodyAccJerk-bandsEnergy()-41,48", 
					   "fBodyAccJerk-bandsEnergy()-49,56", "fBodyAccJerk-bandsEnergy()-57,64", "fBodyAccJerk-bandsEnergy()-1,16", "fBodyAccJerk-bandsEnergy()-17,32", "fBodyAccJerk-bandsEnergy()-33,48", "fBodyAccJerk-bandsEnergy()-49,64", "fBodyAccJerk-bandsEnergy()-1,24", 
					   "fBodyAccJerk-bandsEnergy()-25,48", "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z", "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z", "fBodyGyro-mad()-X", "fBodyGyro-mad()-Y", "fBodyGyro-mad()-Z", "fBodyGyro-max()-X", "fBodyGyro-max()-Y", 
					   "fBodyGyro-max()-Z", "fBodyGyro-min()-X", "fBodyGyro-min()-Y", "fBodyGyro-min()-Z", "fBodyGyro-sma()", "fBodyGyro-energy()-X", "fBodyGyro-energy()-Y", "fBodyGyro-energy()-Z", "fBodyGyro-iqr()-X", "fBodyGyro-iqr()-Y", "fBodyGyro-iqr()-Z", "fBodyGyro-entropy()-X", 
					   "fBodyGyro-entropy()-Y", "fBodyGyro-entropy()-Z", "fBodyGyro-maxInds-X", "fBodyGyro-maxInds-Y", "fBodyGyro-maxInds-Z", "fBodyGyro-meanFreq()-X", "fBodyGyro-meanFreq()-Y", "fBodyGyro-meanFreq()-Z", "fBodyGyro-skewness()-X", "fBodyGyro-kurtosis()-X", "fBodyGyro-skewness()-Y", 
					   "fBodyGyro-kurtosis()-Y", "fBodyGyro-skewness()-Z", "fBodyGyro-kurtosis()-Z", "fBodyGyro-bandsEnergy()-1,8", "fBodyGyro-bandsEnergy()-9,16", "fBodyGyro-bandsEnergy()-17,24", "fBodyGyro-bandsEnergy()-25,32", "fBodyGyro-bandsEnergy()-33,40", "fBodyGyro-bandsEnergy()-41,48", 
					   "fBodyGyro-bandsEnergy()-49,56", "fBodyGyro-bandsEnergy()-57,64", "fBodyGyro-bandsEnergy()-1,16", "fBodyGyro-bandsEnergy()-17,32", "fBodyGyro-bandsEnergy()-33,48", "fBodyGyro-bandsEnergy()-49,64", "fBodyGyro-bandsEnergy()-1,24", "fBodyGyro-bandsEnergy()-25,48", "fBodyGyro-bandsEnergy()-1,8", 
					   "fBodyGyro-bandsEnergy()-9,16", "fBodyGyro-bandsEnergy()-17,24", "fBodyGyro-bandsEnergy()-25,32", "fBodyGyro-bandsEnergy()-33,40", "fBodyGyro-bandsEnergy()-41,48", "fBodyGyro-bandsEnergy()-49,56", "fBodyGyro-bandsEnergy()-57,64", "fBodyGyro-bandsEnergy()-1,16", "fBodyGyro-bandsEnergy()-17,32", 
					   "fBodyGyro-bandsEnergy()-33,48", "fBodyGyro-bandsEnergy()-49,64", "fBodyGyro-bandsEnergy()-1,24", "fBodyGyro-bandsEnergy()-25,48", "fBodyGyro-bandsEnergy()-1,8", "fBodyGyro-bandsEnergy()-9,16", "fBodyGyro-bandsEnergy()-17,24", "fBodyGyro-bandsEnergy()-25,32", "fBodyGyro-bandsEnergy()-33,40", 
					   "fBodyGyro-bandsEnergy()-41,48", "fBodyGyro-bandsEnergy()-49,56", "fBodyGyro-bandsEnergy()-57,64", "fBodyGyro-bandsEnergy()-1,16", "fBodyGyro-bandsEnergy()-17,32", "fBodyGyro-bandsEnergy()-33,48", "fBodyGyro-bandsEnergy()-49,64", "fBodyGyro-bandsEnergy()-1,24", "fBodyGyro-bandsEnergy()-25,48", 
					   "fBodyAccMag-mean()", "fBodyAccMag-std()", "fBodyAccMag-mad()", "fBodyAccMag-max()", "fBodyAccMag-min()", "fBodyAccMag-sma()", "fBodyAccMag-energy()", "fBodyAccMag-iqr()", "fBodyAccMag-entropy()", "fBodyAccMag-maxInds", "fBodyAccMag-meanFreq()", "fBodyAccMag-skewness()", "fBodyAccMag-kurtosis()", 
					   "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()", "fBodyBodyAccJerkMag-mad()", "fBodyBodyAccJerkMag-max()", "fBodyBodyAccJerkMag-min()", "fBodyBodyAccJerkMag-sma()", "fBodyBodyAccJerkMag-energy()", "fBodyBodyAccJerkMag-iqr()", "fBodyBodyAccJerkMag-entropy()", "fBodyBodyAccJerkMag-maxInds", 
					   "fBodyBodyAccJerkMag-meanFreq()", "fBodyBodyAccJerkMag-skewness()", "fBodyBodyAccJerkMag-kurtosis()", "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()", "fBodyBodyGyroMag-mad()", "fBodyBodyGyroMag-max()", "fBodyBodyGyroMag-min()", "fBodyBodyGyroMag-sma()", "fBodyBodyGyroMag-energy()", "fBodyBodyGyroMag-iqr()", 
					   "fBodyBodyGyroMag-entropy()", "fBodyBodyGyroMag-maxInds", "fBodyBodyGyroMag-meanFreq()", "fBodyBodyGyroMag-skewness()", "fBodyBodyGyroMag-kurtosis()", "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()", "fBodyBodyGyroJerkMag-mad()", "fBodyBodyGyroJerkMag-max()", "fBodyBodyGyroJerkMag-min()", 
					   "fBodyBodyGyroJerkMag-sma()", "fBodyBodyGyroJerkMag-energy()", "fBodyBodyGyroJerkMag-iqr()", "fBodyBodyGyroJerkMag-entropy()", "fBodyBodyGyroJerkMag-maxInds", "fBodyBodyGyroJerkMag-meanFreq()", "fBodyBodyGyroJerkMag-skewness()", "fBodyBodyGyroJerkMag-kurtosis()", "angle(tBodyAccMean,gravity)", "angle(tBodyAccJerkMean),gravityMean)", 
					   "angle(tBodyGyroMean,gravityMean)", "angle(tBodyGyroJerkMean,gravityMean)", "angle(X,gravityMean)", "angle(Y,gravityMean)", "angle(Z,gravityMean)")  

		names(X.test)<-featuresnames
		names(X.train)<-featuresnames

	##Notes:
		###Subject train dataset- 7352 observations, 1 variable
		###Y train dataset - 7352 observations, 1 variable
		###X train dataset - 7352 observations, 561 variables
		###Total Train set - 7352 observations, 563 variables

		###Subject test - 2947 observations, 1 variable
		###Y test dataset- 2947 observations, 1 variable
		###X train dataset - 2947 observations, 561 variables
		###Total test set - 2947 observations, 563 variables

	##Combine Train datasets
		train.data<-cbind(subject.train, Y.train, X.train)
	##Looking for duplicated observations
		duplicated(train.data)
	##Looking for duplicated columns
		duplicated(train.data[,3:563])
		anyDuplicated(train.data[, 3:563])

	##Combine Test datasets
		test.data<-cbind(subject.test, Y.test, X.test)
	##Looking for duplicated observations
		duplicated(test.data)
	##Looking for duplicated columns
		duplicated(test.data[,3:563])
		anyDuplicated(test.data[, 3:563])

#3. Uses descriptive variable names to name the variables in the data set
	##Tidy column names prior to concantenating datasets
	##Train data variable names
		names(train.data) <- gsub('[[:punct:]]', "_", names(train.data))
		var.numbs <- dim(train.data)[2]-0
		var.numbsSub <- dim(train.data)[2] - 2
		amend <- paste("v", 1:var.numbsSub, sep="")
		names(train.data)[3:var.numbs] <- paste(names(train.data)[3:var.numbsSub], amend)
	##Test data variable names
		names(test.data) <- gsub('[[:punct:]]', "_", names(test.data))
		var.numbs <- dim(test.data)[2]-0
		var.numbsSub <- dim(test.data)[2] - 2
		amend <- paste("v", 1:var.numbsSub, sep="")
		names(test.data)[3:var.numbs] <- paste(names(test.data)[3:var.numbsSub], amend)
		colnames(train.data)
		colnames(test.data)

#Final part of 1. Merges the training and the test sets to create one data set.
	##Combine Train and Test datasets
		###Note: total combined dataset 10,299 observations with 563 variables
		samsungData<-rbind(train.data, test.data)
		samsungData<-data.frame(samsungData)

	##Looking for duplicated columns and/or observations
		duplicated(samsungData)
		anyDuplicated(samsungData)

	##Determine class of Subject and Activity; 
		class(samsungData$Subject)
		class(samsungData$Activity)
		###Note: change class of Activity to Factor variable

#4. Appropriately labels the data set with descriptive activity names.
		samsungData$Activity <- factor(samsungData$Activity, 
									   levels = c(1, 2, 3, 4, 5, 6),
									   labels = c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

		class(samsungData$Activity)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
		samsungData.summary <- describe(samsungData[, 3:563])
		samsungData.summary<-data.frame(samsungData.summary)
		samsungData.summ <- samsungData.summary[, 3:4] 
		names(samsungData.summ)<-c("Mean", "Standard_Deviation")

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

		###Note: Creation of crosstab for Subject and Activity to determine number of 
		###variables per subject per activity.
		samsungData.crosstab <- table(samsungData$Subject,samsungData$Activity) 
		samsungData.crosstab
  ##Obtain columns and row totals
    margin.table(samsungData.crosstab , 1) # Row frequencies (summed over Columns) 
    margin.table(samsungData.crosstab , 2) # Column frequencies (summed over Rows)

		###Note: 30 Subjects, 6 Activities, 561 features = 100,980 observations
	##Second dataset of means
		samsungData.means <- describeBy(samsungData[3:563],list(samsungData$Subject,samsungData$Activity),
                      mat=TRUE) 
		samsungData.meansfinal<-samsungData.means[, 1:6]
		samsungData.meansfinal<-data.frame(samsungData.meansfinal)
		colnames(samsungData.meansfinal)<-c("Item_Number", "Subject", "Activity", "Variable_Number", "Count", "Mean")
	##Save dataset .Rda file
		save(samsungData.meansfinal,file="samsungDataMeans.rda")
	

