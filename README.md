
# Getting and Cleaning Data 
Assignment 2 of the Coursera course called Getting and Cleaning Data

This is a description on how to run the script available in this repo, called run_analysis.R
- 1. Click on the following link and unzip the folder: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
- 1.1. Alternatively, download the dataset from this repo, in the folder of UCI HAR Dataset.
- 2. Start R Studio, and use the command setwd() to make sure that the unzipped folder and run_analysis.R are in the current working directory.
- 3. Type: source ("run_analysis.R")
- 4. After running the script (it might take a couple of minutes to generate all the data), you will find two new data files in the folder: merged_data.txt and data_with_means.txt
- 5. To view the final output of the script, simply type finaldata <- read.table("data_with_means.txt"), and then type finaldata.
- 6. The dataset you will see on screen is the average of each variable for each activity and each subject, as asked by the assignment.
