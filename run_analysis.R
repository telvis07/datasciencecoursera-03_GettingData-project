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
  
  # read test data
  x_df <- read.table(file.path(uci_data, subdir, sprintf("X_%s.txt", subdir)), 
                          col.names = feature_names)

  x_test_subject_df <- read.table(file.path(uci_data, subdir, sprintf("subject_%s.txt", subdir)),
                                  col.names = c("subject"))
  
  y_df <- read.table(file.path(uci_data, subdir, sprintf("y_%s.txt", subdir)),
                          col.names = c("activity"))
  
  test_df = cbind(x_df, x_test_subject_df, y_df)
  
  test_df
}
  
concat_test_train_data <- function(){
  x_train_df = merge_data("train")
  x_test_df = merge_data("test")
  # concatenate train and test data
  all_df <- rbind(x_train_df, x_test_df)
  
  # return data.frame with merged test/train dataset
  print(sprintf("NROWs train/test/merged : %d/%d/%d", 
                nrow(x_train_df), 
                nrow(x_test_df),
                nrow(all_df)))
  all_df
}
  


