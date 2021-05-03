library("tidyr")
library("caret")
library("parallel")
library("doSNOW")

trainingData <- read.csv("C:\\Users\\mizzj\\OneDrive\\Desktop\\R proj\\New folder\\fraudTrain.csv", header=TRUE)

#Set up factors
trainingData$merchant <- as.factor(trainingData$merchant)
trainingData$category <- as.factor(trainingData$category)
trainingData$amt <- as.factor(trainingData$amt)
trainingData$gender <- as.factor(trainingData$gender)
trainingData$city <- as.factor(trainingData$city)
trainingData$state <- as.factor(trainingData$state)
trainingData$zip <- as.factor(trainingData$zip)
trainingData$city_pop <- as.factor(trainingData$city_pop)
trainingData$job <- as.factor(trainingData$job)
trainingData$is_fraud <- as.factor(trainingData$is_fraud)

#Subset data to the features we wish to use
features <- c("merchant", "category", "amt", "gender", "city", "state", "zip", "city_pop",
              "job", "is_fraud")

trainingData <- trainingData[, features]

train.control <- trainControl(method="repeatedcv", number=2, repeats = 2, search="grid")

tune.grid <- expand.grid(n.trees = seq(10, 1000, by = 100)
                         , interaction.depth = 1
                          ,shrinkage = 0.1
                        , n.minobsinnode = c(5, 10, 20, 30))


cl <- makeCluster(5, type = "SOCK")
registerDoSNOW(cl)

caretModel <- train(is_fraud ~ .,
                  data= trainingData,
                  method='gbm',
                  tuneGrid= tune.grid,
                  trControl= train.control)


stopCluster(cl)


testData <- read.csv("C:\\Users\\mizzj\\OneDrive\\Desktop\\R proj\\New folder\\fraudTest.csv", header=TRUE)

preds <- predict(caretModel, data= testData)

#Result
confusionMatrix(preds, as.factor(testData$is_fraud))


