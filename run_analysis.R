library(dplyr)
##Read in activity labels and subjects
actNameTest<-read.table("./test/y_test.txt", stringsAsFactors=FALSE)
actNameTrain<-read.table("./train/y_train.txt", stringsAsFactors=FALSE)
SubTest<-read.table("./test/subject_test.txt", stringsAsFactors=FALSE)
SubTrain<-read.table("./train/subject_train.txt", stringsAsFactors=FALSE)
#
##Rename activity labels
actNameTest[actNameTest==1]<-"Walking"
actNameTest[actNameTest==2]<-"Walking Upstairs"
actNameTest[actNameTest==3]<-"Walking Downstairs"
actNameTest[actNameTest==4]<-"Sitting"
actNameTest[actNameTest==5]<-"Standing"
actNameTest[actNameTest==6]<-"Laying"
actNameTrain[actNameTrain==1]<-"Walking"
actNameTrain[actNameTrain==2]<-"Walking Upstairs"
actNameTrain[actNameTrain==3]<-"Walking Downstairs"
actNameTrain[actNameTrain==4]<-"Sitting"
actNameTrain[actNameTrain==5]<-"Standing"
actNameTrain[actNameTrain==6]<-"Laying"
#
##Creating a vector of the activity labels, subjects
ActivitiesTest<-actNameTest[,1]
ActivitiesTrain<-actNameTrain[,1]
SubjectTest<-SubTest[,1]
SubjectTrain<-SubTrain[,1]
#
##Read in the feature labels
features<-read.table("features.txt", stringsAsFactors=FALSE)
#Convert the labels to a vector
Varnames<-features[,2]
#
##Read in the data, set the column names
dataTest<-read.table("./test/X_test.txt", stringsAsFactors=FALSE)
dataTrain<-read.table("./train/X_train.txt", stringsAsFactors=FALSE)
colnames(dataTest)<-Varnames
colnames(dataTrain)<-Varnames
#
##create the full tables
Test<-cbind(subject=SubjectTest, activity=ActivitiesTest,dataTest)
Train<-cbind(subject=SubjectTrain, activity=ActivitiesTrain,dataTrain)
#
##Merging the tables
Data1<-rbind(Test, Train)
#
##Subset the mean/standard deviation variables
vcn<-make.names(names=names(Data1), unique=TRUE, allow_=TRUE)
names(Data1)<-vcn
Data2<-select(Data1, contains("subject"), contains("activity"), contains("mean"), contains("std"))
#
##Create a new table, grouped by activity, averaging each variable
Data3<-summarise_at(group_by(Data2, subject, activity), vars(3:88), mean)
colnames(Data3)[3:88]<-paste("mean_of", colnames(Data3[3:88]), sep="_")
names(Data3)=gsub("...", "", names(Data3), fixed=TRUE)
names(Data3)=gsub("..", "", names(Data3), fixed=TRUE)
write.table(Data3, file="./result.txt", row.names=FALSE)