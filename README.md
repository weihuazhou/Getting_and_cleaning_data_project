Explanation of project coding
Line 1, set the working directory, using the command “setwd()”.

Line 3-14, loading the given data into R project. Because the give data files are  type of *.txt, the command “read.table()” is used. 

Line 16-35 merging train and test data to create one data set. 

Line 16-25, data file of “subject_train” contains the information of participants (there are 7352 rows), and data file of “y_train” contains the information of activities (there are 7352 rows). Data file “x_train” records the results (there are 7352 rows). These three data sets have same row numbers. Using the command “cbind()”, these three sets are merged to date set, train_data.

Regarding to data sets of test, including “subject_test”, “y_test” and “x_test”, they have 2947 rows. Using the command “cbind()”, these three sets are merged to data set, text_data.

The two new obtained data sets have identical column numbers, so using command “rbind()”,  they are merged vertically.

Line 26-31, the data set is rearranged (sorted) in accordance with the participant number, and the activity number. 

Line 33, naming the variables. The first two columns are “participant” and “activity”, so naming start from column 3 and end at column 563.

Line 34 naming the column of participant and activity

Line 35 output the data set using command “write.table()”.

Line 37-49 extracting measurement of mean and standard deviation(std).

Line 39-45, command “grepl()” is usedto comparing strings listed in data set of feature. If strings contain “mean” or “std”,  “TRUE” is given, otherwise, it is “FALSE”.

Then, only keep the “TRUE” value in the “feature” data set.

Line 47-49, the data set is rearranged (sorted) in accordance with the participant number, and the activity number. 

Line 51-78 naming row activity

Line 52-74 using “for” loop, a new data frame is created. In this data frame (10299 rows, 1 column), the activity names are written in, and each name is corresponding to the number (1, 2, …6)  in the activity column of the data set generated in step one.

Line 77-78, a data set is created. In this data set, activity names and corresponding data are combined.

Line 81-83 naming column variable names

Line 83, using command, “names()”, the column names are replaced.

Line 85-140 creating a second data set of mean and std

Line 87 creating a data set, including the information of activity, participant, and measurements.

Line 89 creating a list via the command “split()”. The factor of split is the numbers of activity. 

Line 90-96 using “for” loop, command “colMeans()” , and “rbind()”, averages of each variable for each activity are obtained.

Line 97-103 using “for” loop, command “apply()” , and “rbind()”, STDs of each variable for each activity are obtained.

Line 106 creating a list via the command “split()”. The factor of split is the numbers of participant. 

Line 108-113 using “for” loop, command “colMeans()” , and “rbind()”, averages of each variable for each participant are obtained.

Line 114-120 using “for” loop, command “apply()” , and “rbind()”, STDs of each variable for each participant are obtained.

Line 122-138 merging the obtained data sets, and naming the row and column.

Line 140 output of the data set using command “write.table()”.
###finish###

	
	


