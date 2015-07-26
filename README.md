# GetDataProject



Description of Run_analysis code
	1.	Downloads file from URL and unzips it in working directory
	2.	Download Activity Labels and Features (column names for dataset) which will be used to create combined dataset and transform them into vectors
	3.	Read files to create complete TEST3 dataset.(X_test.txt,y_test.txt, subject_test.txt). Append subjects and activity codes to X_test),give proper names to columns using features vector
	4.	Read files to create complete TRAIN3 dataset.(X_train.txt,y_train.txt, subject_train.txt). Append subjects and activity codes to X_train),give proper names to columns using features vector
	5.	Combine rows of TEST3 and TRAIN 3 to get BIG_SET
	6.	Remove columns with duplicate names ->big_set1
	7.	Keep only “activity”, “person” and columns with “mean” , “std” (excluding mean_Freq))->big_set3
	8.	Change activity code numbers  to names the activities in the data set -> big_set4
	9.	From the big_set4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	10.	Create sum_set.txt file with results
