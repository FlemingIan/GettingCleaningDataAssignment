#The Getting and Cleaning Data Assignment Readme

This script is designed to take the data from the Human Activity Recognition Using Smartphones Dataset (found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and merge, group, and average it. See codebook for full details.

The script performs in the following way:
- The files containing the activity labels are read in from the test and train folders
	- Once read in the ID numbers corresponding to the activities are replaced by the activity names, and then converted to a vector
- The feature labels are read in, and then converted to a vector
- The measurement data from the test and train folders is read in, and the variable names (feature labels) are assigned
- The activities vectors are added at the beginning of both the train and test data frames, and then the train data is appended to the test creating one merged file.
- The variable names of the merged set are cleaned of any characters which cause R to choke, and then a new data frame is created containing only the "activity" field, and those fields describing a mean or standard deviation. This includes those written "mean()" and "mean". for completeness sake.
- That subset is then grouped by activity, and the mean calculated for all fields aside from "activity"
- "mean_of" is added as a prefix to each of these averaged variables, and the field names are cleaned of artifacts ("...", "..") leftover as after effects of the previous effort to make the R compatible
- The final data frame is exported as the file "result.csv"
