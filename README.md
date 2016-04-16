### How the script _run_analysis.R_ works:

1. From the features.txt file in _test_ folder it read the variable names and store them in a character vector.
2. It read the activity labels and subjects from the y_test.txt and subject_test.txt files respectively and store each of them in a numeric vector.
3. Finally, it read the X_test.txt file and create a data frame named `test` adding variable names.
4. It repeats the steps 2 and 3 with equivalent files in _train_ folder and create a data frame named `train` adding variable names.
5. The next step merges `test` and `train` data frame in a new data frame named `test_and_train`
6. It extracts only the measurements on the mean and standard deviation for each measurement.
7. It replaces numbers by descriptive activity names to name the activities in the data set. For this purpose it uses a function named _replace_activity_numbers_.
8. Now, it creates a new tidy data set named `data_set` with the average of each variable for each activity and each subject and writes the data frame into a file named `data_set.txt`.
