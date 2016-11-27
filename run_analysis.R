library(dplyr)
##Read in activity labels
actNameTest<-read.table("./test/y_test.txt", stringsAsFactors=FALSE)
actNameTrain<-read.table("./train/y_train.txt", stringsAsFactors=FALSE)
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
##Creating a vector of the activity labels
ActivitiesTest<-actNameTest[,1]
ActivitiesTrain<-actNameTrain[,1]
#
##Read in the feature labels
features<-read.table("features.txt", stringsAsFactors=FALSE)
#Convert the labels to a vector
Varnames<-features[,2]
#
##Read in the data, add the activities, set the column names
dataTest<-read.table("./test/X_test.txt", stringsAsFactors=FALSE)
dataTrain<-read.table("./train/X_train.txt", stringsAsFactors=FALSE)
colnames(dataTest)<-Varnames
colnames(dataTrain)<-Varnames
#
##create the full tables
Test<-cbind(activity=ActivitiesTest,dataTest)
Train<-cbind(activity=ActivitiesTrain,dataTrain)
#
##Merging the tables
Data1<-rbind(Test, Train)
#
##Subset the mean/standard deviation variables
vcn<-make.names(names=names(Data1), unique=TRUE, allow_=TRUE)
names(Data1)<-vcn
Data2<-select(Data1, contains("activity"), contains("mean"), contains("std"))
#
##Create a new table, grouped by activity, averaging each variable
Data3<-summarise_at(group_by(Data2, activity), vars(2:87), mean)
colnames(Data3)[2:87]<-paste("mean_of", colnames(Data3[2:87]), sep="_")
names(Data3)=gsub("...", "", names(Data3), fixed=TRUE)
names(Data3)=gsub("..", "", names(Data3), fixed=TRUE)
write.csv(Data3, file="./result.csv")