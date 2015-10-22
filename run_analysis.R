# Analyze data from UCI Human Activity Recognition Using Smartphone
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

## Tasks
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject.

# Function to fetch the dataset
fetch_uci_data <- function(){
  data_dir = "./data"
  zipfile <- file.path("data", "uci_har_dataset.zip")
  uci_data <- file.path("data", "UCI HAR Dataset")
  file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  
  # check for data zip
  if (!file.exists(data_dir)){
    print(sprintf("Creatiing dir: %s", data_dir))
    dir.create(data_dir)
  }
  
  # check for zip and download the data
  if (!file.exists(zipfile)) {
    print(sprintf("Downloading data: %s", file_url))
    download.file(file_url, destfile=zipfile, method = "curl")
  }
  
  # unzip the uci_data
  if(!file.exists(uci_data)){
    print(sprintf("Unzipping data: %s", zipfile))
    unzip(zipfile, exdir = data_dir)
  }
  
  print(sprintf("UCI Data : %s", uci_data))
}

merge_data <- function(subdir) {
  # check for uci dir
  uci_data <- file.path("data", "UCI HAR Dataset")
  if (!file.exists(uci_data)){
    stop(sprintf("Could not find the UCI HAR Dataset directory : %s", uci_data))
  }
  
  # read features names
  features_df <- read.table(file.path(uci_data, "features.txt"), 
                            col.names = c("feature_id", "feature_name"))

  feature_names <- features_df[,"feature_name"]
  
  # read data
  x_df <- read.table(file.path(uci_data, subdir, sprintf("X_%s.txt", subdir)), 
                          col.names = feature_names)
  
  # Extract only the measurements on the mean and standard deviation for each measurement.
  # select columns containing std() and mean()
  df_colnames <- colnames(x_df)
  idx <- grep("mean()", df_colnames)
  mean_cols <- df_colnames[idx]
  idx <- grep("std()", df_colnames)
  std_cols <- df_colnames[idx]
  filter_cols <- c(mean_cols, std_cols)
  
  # overwrite df with fewer cols
  x_df = x_df[,filter_cols]

  x_test_subject_df <- read.table(file.path(uci_data, subdir, sprintf("subject_%s.txt", subdir)),
                                  col.names = c("subject"))
  
  # read activities
  y_df <- read.table(file.path(uci_data, subdir, sprintf("y_%s.txt", subdir)),
                          col.names = c("activity"))
  
  # convert activity ID to a factor variable
  labels = read.table(file.path(uci_data, "activity_labels.txt"), 
                      col.names = c("id", "name"))
  y_df$activity <- factor(y_df$activity, labels$id, labels$name)
  
  # cbind all rows
  df = cbind(x_df, x_test_subject_df, y_df)

  # return data with all rows
  df
}
  
merge_test_train_data <- function(){
  
  # 1. Merge the training and the test sets to create one data set.
  x_train_df = merge_data("train")
  x_test_df = merge_data("test")
  # concatenate train and test data
  all_df <- rbind(x_train_df, x_test_df)
  
  # return data.frame with merged test/train dataset
  print(sprintf("NROWs train/test/merged : %d/%d/%d. NCOLs : %d", 
                nrow(x_train_df), 
                nrow(x_test_df),
                nrow(all_df),
                ncol(all_df)))

  # 3. Uses descriptive activity names to name the activities in the data set
  # TODO: update the activity column with values from 
  #   cat data/UCI\ HAR\ Dataset/activity_labels.txt
  #   1 WALKING
  #   2 WALKING_UPSTAIRS
  #   3 WALKING_DOWNSTAIRS
  #   4 SITTING
  #   5 STANDING
  #   6 LAYING
  all_df
}
  


