# Run_analysis script

#The data was downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

        ## Merge the training and the test sets to create one data set.

                ## Save original work directory pathway
        initialwd<-getwd()


                ## Read and assign files to variables.     
                ## Assign each test file to a new variable.      
        setwd("./test")
        Xtest<-read.table("X_test.txt")
        Ytest<-read.table("Y_test.txt")
        subjecttest<-read.table("subject_test.txt")

                ## Assign each train file to a new variable.        
        trainwd<-paste(initialwd, "/train", sep="")
        setwd(trainwd)
        Xtrain<-read.table("X_train.txt")
        Ytrain<-read.table("y_train.txt")
        subjecttrain<-read.table("subject_train.txt")
        
                ## Assign feature vector and activity labels.
        setwd(initialwd)
        features<-read.table("features.txt")
        activitylabels<-read.table("activity_labels.txt")


                ## Assign column names.
        colnames(Xtest)<-features[,2]
        colnames(Xtrain)<-features[,2]
        
        colnames(Ytrain)<-"activityId"
        colnames(Ytest)<-"activityId"
        
        colnames(subjecttest)<-"subjectId"
        colnames(subjecttrain)<-"subjectId"
        
        colnames(activitylabels)<-c("activityId","activityType")
        


                ## Merge data.

        mergetest<-cbind(Ytest, subjecttest, Xtest)
        mergetrain<-cbind(Ytrain, subjecttrain, Xtrain)
        global<-rbind(mergetrain, mergetest)        


# Extracts only the measurements on the mean and standard deviation 
# for each measurement.

        columnnames<-colnames(global)  
        mean_and_std <- (grepl("activityId" , columnnames)| 
                                 grepl("subjectId" , columnnames)| 
                                 grepl("mean.." , columnnames)| 
                                 grepl("std.." , columnnames))
        setmeanstd<-global[,mean_and_std==TRUE]

# Uses descriptive activity names to name the activities in the 
# data set.

        setactivity<-merge(setmeanstd, activitylabels,
                           by="activityId",
                           all.x=TRUE)
        


# Appropriately labels the data set with descriptive variable names.

               # Done in previous steps.


# From the data set in step 4, creates a second, independent tidy 
# data set with the average of each variable for each activity and
# each subject.

        tidyDS <- aggregate(. ~subjectId + activityId, setactivity, mean)
        tidyDS <- tidyDS[order(tidyDS$subjectId, tidyDS$activityId),]
        
        write.table(tidyDS, "TidyDataSet.txt", row.name=FALSE)
