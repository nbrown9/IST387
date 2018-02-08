# Course: IST387
# Author: Nicholas Brown
# Assignment: Homework 4
# Due: 02/08/18
# Delivered: 02/09/18


# Part 1
# Defining function to print vector info
printVecInfo <- function(numVector)
{
  cat("Mean = " ,mean(numVector),labels = 'Mean')
  cat("\nMedian = " ,median(numVector))
  cat("\nMin = ",min(numVector))
  cat("\nMax = ",max(numVector))
  cat("\nStandard Deviation = ",sd(numVector))
  cat("\n0.05 Quantile = ",quantile(numVector,0.05))
  cat("\n0.95 Quantile = ",quantile(numVector,0.95))
}

# Part 2
myAQdata <- airquality

# View myAQdata
#  I predict the fields will contain the (parts per million) ppm or ppb (billion) of 
#  pollutants and allergens in the air. In addition to the location, date, and time 
#  associated with the recording. They actually contain a measure of what looks like solar radiation, wind speed, date
#  temperature in F and measure of Ozone. 
View(myAQdata)

#  We wont set the optional replace= in this case. replace takes a boolean argument 
#  and is equivalent to choosing to replace (True) a marble drawn from the bag to
#  be selected on the next draw or whether to keep it out (False) thus changing the 
#  probability of future draws
sampleVec <- sample(myAQdata$Wind, size=10)

# Get random sample vec info
# This vector wont be the same each time because in R the random generator is 
#  re-seeded so new random values are selected each time sample() is run.
printVecInfo(sampleVec)

# Analyze O3 

sampleVec2 <- sample(complete.cases(myAQdata$Ozone, "Ozone"), size=10)
printVecInfo(sampleVec2)



