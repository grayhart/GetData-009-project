# README for Coursera "Getting and Cleaning Data" course project

## Course Project R Script - run_analysis.R

### Data Manipulation Steps within Script

The following steps were used to create the final tidy data:
* Merge the Train datasets and the Test datasets
* Extract only those variables containing the string "std" or "mean" in whichever case mix they appear.
  * Use grep to identify the columns
  * Use dplyr select to subset the data
* Added ActivityName field to the Y merged dataset and populate it using the Text names of the activities
* Add Column headers to merged X dataset using the field names provided in the features dataset.
* Prepare the Tidy Data
  * Add Subject and ActivityName columns to the front of the Dataset. Change Subject to be a factor
  * Melt the dataset to create a variable with all features for each Subject and ActivityName
  * Use dcast to summarise features and create means for each Subject and ActivityName
* Tidy the column names
  * change column prefixes from 't' to 'time and 'f' to 'frequency'
  * remove occurences of '()'
  * use make.names() to make valid column names for all columns
* Write the tidy data out to a tidy dataset
  * The data should be read back in using  ```{r}readTidyData<-read.table("tidydata.txt",header=TRUE)```

### Course Project R Script - run_analysis.R

Steps
1.Merge the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#### STEP 1.Merge Train and Test sets to create one data set
Read in the X, Y and Subject datasets from the train and the test folders. Combine them using rbind.
Read in the features and activity labels datasets


#### STEP 2.Extract only the measurements on the mean and standard deviation for each measurement. 

The features dataset contains the list of measurements, each one corresponding to a column in the x data files.

Search and identify each feature containing mean or std deviation and extract only those columns.
        
Set the column names of the merged dataset using the second column of the features dataset which contains the names of the features.

Use grep() on the features dataset to get all featurenames which contain the string "mean" or the string "std" regardless of case. Pass the result of the grep into a select from the dplyr package to filter the equivalent columns and save to a new data set X_MeanSTD
        
        
#### STEP 3. Uses descriptive activity names to name the activities in the data set

Each row in the merged Y dataset contains the activity number for the equivalent row in the merged dataset.

This code adds a new column called ActivityName and then sets the values of the column based on the Activity entries. As we only have a few Activities, I'll add them individually

The variable needs to be a factor for later stages so it is converted here.
        
#### STEP 4.Appropriately labels the data set with descriptive variable names. 

Use grep in the same way as step(2) to get the column names with std and mean and use them as the column names in the Means/STD dataset

As long as the same grep statement is used here as in step 2, the same column names in the same order will be produced.

        
#### STEP 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Use CBind to add the Subject data and activity as columns in the main table
                
Set the new column names to be Subject and ActivityName
        
Change the Subject column to a factor 


Melt the data as an interim step. This produces a narrow table with a row for each measurement per activity per subject.

Use dcast to calculate the means from the molten data. This takes the presviously melted dataset and uses it to summarise the measurements using mean. The results will be shown in a table with a row for each activity for each user. A column is created for each mean of each measurement 

Tidy the column names:
1. Change the 't' and 'f' at the start of variables to "time" and "frequency". This uses 'sub' with a regular expression to find column names starting with t or starting with f. 
2. Delete any occurences of '()'. This uses gsub to make sure all occurrences are replaced. 
3. Remove any invaild characters. This uses maake.names which produces names consisting only of valid R characters. It also makes sure each column name is unique.
4. The columns now contain the means of the measurements so the name needs to reflect that. Add "mean.of" to the front of all columns which now contain the means. This uses paste to add "Mean of" to the front of each variable. The spearator of '.' is used because space is not a valid R character. 


Write out the data to a file for uploading to Coursera.
To read back in, use:
```{r}readTidyData<-read.table("tidydata.txt",header=TRUE)```
        
        
