#Set the folder location.
setwd("C:/coursera/Prog_Assign/getdata_projectfiles_UCI HAR Dataset (3)/UCI HAR Dataset")

#Readin the Subjects datasets for Test and Train.
#merge subject datasets together.
        subject_test  <- read.table("test/subject_test.txt",header = FALSE)
        subject_train <- read.table("train/subject_train.txt",header = FALSE)
        Subject_both  <- rbind (subject_train,subject_test)
        colnames(Subject_both) <- "subjectId"
        

#Readin the X datasets for Test and Train.
#merge X datasets together.
        X_test  <- read.table("test/X_test.txt",header = FALSE)
        X_train <- read.table("train/X_train.txt",header = FALSE) 
        X_both  <- rbind (X_train,X_test)


#Readin the Y datasets for Test and Train.
#merge Y datasets together.
        Y_train <- read.table("train/Y_train.txt",header = FALSE) 
        Y_test  <- read.table("test/Y_test.txt",header = FALSE) 
        Y_both  <- rbind (Y_train,Y_test)
        names(Y_both) <- "activityId"

#readin features dataset that has list of all features and set column names to more descriptive names.
        #extract only mean and std in features dataset.
        features <- read.table("C:/coursera/Prog_Assign/getdata_projectfiles_UCI HAR Dataset (3)/features.txt")
        colnames(features) <-c("featuresId","featuresName")
        features_keep <- grep("-mean\\()|-std\\()",features$featuresName)
        
#readin activities_label dataset that has list of activity labels and set column names to more descriptive names.

        activity_labels <- read.table("c:/coursera/Prog_Assign/getdata_projectfiles_UCI HAR Dataset (3)/activity_labels.txt")
        colnames(activity_labels) <-c("activityId","activityName")
        
#**************************************************************************

#in X data set , keep only the features selected in features_keep and name it as X_both_keep
        X_both_keep <- X_both[,features_keep]        
        names(X_both_keep) <- features$featuresName[features_keep]
#merge Y_both with activity by Activity_id
       Y_both[,1]=activity_labels[Y_both[,1],2]
       names(Y_both) <- "activityName"
#merge all all datasets to one dataset table.     
       dataset_All <-cbind(Subject_both,Y_both,X_both_keep)
       write.csv( dataset_All, "C:/coursera/Prog_Assign/getdata_projectfiles_UCI HAR Dataset (3)/dataset.csv",row.names=FALSE)
       write.table( dataset_All, "C:/coursera/Prog_Assign/getdata_projectfiles_UCI HAR Dataset (3)/dataset.txt",row.names=FALSE)
#average of each variable for each activity and each subject.
      #get all numeric variables 
       variables <- dataset_All[, 3:dim(dataset_All)[2]] 
       dataset_Summary<- aggregate(variables, list(dataset_All$subject, dataset_All$activity), mean)
      
       names(dataset_Summary)[1] <- "SubjectId"
       names(dataset_Summary)[2] <- "ActivityName"
       write.csv( dataset_Summary, "C:/coursera/Prog_Assign/getdata_projectfiles_UCI HAR Dataset (3)/dataset_Summary.csv",row.names=FALSE)
       write.table( dataset_Summary, "C:/coursera/Prog_Assign/getdata_projectfiles_UCI HAR Dataset (3)/dataset_Summary.txt",row.names=FALSE)
