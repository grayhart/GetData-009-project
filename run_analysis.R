# Course Project R Script - run_analysis.R


# 1.Merge the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.From the data set in step 4, creates a second, independent tidy data 
#   set with the average of each variable for each activity and each subject.

# Load Libraries used in the program
library(dplyr)
library(reshape2)

# Step 1. 
# Merge Traing and Test sets to create one data set

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
        

# STEP 2.
# Extract only the measurements on the mean and standard deviation for each measurement. 

        # features.txt contains the list of measurements, each one corresponding to a column in the 
        # x data files
        #
        # Search and identify each feature containing mean or std deviation and extract only those
        # columns.
        
        # Set the column names of the merged dataset using the second column of the features dataset
        #    which contains the names of the features.

        # Use grep() on the features dataset to get all featurenames which contain the 
        # string "mean" or the string "std" regardless of case. 
        # Pass the result of the grep into a select from the dplyr package to filter
        # the equivalent columns and save to a new data set X_MeanSTD
        X_MeanSTD<-select(X_merge,grep("std|mean",features[,2],ignore.case=TRUE))
        
        
# STEP 3.
# Uses descriptive activity names to name the activities in the data set

        # Each row in the merged Y dataset contains the activity number for the 
        # equivalent row in the merged dataset.
        #
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
        
        
        
# STEP 4.
# Appropriately labels the data set with descriptive variable names. 

        # Use grep in the same way as step(2) to get the column names with std and mean
        # and use them as the column names in the Means/STD dataset
        # The names will be fully tidied as part of Step 5. 
        colnames(X_MeanSTD)<-features[grep("std|mean",features[,2],ignore.case=TRUE),2]
        
        
# STEP 5.
# From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.

        # Use CBind to add the Subject data and activity as columns in the main table
        X_MeanSTD<-cbind(Y_merge$ActivityName,X_MeanSTD)
        X_MeanSTD<-cbind(Subject_merge,X_MeanSTD)
                
        # Set the new column names to be Subject and ActivityName
        colnames(X_MeanSTD)[1] <- "Subject"
        colnames(X_MeanSTD)[2] <- "ActivityName"
        
        # Change the Subject column to a factor 
        X_MeanSTD$Subject<-as.factor(X_MeanSTD$Subject)

        # Generate the Tidy Data set by melting all measurements into a single column 
        # and then cast and average them all to produce the required dataset

        # Melt the data as an interim step 
        MeltData<-melt(X_MeanSTD,id=c("Subject","ActivityName"),measure.vars=colnames(X_MeanSTD[3:ncol(X_MeanSTD)]))

        # Use dcast to calculate the means from the molten data
        TidyData<-dcast(MeltData, Subject + ActivityName ~ variable,mean)
        

        # Tidy the column names:
        # 1.Change the 't' and 'f' at the start of variables to "time" and "frequency"
        # 2.Delete any occurences of '()' 
        # 3.Remove any invaild characters 
        # 4.Add "mean.of" to the front of all columns which now contain the means.

        # Change entries beginning with t to begin with time
        colnames(TidyData)[3:ncol(TidyData)]<-sub("^t","time",colnames(TidyData)[3:ncol(TidyData)])
        
        # Change entries beginning with f to begin with frequency
        colnames(TidyData)[3:ncol(TidyData)]<-sub("^f","frequency",colnames(TidyData)[3:ncol(TidyData)])

        # Remove occurences of () (need to use gsub to catch all occurences)
        colnames(TidyData)[3:ncol(TidyData)]<-gsub("[(][)]","",colnames(TidyData)[3:ncol(TidyData)])

        # Use make.names to clean out any remaining non allowed characters in all column names
        colnames(TidyData)<-make.names(colnames(TidyData),unique=TRUE,allow_=FALSE)

        # Add "Mean of" in front of all summary column names (from column 3 onwards)
        colnames(TidyData)[3:ncol(TidyData)]<-paste("Mean.of",colnames(TidyData)[3:ncol(TidyData)],sep="." )


        # Write out the data to a file for uploading to the
        # To read back in, use 
        #       readTidyData<-read.table("tidydata.txt",header=TRUE)

        write.table(TidyData, file="tidydata.txt", row.name=FALSE)

        