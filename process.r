library(plyr)

csvfiles <- dir(args[1])
df <- ldply(csvfiles, read.csv, header=T)

history <- df[,c(1, 3, 5, 6, 7, 11, 12, 21, 30, 56, 48, 43)]
history$DATA <- "M"

write.csv(history, file = "a6history.csv")




df<-read.csv(args[2],header=F)
test<- df[,c(2, 4, 6, 7, 8, 12, 13, 22, 31, 57, 49, 44)]
names(test) <- c("YEAR", "MONTH", "DAY_OF_WEEK","FL_DATE","UNIQUE_CARRIER","FL_NUM","ORIGIN_AIRPORT_ID","DEST_AIRPORT_ID","CRS_DEP_TIME","DISTANCE_GROUP","CANCELLED","ARR_DELAY")


test$DATA <- "T"

write.csv(test, file = "a6test.csv")
