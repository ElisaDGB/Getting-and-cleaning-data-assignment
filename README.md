# Getting-and-cleaning-data-assignment
This readme file collect the explanation related to how the downloaded data was transformed into a tidy set as well as the contents of this repository.

## Repository files
- CodeBook.md : This markdown document indicates all the variables of the tidy data set.
- README.md : This markdown document explains the transformations involved step by step.
- run_analysis.R : This R script was used to transform the downloaded data to a tidy data set.
- tidyset.txt : This is the tidy data set produced as an output from the R script.

##Steps 

- First. Train, test, feature and activity labels files are loaded in R. Feature list is used to rename the variable names of both data frames (train and test).
- Second. Activity labels are loaded and binded to the data frames of test and train. Labels are then replaced by more descriptive names.
- Third. Subjects are now loaded and binded to the test and train data frames.
- Fourth. Merge both data frames together
- Fifth. dplyr package is used to group merged data frame by subject and activity and written to tidyset.txt in the working directory.
