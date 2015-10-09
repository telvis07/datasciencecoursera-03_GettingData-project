# Analyze data from UCI Human Activity Recognition Using Smartphone
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#


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
  # write the timestamp
}

merge_test_train_data <- function(){
  # check for data dir
  # check for uci dir
  # read X_train.txt, y_train, then cbind
  # read X_test.txt, y_test, then cbind
  # bind(train, test)
  # write csv data to 'data/uci_merged_test_train.csv
  invisible(NULL)
}
