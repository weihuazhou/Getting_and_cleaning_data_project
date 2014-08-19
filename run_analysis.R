setwd("R/Getting and Cleaning Data/project")

## feature data
fat_data <- read.table("uci har dataset/features.txt")

## loading training data
x_train <- read.table("uci har dataset/train/X_train.txt")
y_train <- read.table("uci har dataset/train/y_train.txt")
subject_train <- read.table("uci har dataset/train/subject_train.txt")

##loading test data
x_test <- read.table("uci har dataset/test/X_test.txt")
y_test <- read.table("uci har dataset/test/y_test.txt")
subject_test <- read.table("uci har dataset/test/subject_test.txt")

################# Step 1  Merging data#############################
##Merging train data
train_data <- cbind(subject_train, y_train, x_train)

##Merging test data
test_data <- cbind(subject_test, y_test, x_test)

## Merging train and test data
data_list <-rbind(test_data, train_data)

##sorting data
### according to the attendee(1,2,3, ...,30)
data_sort <- data_list[order(data_list[, 1]), ]

### accroding to activity lable (1,2,3,4,5,6)
data_sort <- data_sort[order(data_sort[, 2]), ]

names(data_sort)[3:563] <- as.character(fat_data[,2])
names(data_sort)[1:2] <- c("Participant", "Activity")
write.table(data_sort, "data_set_1.txt")

## ###################step 2 extracted measurement of mean and std############

match_1 <- grepl("mean()", fat_data[,2])
match_2 <- grepl("std()", fat_data[,2])
index_1 <- fat_data[match_1,]
index_2 <- fat_data[match_2,]
index <- rbind(index_1, index_2)
index_sort <- index[as.numeric(order(index[,1])), ]
index_sort[,1] <- index_sort[,1]+2

ext_data <- data_sort[,index_sort[,1]]
ext_data_sort <- ext_data[order(ext_data[,2]),]
ext_data_sort <- ext_data_sort[order(ext_data_sort[,1]),]

##################### Step 3 naming row activity names###############
row_name <- data.frame()

row_name_act <- data.frame()
for (i in 1:10299){
        if (data_sort[i,2] == 1){
                row_name_act[i,1] <- "WALKING"
        }
        if (data_sort[i,2] == 2){
                row_name_act[i,1] <- "WALKING_UPSTAIRS"
        }
        if (data_sort[i,2] == 3){
                row_name_act[i,1] <- "WALKING_DOWnSTAIRS"
        }
        if (data_sort[i,2] == 4){
                row_name_act[i,1] <- "SITTING"
        }
        if (data_sort[i,2] == 5){
                row_name_act[i,1] <- "STANDING"
        }
        if (data_sort[i,2] == 6){
                row_name_act[i,1] <- "LAYING"
        }
}


row_name <- data.frame(paste(data_sort[,1],row_name_act[,1]))
ext_data_actname <- data.frame(row_name[,1],ext_data )


####################Step 4 naming column variable names######

names(ext_data_actname)[2:80] <- as.character(index_sort[,2])

#####################step 5 Create a second data_set ###############

ext_sort_row <- data.frame(data_sort[,1:2], ext_data_sort)
##average and SD by different position
data_list_by_pos <-split(ext_sort_row, ext_sort_row[,2])
###average
ave_p <- data.frame()

for(i in 1:6){
        ave_P_i <-t(data.frame(colMeans(data_list_by_pos[[i]])))
        ave_p <- rbind(ave_p, ave_P_i)
}
###SD  
sd_p <- data.frame()

for(i in 1:6){
        sd_P_i <-t(data.frame(apply(data_list_by_pos[[i]], 2, sd)))
        sd_p <- rbind(sd_p, sd_P_i)
}

## average and SD by different attendee
data_list_by_att <-split(ext_sort_row, ext_sort_row[,1])
###average
ave_att <- data.frame()

for(i in 1:30){
        ave_att_i <-t(data.frame(colMeans(data_list_by_att[[i]])))
        ave_att <- rbind(ave_att, ave_att_i)
}
### SD
sd_att <- data.frame()

for(i in 1:30){
        sd_att_i <-t(data.frame(apply(data_list_by_att[[i]], 2, sd)))
        sd_att <- rbind(sd_att, sd_att_i)
}

#### Merging average and STD data_set
p_row_name <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SETTING", 
                "STANDING", "LAYING")
p_row_name_ave <-paste(p_row_name, "_ave")
p_row_name_std <-paste(p_row_name, "_std")
row.names(ave_p) <- p_row_name_ave
row.names(sd_p) <- p_row_name_std

att_row_name <- c(1:30)
att_row_name_ave <-paste(att_row_name, "_ave")
att_row_name_std <-paste(att_row_name, "_std")
row.names(ave_att) <- att_row_name_ave
row.names(sd_att) <- att_row_name_std


list2 <-rbind(ave_p[,3:81], ave_att[,3:81], sd_p[,3:81], sd_att[,3:81])
names(list2)[1:79] <- as.character(index_sort[,2])

write.table(list2, "data_set_2.txt")
