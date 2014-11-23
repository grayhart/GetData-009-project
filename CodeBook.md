# Code Book for Coursera "Getting and Cleaning Data" course project

## Original data
The description of the original project can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original data for the project can be downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Final Data
The final data is an independent tidy data set with the average of each variable for each activity and each subject.
The R code used to create the tidy dataset are in run_analysis.R which can be run to recreate the tidy dataset

## Data Manipulation
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
  * Numeric
7. Mean.of.timeBodyAcc.std.Y                    
  * Numeric
8. Mean.of.timeBodyAcc.std.Z                    
  * Numeric
9. Mean.of.timeGravityAcc.mean.X                
  * Numeric
10. Mean.of.timeGravityAcc.mean.Y                
  * Numeric
11. Mean.of.timeGravityAcc.mean.Z                
  * Numeric
12. Mean.of.timeGravityAcc.std.X                 
  * Numeric
13. Mean.of.timeGravityAcc.std.Y                 
  * Numeric
14. Mean.of.timeGravityAcc.std.Z                 
  * Numeric
15. Mean.of.timeBodyAccJerk.mean.X               
  * Numeric
16. Mean.of.timeBodyAccJerk.mean.Y               
  * Numeric
17. Mean.of.timeBodyAccJerk.mean.Z               
  * Numeric
18. Mean.of.timeBodyAccJerk.std.X                
  * Numeric
19. Mean.of.timeBodyAccJerk.std.Y                
  * Numeric
20. Mean.of.timeBodyAccJerk.std.Z                
  * Numeric
21. Mean.of.timeBodyGyro.mean.X                  
  * Numeric
22. Mean.of.timeBodyGyro.mean.Y                  
  * Numeric
23. Mean.of.timeBodyGyro.mean.Z                  
  * Numeric
24. Mean.of.timeBodyGyro.std.X                   
  * Numeric
25. Mean.of.timeBodyGyro.std.Y                   
  * Numeric
26. Mean.of.timeBodyGyro.std.Z                   
  * Numeric
27. Mean.of.timeBodyGyroJerk.mean.X              
  * Numeric
28. Mean.of.timeBodyGyroJerk.mean.Y              
  * Numeric
29. Mean.of.timeBodyGyroJerk.mean.Z              
  * Numeric
30. Mean.of.timeBodyGyroJerk.std.X               
  * Numeric
31. Mean.of.timeBodyGyroJerk.std.Y               
  * Numeric
32. Mean.of.timeBodyGyroJerk.std.Z               
  * Numeric
33. Mean.of.timeBodyAccMag.mean                  
  * Numeric
34. Mean.of.timeBodyAccMag.std                   
  * Numeric
35. Mean.of.timeGravityAccMag.mean               
  * Numeric
36. Mean.of.timeGravityAccMag.std                
  * Numeric
37. Mean.of.timeBodyAccJerkMag.mean              
  * Numeric
38. Mean.of.timeBodyAccJerkMag.std               
  * Numeric
39. Mean.of.timeBodyGyroMag.mean                 
  * Numeric
40. Mean.of.timeBodyGyroMag.std                  
  * Numeric
41. Mean.of.timeBodyGyroJerkMag.mean             
  * Numeric
42. Mean.of.timeBodyGyroJerkMag.std              
  * Numeric
43. Mean.of.frequencyBodyAcc.mean.X              
  * Numeric
44. Mean.of.frequencyBodyAcc.mean.Y              
  * Numeric
45. Mean.of.frequencyBodyAcc.mean.Z              
  * Numeric
46. Mean.of.frequencyBodyAcc.std.X               
  * Numeric
47. Mean.of.frequencyBodyAcc.std.Y               
  * Numeric
48. Mean.of.frequencyBodyAcc.std.Z               
  * Numeric
49. Mean.of.frequencyBodyAcc.meanFreq.X          
  * Numeric
50. Mean.of.frequencyBodyAcc.meanFreq.Y          
  * Numeric
51. Mean.of.frequencyBodyAcc.meanFreq.Z          
  * Numeric
52. Mean.of.frequencyBodyAccJerk.mean.X          
  * Numeric
53. Mean.of.frequencyBodyAccJerk.mean.Y          
  * Numeric
54. Mean.of.frequencyBodyAccJerk.mean.Z          
  * Numeric
55. Mean.of.frequencyBodyAccJerk.std.X           
  * Numeric
56. Mean.of.frequencyBodyAccJerk.std.Y           
  * Numeric
57. Mean.of.frequencyBodyAccJerk.std.Z           
  * Numeric
58. Mean.of.frequencyBodyAccJerk.meanFreq.X      
  * Numeric
59. Mean.of.frequencyBodyAccJerk.meanFreq.Y      
  * Numeric
60. Mean.of.frequencyBodyAccJerk.meanFreq.Z      
  * Numeric
61. Mean.of.frequencyBodyGyro.mean.X             
  * Numeric
62. Mean.of.frequencyBodyGyro.mean.Y             
  * Numeric
63. Mean.of.frequencyBodyGyro.mean.Z             
  * Numeric
64. Mean.of.frequencyBodyGyro.std.X              
  * Numeric
65. Mean.of.frequencyBodyGyro.std.Y              
  * Numeric
66. Mean.of.frequencyBodyGyro.std.Z              
  * Numeric
67. Mean.of.frequencyBodyGyro.meanFreq.X         
  * Numeric
68. Mean.of.frequencyBodyGyro.meanFreq.Y         
  * Numeric
69. Mean.of.frequencyBodyGyro.meanFreq.Z         
  * Numeric
70. Mean.of.frequencyBodyAccMag.mean             
  * Numeric
71. Mean.of.frequencyBodyAccMag.std              
  * Numeric
72. Mean.of.frequencyBodyAccMag.meanFreq         
  * Numeric
73. Mean.of.frequencyBodyBodyAccJerkMag.mean     
  * Numeric
74. Mean.of.frequencyBodyBodyAccJerkMag.std      
  * Numeric
75. Mean.of.frequencyBodyBodyAccJerkMag.meanFreq 
  * Numeric
76. Mean.of.frequencyBodyBodyGyroMag.mean        
  * Numeric
77. Mean.of.frequencyBodyBodyGyroMag.std         
  * Numeric
78. Mean.of.frequencyBodyBodyGyroMag.meanFreq    
  * Numeric
79. Mean.of.frequencyBodyBodyGyroJerkMag.mean    
  * Numeric
80. Mean.of.frequencyBodyBodyGyroJerkMag.std     
  * Numeric
81. Mean.of.frequencyBodyBodyGyroJerkMag.meanFreq
  * Numeric
82. Mean.of.angle.tBodyAccMean.gravity.          
  * Numeric
83. Mean.of.angle.tBodyAccJerkMean..gravityMean. 
  * Numeric
84. Mean.of.angle.tBodyGyroMean.gravityMean.     
  * Numeric
85. Mean.of.angle.tBodyGyroJerkMean.gravityMean. 
  * Numeric
86. Mean.of.angle.X.gravityMean.                 
  * Numeric
87. Mean.of.angle.Y.gravityMean.                 
  * Numeric
88. Mean.of.angle.Z.gravityMean.
  * Numeric
