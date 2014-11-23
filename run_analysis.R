# Course Project R Script - run_analysis.R
# 1.Merge the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.From the data set in step 4, creates a second, independent tidy data 
#   set with the average of each variable for each activity and each subject.

# Step 1. 
# Merge Traing and Test sets to create one data set

# Load Libraries used in the program

library(dplyr)
library(reshape2)

# step1_merge<-function() {

        # Read in the train data
        X_train<-read.table("UCI HAR Dataset\\train\\X_train.txt")
        Y_train<-read.table("UCI HAR Dataset\\train\\Y_train.txt")
        Subject_train<-read.table("UCI HAR Dataset\\train\\subject_train.txt")
        
        # Read in the test data
        X_test<-read.table("UCI HAR Dataset\\test\\X_test.txt")
        Y_test<-read.table("UCI HAR Dataset\\test\\Y_test.txt")
        Subject_test<-read.table("UCI HAR Dataset\\test\\subject_test.txt")
        
        # Create a merged set of files using rbind
        X_merge <- rbind(X_train, X_test)
        Y_merge<- rbind(Y_train, Y_test)
        Subject_merge<- rbind(Subject_train, Subject_test)

        # Read the features and activity labels 
        features<-read.table("UCI HAR Dataset\\features.txt")
        activity_labels<-read.table("UCI HAR Dataset\\activity_labels.txt")
        
#}

        # STEP 2.Extract only the measurements on the mean and standard deviation for each measurement. 
        #
        #       features.txt contains the list of measurements, each one corresponding to a column in the 
        #       x data files
        #
        # Search and identify each feature containing mean or std deviation and extract only those
        # columns.
        
        # Set the column names of the merged dataset using the second column of the features dataset
        #    which contains the names of the features.

        # Use grep() on the features dataset to get all featurenames which contain the 
        # string "mean" or the string "std" regardless of case. 
        # Pass the result of the grep into a select from the dplyr package to filter
        # the equivalent columns
        X_MeanSTD<-select(X_merge,grep("std|mean",features[,2],ignore.case=TRUE))
        
        
        # 3.Uses descriptive activity names to name the activities in the data set
        # This code adds a new column called ActivityName and then sets the values 
        # of the column based on the Activity entries. As we only have a few Activities,
        # I'll add them individually
        Y_merge$ActivityName <- "WALKING"
        Y_merge$ActivityName[Y_merge$V1==2] <- "WALKING_UPSTAIRS"
        Y_merge$ActivityName[Y_merge$V1==3] <- "WALKING_DOWNSTAIRS"
        Y_merge$ActivityName[Y_merge$V1==4] <- "SITTING"
        Y_merge$ActivityName[Y_merge$V1==5] <- "STANDING"
        Y_merge$ActivityName[Y_merge$V1==6] <- "LAYING"
        
        # Make the column a factor variable
        Y_merge$ActivityName<-as.factor(Y_merge$ActivityName)
        
        
        
        # 4.Appropriately labels the data set with descriptive variable names. 
        # Use grep in the same way as step(2) to get the column names with std and mean
        # and use them as the column names in the Means/STD dataset
        colnames(X_MeanSTD)<-features[grep("std|mean",features[,2],ignore.case=TRUE),2]
        
        
        # 5.From the data set in step 4, creates a second, independent tidy data 
        #   set with the average of each variable for each activity and each subject.
        # 
        # Add the Subject data and activity as columns in he main table
        X_MeanSTD<-cbind(Y_merge$ActivityName,X_MeanSTD)
        X_MeanSTD<-cbind(Subject_merge,X_MeanSTD)
        
        
        # Set the column name to be Subject and ActivityName
        colnames(X_MeanSTD)[1] <- "Subject"
        colnames(X_MeanSTD)[2] <- "ActivityName"
        
        # Change the Subject column to a factor 
        X_MeanSTD$Subject<-as.factor(X_MeanSTD$Subject)
        # Melt the data as an interim step 
        MeltData<-melt(X_MeanSTD,id=c("Subject","ActivityName"),measure.vars=colnames(X_MeanSTD[3:ncol(X_MeanSTD)]))

        # Use dcast to calculate the means from the molten data
        TidyData<-dcast(MeltData, Subject + ActivityName ~ variable,mean)
        
        # Add "Mean of" in front of all summary column names (from column 3 onwards)
        colnames(TidyData)[3:ncol(TidyData)]<-paste("Mean of",colnames(TidyData)[3:ncol(TidyData)] )
        