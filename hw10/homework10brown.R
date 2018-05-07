# Course: IST387
# Author: Nicholas Brown
# Assignment: Homework 10
# Due: 04/12/18
# Delivered: 04/18/18


# PART A
# Install packages

library(kernlab)
library(ggplot2)

testdf <- diamonds[(diamonds$cut == "Premium" | diamonds$cut =="Ideal"),]
View(testdf)

testdf$color <- as.numeric(testdf$color)
testdf$clarity <- as.numeric(testdf$clarity)

# In the data frame we have columns labeled: 
# Cut, Clarity, Color, Carat, depth, table, price,
# x, y, z. The first four are common characteristics of gem stones-
# After some googling we can find out that table and depth are also 
# used to categorize and rate diamonds. They are specific measurements
# which can be used to help determine its value. Assuming price is the value
# of the stone we have to figure our what x,y, and z are. It occured
# to me they are most likely measurements of the stone in mm.


# PART B
# Create training data
length(testdf$cut)

lenTestdf <- dim(testdf)[1]
randIndex <- sample(1:lenTestdf)
View(randIndex)
trainingEnd <- floor(lenTestdf*2/3)
testStart <- trainingEnd +1 
trainingIndex <- randIndex[1:trainingEnd]
testIndex <- randIndex[testStart:lenTestdf]
View(testIndex)
View(trainingIndex)

trainingSet <- testdf[trainingIndex,]
testSet <- testdf[testIndex,]
View(trainingSet)

## Check length of test and training set
dim(trainingSet)[1]
dim(testSet)[1]


# PART C
myModel <- ksvm(cut ~ . , data = trainingSet, kernel="rbfdot",kpar="automatic", C=5, cross=3, prob.model = TRUE)
myModel


# PART D
modelPredict <- predict(myModel,testSet,type="votes")
head(modelPredict)
str(modelPredict)
#confusion matrix
table(modelPredict[2,],testSet$cut)
#error rate
errorrate <- (411+568)/11781

# It is important to have a test data set and training data set 
# because when we train our model it will get to learn our training set
# to properly test the model we need to test it with novel data to prove its
# effectivness. Additionally its possible to overtrain the model so we want to
# make sure our training set isnt too large.

## I tried to convert factors to numbers so we can do a linear model
lmSet <- trainingSet
count <- dim(trainingSet)[1]

for (i in count){
  lmSet[i,2]
  if (lmSet[i,2] == 'Premium'){
    lmSet[i,2] <- 1
  } else {
    lmSet[i,2] <- 0
  }
}

View(lmSet[,2])
lmSet[,2] <- as.numeric(factor(lmSet[,2]))
lmTest <- lm(as.numeric(cut) ~ ., trainingSet)
Summary(lmTest)