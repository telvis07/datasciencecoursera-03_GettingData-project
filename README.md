Course project for [Course project for Coursera/Data Science Specialization/Getting Data](https://www.coursera.org/course/getdata)

# Summary
Analyze data from UCI Human Activity Recognition Using Smartphone

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

## Problem Summary
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called `run_analysis.R` that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Running the Code

### To fetch the code
    
    git clone git@github.com:telvis07/datasciencecoursera-03_GettingData-project.git
    cd datasciencecoursera-03_GettingData-project

### To run the scripts in R

    setwd("/path/to/datasciencecoursera-03_GettingData-project")
    source("run_analysis.R")
    df <- run_analysis_main()

### To load the tidy data

    df <- read.table("tidy_uci_dataset.txt", header=TRUE)

## Output

See [Code Book](CodeBook.md)
    
