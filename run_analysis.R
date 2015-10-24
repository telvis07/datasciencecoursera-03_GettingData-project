# Analyze data from UCI Human Activity Recognition Using Smartphone
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

library(reshape2)


fix_colnames <- function(colnames){
  # change column names to something acceptable to make.names()
  # The code replaces the 'pattern_values' with 'replace_values'.
  # Args:
  #  colnames : vector of colnames
  # Return
  #  vector of column names after modification
  
  # search patterns for grep()
  pattern_values <- c(
    "Acc",
    "Gyro",
    "Mag",
    "mean\\(\\)", #: Mean value
    "std\\(\\)", #: Standard deviation
    "mad\\(\\)", #: Median absolute deviation 
    "max\\(\\)", #: Largest value in array
    "min\\(\\)", #: Smallest value in array
    "sma\\(\\)", # Signal magnitude area
    "\\(",
    "\\)"
  )
  
  # replace values for sub() corresponding to an entry in 'pattern_values'
  replace_values <- c(
    "Accelerometer",
    "Gyroscope",
    "Magnitude",
    "Mean",
    "StandardDeviation",
    "MedianAbsoluteDeviation",
    "Maximum",
    "Minimum",
    "SignalMagnitudeArea",
    "",
    ""
  )
  
  search_replace_df = data.frame(pattern=pattern_values,
                                 replace=replace_values)
  out <- vector()

  for (i in seq(length(colnames))){
    cname_fixed <- colnames[i]
    for (j in seq(nrow(search_replace_df))){
      print (sprintf("[fix_colnames] search / replace / string : %s / %s / %s", 
                     search_replace_df[j, "pattern"],
                     search_replace_df[j, "replace"],
                     cname_fixed),
             max=1024)
      if (grepl(search_replace_df[j, "pattern"], cname_fixed)){
        cname_fixed <- sub(search_replace_df[j, "pattern"], 
                           search_replace_df[j, "replace"],
                           cname_fixed)
        print(sprintf("[fix_colnames] before / fixed %s / %s", colnames[i], cname_fixed))
      }
    }
    # replace dashes
    cname_fixed <- gsub("[-]","",cname_fixed)
    out <- c(out, cname_fixed)
  }
  
  out
}

fetch_uci_data <- function(data_dir="./"){
  # Function to fetch the dataset
  
  zipfile <- file.path(data_dir, "uci_har_dataset.zip")
  uci_data <- file.path(data_dir, "UCI HAR Dataset")
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

merge_data <- function(subdir, data_dir="./") {
  # check for uci dir
  uci_data <- file.path(data_dir, "UCI HAR Dataset")
  if (!file.exists(uci_data)){
    stop(sprintf("Could not find the UCI HAR Dataset directory : %s", uci_data))
  }
  
  # read features names
  features_df <- read.table(file.path(uci_data, "features.txt"), 
                            col.names = c("feature_id", "feature_name"))

  feature_names <- fix_colnames(features_df[,"feature_name"])
  # print (feature_names)
  
  # read data
  x_df <- read.table(file.path(uci_data, subdir, sprintf("X_%s.txt", subdir)), 
                          col.names = feature_names)

  # Extract only the measurements on the mean and standard deviation for each measurement.
  # select columns containing std() and mean()
  df_colnames <- colnames(x_df)
  idx <- grep("Mean", df_colnames)
  mean_cols <- df_colnames[idx]
  idx <- grep("StandardDeviation", df_colnames)
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
  # Merge the training and the test sets to create one data set.
  
  # merge the train data
  x_train_df = merge_data("train")
  
  # merge the train data
  x_test_df = merge_data("test")
  
  # concatenate train and test data
  all_df <- rbind(x_train_df, x_test_df)
  
  print(sprintf("NROWs train/test/merged : %d/%d/%d. NCOLs : %d", 
                nrow(x_train_df), 
                nrow(x_test_df),
                nrow(all_df),
                ncol(all_df)))

  # return data.frame with merged test/train dataset
  all_df
}

make_tidy_data <- function(df){
  # creates a second, independent tidy data set with the average of each variable
  # for each activity and each subject.
  
  # get 'factor' columns 
  factor_cols <- c('activity', 'subject')
  
  # get measurment columns (i.e. not the 'factor' columns)
  measure_cols <- df_cols[!df_cols %in% c('activity', 'subject')]

  # melt the data, so we can summarize it.
  melt_df <- melt(df, id=factor_cols, measure.vars = measure_cols)
  
  # Show the mean for each measurement
  # for every (subject,activity) pair
  tidy_df <- dcast(melt_df, subject+activity ~ variable, mean)
  
  # write tidy data to disk
  write.table(df, "tidy_uci_dataset.txt", row.names = FALSE)
  
  # return tidy data
  tidy_df
}

run_analysis_main <- function() {
  # 1. Fetch the data from the web
  # 2. merge the test train data
  # 3. Generate a tidy data set. Write the data.frame ./
  fetch_uci_data()
  df <- merge_test_train_data()
  tidy_df <- make_tidy_data(df)
}
  


