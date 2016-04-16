library(dplyr)

### 0. LOAD DATA

## 0.1 Read file features.txt and create a vector with variable names

features <- read.table('UCI HAR Dataset/features.txt')

variable_names <- as.character(features$V2)

## 0.2 TEST

# 0.2.1. Read file y_test.txt creating a numeric vector with activity labels

test_activity_labels <- scan('UCI HAR Dataset/test/y_test.txt')


# 0.2.2. Read file subject_test.txt creating a numeric vector with subjects

subject_test <- scan('UCI HAR Dataset/test/subject_test.txt')

# 0.2.3. Read file X_test.txt creating a data frame adding variable names

test_set <- read.table('UCI HAR Dataset/test/X_test.txt',col.names = variable_names)

# 0.2.4. Create Test data frame

test <- test_set
test$subject <- subject_test
test$activity <- test_activity_labels
test <- test[,c(562, 563, 1:561)]

## 0.3. TRAIN

# 0.3.1. Read file y_train.txt creating a numeric vector with activity labels

train_activity_labels <- scan('UCI HAR Dataset/train/y_train.txt')


# 0.3.2. Read file subject_train.txt creating a numeric vector with subjects

subject_train <- scan('UCI HAR Dataset/train/subject_train.txt')

# 0.3.3. Read file X_train.txt creating a data frame adding variable names

train_set <- read.table('UCI HAR Dataset/train/X_train.txt',col.names = variable_names)

# 0.3.4. Create Train data frame

train <- train_set
train$subject <- subject_train
train$activity <- train_activity_labels
train <- train[,c(562, 563, 1:561)]


### 1. MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET

test_and_train <- merge(test,train,all=TRUE)

### 2. EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT

sub <- grep('subject', names(test_and_train))
act <- grep('activity', names(test_and_train))
mea <- grep('mean', names(test_and_train))
std <- grep('std', names(test_and_train))

sub_act_mea_std <- c(sub, act, mea, std)

test_and_train_mean_std <- test_and_train[, sub_act_mea_std]

### 3. USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET

# 3.1. Create a function to replace numbers by descriptive names for the activities

replace_activity_numbers <- function(x) {
        if (x == 1) {
                x <- 'WALKING'
        } 
        else if (x == 2) {
                x <- 'WALKING_UPSTAIRS'
        }
        else if (x == 3) {
                x <- 'WALKING_DOWNSTAIRS'
        }
        else if (x == 4) {
                x <- 'SITTING'
        }
        else if (x == 5) {
                x <- 'STANDING'
        }
        else {
                x <- 'LAYING'
        }
}

# 3.2. Apply function

test_and_train_mean_std_dna <- test_and_train_mean_std

test_and_train_mean_std_dna$activity <- sapply(test_and_train_mean_std_dna$activity, replace_activity_numbers)


### 4. LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES : it was made in step 0.2.3 adding variable names while creating data frame

### 5. CREATE A NEW TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT

# 5.1 Grouping by activity and subject

data_set <- group_by(test_and_train_mean_std_dna, activity, subject)

data_set <- summarize_each(data_set, funs(mean))

# 5.2 Write data set in a txt file 

write.table(data_set, file = 'data_set.txt', row.names = FALSE)
    
    
    
    
    
    