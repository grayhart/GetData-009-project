# Code Book for Coursera "Getting and Cleaning Data" course project

## Original data
The description of the original project can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original data for the project can be downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Final Data
The final data is an independent tidy data set with the average of each variable for each activity and each subject.
The R code used to create the tidy dataset are in run_analysis.R which can be run to recreate the tidy dataset

## Data Maniuplation
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

## Data Columns
### Non Mean Columns

1. Subject   
        Indicates which of the 30 subjects the row refers to
  * Factor with values from  1-30 
2. ActivityName
        Indicates the name of the Activity that was being performed
        Factor with the folowing values:
  * "WALKING"
  * "WALKING_UPSTAIRS"
  * "WALKING_DOWNSTAIRS"
  * "SITTING"
  * "STANDING"
  * "LAYING"
### Mean Columns
All of the following columns are means of the equivalent features in the original data set. All are numeric

3. Mean.of.timeBodyAcc.mean.X
  * Numeric
4. Mean.of.timeBodyAcc.mean.Y                   
  * Numeric
5. Mean.of.timeBodyAcc.mean.Z                   
  * Numeric
6. Mean.of.timeBodyAcc.std.X                    
7. Mean.of.timeBodyAcc.std.Y                    
8. Mean.of.timeBodyAcc.std.Z                    
9. Mean.of.timeGravityAcc.mean.X                
10. Mean.of.timeGravityAcc.mean.Y                
11. Mean.of.timeGravityAcc.mean.Z                
12. Mean.of.timeGravityAcc.std.X                 
13. Mean.of.timeGravityAcc.std.Y                 
14. Mean.of.timeGravityAcc.std.Z                 
15. Mean.of.timeBodyAccJerk.mean.X               
16. Mean.of.timeBodyAccJerk.mean.Y               
17. Mean.of.timeBodyAccJerk.mean.Z               
18. Mean.of.timeBodyAccJerk.std.X                
19. Mean.of.timeBodyAccJerk.std.Y                
20. Mean.of.timeBodyAccJerk.std.Z                
21. Mean.of.timeBodyGyro.mean.X                  
22. Mean.of.timeBodyGyro.mean.Y                  
23. Mean.of.timeBodyGyro.mean.Z                  
24. Mean.of.timeBodyGyro.std.X                   
25. Mean.of.timeBodyGyro.std.Y                   
26. Mean.of.timeBodyGyro.std.Z                   
27. Mean.of.timeBodyGyroJerk.mean.X              
28. Mean.of.timeBodyGyroJerk.mean.Y              
29. Mean.of.timeBodyGyroJerk.mean.Z              
30. Mean.of.timeBodyGyroJerk.std.X               
31. Mean.of.timeBodyGyroJerk.std.Y               
32. Mean.of.timeBodyGyroJerk.std.Z               
33. Mean.of.timeBodyAccMag.mean                  
34. Mean.of.timeBodyAccMag.std                   
35. Mean.of.timeGravityAccMag.mean               
36. Mean.of.timeGravityAccMag.std                
37. Mean.of.timeBodyAccJerkMag.mean              
38. Mean.of.timeBodyAccJerkMag.std               
39. Mean.of.timeBodyGyroMag.mean                 
40. Mean.of.timeBodyGyroMag.std                  
41. Mean.of.timeBodyGyroJerkMag.mean             
42. Mean.of.timeBodyGyroJerkMag.std              
43. Mean.of.frequencyBodyAcc.mean.X              
44. Mean.of.frequencyBodyAcc.mean.Y              
45. Mean.of.frequencyBodyAcc.mean.Z              
46. Mean.of.frequencyBodyAcc.std.X               
47. Mean.of.frequencyBodyAcc.std.Y               
48. Mean.of.frequencyBodyAcc.std.Z               
49. Mean.of.frequencyBodyAcc.meanFreq.X          
50. Mean.of.frequencyBodyAcc.meanFreq.Y          
51. Mean.of.frequencyBodyAcc.meanFreq.Z          
52. Mean.of.frequencyBodyAccJerk.mean.X          
53. Mean.of.frequencyBodyAccJerk.mean.Y          
54. Mean.of.frequencyBodyAccJerk.mean.Z          
55. Mean.of.frequencyBodyAccJerk.std.X           
56. Mean.of.frequencyBodyAccJerk.std.Y           
57. Mean.of.frequencyBodyAccJerk.std.Z           
58. Mean.of.frequencyBodyAccJerk.meanFreq.X      
59. Mean.of.frequencyBodyAccJerk.meanFreq.Y      
60. Mean.of.frequencyBodyAccJerk.meanFreq.Z      
61. Mean.of.frequencyBodyGyro.mean.X             
62. Mean.of.frequencyBodyGyro.mean.Y             
63. Mean.of.frequencyBodyGyro.mean.Z             
64. Mean.of.frequencyBodyGyro.std.X              
65. Mean.of.frequencyBodyGyro.std.Y              
66. Mean.of.frequencyBodyGyro.std.Z              
67. Mean.of.frequencyBodyGyro.meanFreq.X         
68. Mean.of.frequencyBodyGyro.meanFreq.Y         
69. Mean.of.frequencyBodyGyro.meanFreq.Z         
70. Mean.of.frequencyBodyAccMag.mean             
71. Mean.of.frequencyBodyAccMag.std              
72. Mean.of.frequencyBodyAccMag.meanFreq         
73. Mean.of.frequencyBodyBodyAccJerkMag.mean     
74. Mean.of.frequencyBodyBodyAccJerkMag.std      
75. Mean.of.frequencyBodyBodyAccJerkMag.meanFreq 
76. Mean.of.frequencyBodyBodyGyroMag.mean        
77. Mean.of.frequencyBodyBodyGyroMag.std         
78. Mean.of.frequencyBodyBodyGyroMag.meanFreq    
79. Mean.of.frequencyBodyBodyGyroJerkMag.mean    
80. Mean.of.frequencyBodyBodyGyroJerkMag.std     
81. Mean.of.frequencyBodyBodyGyroJerkMag.meanFreq
82. Mean.of.angle.tBodyAccMean.gravity.          
83. Mean.of.angle.tBodyAccJerkMean..gravityMean. 
84. Mean.of.angle.tBodyGyroMean.gravityMean.     
85. Mean.of.angle.tBodyGyroJerkMean.gravityMean. 
86. Mean.of.angle.X.gravityMean.                 
87. Mean.of.angle.Y.gravityMean.                 
88. Mean.of.angle.Z.gravityMean.