##1 Merges the training and the test sets to create one data set.
##2 Extracts only the measurements on the mean and standard deviation for each measurement. 
##3 Uses descriptive activity names to name the activities in the data set
##4 Appropriately labels the data set with descriptive variable names. 
##5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



setwd("~/Desktop/R Studies/getting data/Getting Data Project")
if (!file.exists("data")){
  dir.create("data")
}
list.files("./data")
## download and unzip files
##install.packages("downloader")
library("downloader")
download("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", dest="./data/dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "./data/")

##list.files("./data/UCI HAR Dataset")

## Download Activity Labels and Features (column names for dateset) which will be used to create combined dataset and transform them into vectors
activity_labels<-read.table("./data/UCI HAR Dataset/activity_labels.txt")
features<-read.table("./data/UCI HAR Dataset/features.txt")
features_vector <- as.vector(features[,2])
activity_labels_vector<-as.vector(activity_labels[,2])

## Read files to create complete TEST dataset (add subjects and activity codes to X_train),give proper names to columns
##list.files("./data/UCI HAR Dataset/test")
X_test<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
test<-X_test
## Includes_Step 4 -Proper names of columns for test
names(test)<-features_vector
test2<-cbind(test,y_test)
test3<-cbind(test2,subject_test)
names(test3)[562]<-"activity"
names(test3)[563]<-"person"

## Read files to create complete TRAIN dataset (add subjects and activity codes to X_train),give proper names to columns
##list.files("./data/UCI HAR Dataset/train")
X_train<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")

train<-X_train
##Includes_Step 4-Proper names of columns for test
names(train)<-features_vector
train2<-cbind(train,y_train)
train3<-cbind(train2,subject_train)
names(train3)[562]<-"activity"
names(train3)[563]<-"person"

## check if columns are the same

##name_col <- function(x,y) {
  ##for (i in names(x)) {
    ##if (!(i %in% names(y))) {
      ##print('Warning: Names are not the same')
      ##break
    ##}  
    ##else if(i==tail(names(y),n=1)) {
 ##     print('Names are identical')
   ## }
##  }
##}
##name_col(test3,train3)
big_set<-rbind(train3,test3)


## find coulmns matching certain criteria

##install.packages("dplyr")
library("dplyr")

##duplicates<-colnames(big_set[(duplicated(colnames(big_set)))])
##duplic_col<-colnames(big_set[(!duplicated(colnames(big_set)))])
big_set1<-big_set[(!duplicated(colnames(big_set)))]

big_set2<-bind_cols(select(big_set1, one_of("activity","person")),select(big_set1, contains(c("mean"))),select(big_set1, contains(c("std"))))
big_set3<-select(big_set2,-contains("Freq"))
big_set3<-select(big_set3, -contains("angle"))
##  Step 3 Uses descriptive activity names to name the activities in the data set
big_set4<-big_set3
for (i in 1:10299){
  big_set4$activity[i]<-as.character(activity_labels$V2[big_set3$activity[i]])
}
## Step 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
sum_set<-(big_set4 %>% group_by(activity, person) %>% summarise_each(funs(mean)))

## Step 6 Create txt file with results
write.table(sum_set, file = "sum_set.txt", append = FALSE, quote = TRUE, sep = " ",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")
