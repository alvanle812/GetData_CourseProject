# GetData_CourseProject
Course Project for Getting and Cleaning Data from Coursera

The run_Analysis.R file is to download data from the accelerometers from the Samsung Galaxy S smartphone, then come out with a tidy data set with the average of each variable for each activity and each subject. 

1. After downloading the file, the script first getting the features and activities information, and keeps only the features which have the name that contain 'mean' or 'std' as required by the project. This step is done first to reduce the cost of merging two datasets (training and test)

2. The script then loads training dataset and test dataset (with only 'mean' and 'std' columns) and does the merging

3. Create tidy.txt file
