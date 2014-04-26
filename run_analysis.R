##setwd('G:/coursera and EdX/Data Science Specialization John Hopkins/Getting and Cleaning Data/Week 3')

# load test and training sets and the activities
X_test <- read.table("./test/X_test.txt",header=FALSE)
y_test <- read.table("./test/y_test.txt",header=FALSE)
subject_test <- read.table("./test/subject_test.txt",header=FALSE)
X_train <- read.table("./train/X_train.txt",header=FALSE)
y_train <- read.table("./train/y_train.txt",header=FALSE)
subject_train <- read.table("./train/subject_train.txt",header=FALSE)

## Uses descriptive activity names to name the activities in the data set
label <- read.table("./activity_labels.txt",header=FALSE,colClasses="character")
y_test$V1 <- factor(y_test$V1,levels=label$V1,labels=label$V2)
y_train$V1 <- factor(y_train$V1,levels=label$V1,labels=label$V2)

## Appropriately labels the data set with descriptive activity names
features <- read.table("./features.txt",header=FALSE,colClasses="character")
colnames(X_test)<-features$V2
colnames(X_train)<-features$V2
colnames(y_test)<-c("Activity")
colnames(y_train)<-c("Activity")
colnames(subject_test)<-c("Subject")
colnames(subject_train)<-c("Subject")

## merge test and training sets into one data set, including the activities
test<-cbind(X_test,y_test)
test<-cbind(test,subject_test)
train<-cbind(X_train,y_train)
train<-cbind(train,subject_train)
samsungdata<-rbind(test,train)

## extract only the measurements on the mean and standard deviation for each measurement
samsungdata_mean<-sapply(samsungdata,mean,na.rm=TRUE)
samsungdata_sd<-sapply(samsungdata,sd,na.rm=TRUE)
library(data.table)
## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
dat <- data.table(samsungdata_sd)
tidy<-dat[,lapply(.SD,mean),by="Activity,Subject"]