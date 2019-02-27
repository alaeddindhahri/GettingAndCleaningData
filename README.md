# Getting And Cleaning Data
This is the programming assignment for coursera Getting and Cleaning Data: the included R script does the fllowing:

-Download the dataset if it doens't exist in the working directory
-Load the activity and features info
-Loads both the training and test datasets and keeping only those columns which reflect a standard deviation or mean
-Loads the activity and subject data for each dataset and merges those columns with the previous dataset
-Merges both of the datasets
-Converts the activity and subject columns to factors
-Creates a tidy dataset file of the mean value of each variable for each subject and activity

A file with the name "tidy.txt" will be created at the end.
