The `run_analysis.R` script generates an independent tidy data set with the average of each variable
for each activity and each subject.

## Variables

Factor Columns

- subject : id for human that performed activities
- activity : factor (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 

The tidy data has the mean() for each of the following measurements for each (subject,activity) pair.
See the [UCI HAR Dataset/features_info.txt](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) for more
details about the measurements.

- tBodyAccelerometerMeanX
- tBodyAccelerometerMeanY
- tBodyAccelerometerMeanZ
- tGravityAccelerometerMeanX
- tGravityAccelerometerMeanY
- tGravityAccelerometerMeanZ
- tBodyAccelerometerJerkMeanX
- tBodyAccelerometerJerkMeanY
- tBodyAccelerometerJerkMeanZ
- tBodyGyroscopeMeanX
- tBodyGyroscopeMeanY
- tBodyGyroscopeMeanZ
- tBodyGyroscopeJerkMeanX
- tBodyGyroscopeJerkMeanY
- tBodyGyroscopeJerkMeanZ
- tBodyAccelerometerMagnitudeMean
- tGravityAccelerometerMagnitudeMean
- tBodyAccelerometerJerkMagnitudeMean
- tBodyGyroscopeMagnitudeMean
- tBodyGyroscopeJerkMagnitudeMean
- fBodyAccelerometerMeanX
- fBodyAccelerometerMeanY
- fBodyAccelerometerMeanZ
- fBodyAccelerometerJerkMeanX
- fBodyAccelerometerJerkMeanY
- fBodyAccelerometerJerkMeanZ
- fBodyGyroscopeMeanX
- fBodyGyroscopeMeanY
- fBodyGyroscopeMeanZ
- fBodyAccelerometerMagnitudeMean
- fBodyBodyAccelerometerJerkMagnitudeMean
- fBodyBodyGyroscopeMagnitudeMean
- fBodyBodyGyroscopeJerkMagnitudeMean
- angletBodyAccelerometerMean.gravity
- angletBodyAccelerometerJerkMean.gravityMean.
- angletBodyGyroscopeMean.gravityMean
- angletBodyGyroscopeJerkMean.gravityMean
- angleX.gravityMean
- angleY.gravityMean
- angleZ.gravityMean
- tBodyAccelerometerStandardDeviationX
- tBodyAccelerometerStandardDeviationY
- tBodyAccelerometerStandardDeviationZ
- tGravityAccelerometerStandardDeviationX
- tGravityAccelerometerStandardDeviationY
- tGravityAccelerometerStandardDeviationZ
- tBodyAccelerometerJerkStandardDeviationX
- tBodyAccelerometerJerkStandardDeviationY
- tBodyAccelerometerJerkStandardDeviationZ
- tBodyGyroscopeStandardDeviationX
- tBodyGyroscopeStandardDeviationY
- tBodyGyroscopeStandardDeviationZ
- tBodyGyroscopeJerkStandardDeviationX
- tBodyGyroscopeJerkStandardDeviationY
- tBodyGyroscopeJerkStandardDeviationZ
- tBodyAccelerometerMagnitudeStandardDeviation
- tGravityAccelerometerMagnitudeStandardDeviation
- tBodyAccelerometerJerkMagnitudeStandardDeviation
- tBodyGyroscopeMagnitudeStandardDeviation
- tBodyGyroscopeJerkMagnitudeStandardDeviation
- fBodyAccelerometerStandardDeviationX
- fBodyAccelerometerStandardDeviationY
- fBodyAccelerometerStandardDeviationZ
- fBodyAccelerometerJerkStandardDeviationX
- fBodyAccelerometerJerkStandardDeviationY
- fBodyAccelerometerJerkStandardDeviationZ
- fBodyGyroscopeStandardDeviationX
- fBodyGyroscopeStandardDeviationY
- fBodyGyroscopeStandardDeviationZ
- fBodyAccelerometerMagnitudeStandardDeviation
- fBodyBodyAccelerometerJerkMagnitudeStandardDeviation
- fBodyBodyGyroscopeMagnitudeStandardDeviation
- fBodyBodyGyroscopeJerkMagnitudeStandardDeviation

## Data

- Raw dataset: [UCI HAR Dataset/features_info.txt](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
- Tidy Dataset [See tidy_uci_dataset.txt](tidy_uci_dataset.txt)

## Transformations from Raw to Tidy

1. Modify feature names to be [syntactically valid column names](https://stat.ethz.ch/R-manual/R-devel/library/base/html/make.names.html)
2. Merge measurements data, subject and activity into 1 data set
3. Perform #2 for both test and train. 
4. Concatenate test and train data
5. Subselect the Mean and Standard Deviation Measurements.
6. Generate Tidy Data with the average of each variable for each activity and each subject.
7. Write tidy data to `tidy_uci_dataset.txt` using write.table() with row.names = FALSE
