fraudTrainData <- read.csv("C:\\Users\\mizzj\\Desktop\\R proj\\fraudTest.csv", header=TRUE) 

fraudTrainData <- data.frame(fraudTrainData)

#print(fraudTrainData)

#subset function is used to keep only the necessary columns from the data frame
fraudTrainData <- subset(data.frame(fraudTrainData), select = c("trans_date_trans_time","cc_num", "merchant", "category", "amt", "first",
                                                                "last", "gender", "street", "city", "state", "zip", "lat", "long", 
                                                                "city_pop", "job", "dob", "trans_num", "unix_time", "merch_lat", 
                                                                "merch_long"))

fraudTrainData <- fraudTrainData %>% drop_na()

training <-lm(fraudTrainData$is_fraud ~ fraudTrainData$trans_date_trans_time* fraudTrainData$cc_num* fraudTrainData$merchant* fraudTrainData$category*
              fraudTrainData$amt* fraudTrainData$first* fraudTrainData$last* fraudTrainData$gender* 
              fraudTrainData$street* fraudTrainData$city* fraudTrainData$state* fraudTrainData$zip* fraudTrainData$lat* fraudTrainData$long*
              fraudTrainData$city_pop* fraudTrainData$job* fraudTrainData$dob* fraudTrainData$trans_num* fraudTrainData$unix_time*
              fraudTrainData$merch_lat* fraudTrainData$merch_long, data=fraudTrainData)
