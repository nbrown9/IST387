# Course: IST387
# Author: Nicholas Brown
# Assignment: Homework 7
# Due: 03/14/18
# Delivered: 03/08/18

# Part 1: Import and clean data
library(gdata)
## read data
myData <- read.xls("http://college.cengage.com/mathematics/brase/understandable_statistics/7e/students/datasets/mlr/excel/mlr01.xls")
## check out the data
View(myData)
str(myData)
## assign column names
colnames(myData) <- c("FawnCount","AdultPop","AnnualPrecip","WinterSeverity")


# Part 3: Create bivariate plots
## import ggplot
library(ggplot2)
## create out first three plots all with FawnCount as the dependant variable (y-axis)
ggplot(myData, aes(x=AdultPop,y=FawnCount)) + geom_point() + geom_smooth(method="lm")
ggplot(myData, aes(x=AnnualPrecip,y=FawnCount)) + geom_point() + geom_smooth(method="lm")
ggplot(myData, aes(x=WinterSeverity, y=FawnCount)) + geom_point() + geom_smooth(method="lm")

# Part 4: Regression modelling
lmOut <- lm(FawnCount ~ AdultPop + AnnualPrecip + WinterSeverity, data=myData)
summary(lmOut)

# Part 5: r-squared
## Our r-squared for this regression is .9743, pretty high!
## the predictor coefficients are:
##  AdultPop        0.33822
##  AnnualPrecip    0.40150
##  WinterSeverity  0.26295
##

# Part 6: Summary
## In total we have four variables:
##    1 dependant: FawnCount 
##    3 independant: AdultPop, AnnualPrecip, WinterSeverity
##
##  Because we want to study the way those three independant variables influence the-
##  FawnCount variable (The number of fawns born) we should look at the p-value of each result-
##  our first variable AdultPop has a p-value of .0273, well under our .05 requirement, we can see-
##  that AdultPop is significantly impacting FawnCount. Second we can look at the p-val of AnnualPrecip- 
##  (Amount of rain that year) to check its significance. With a p-val if .0217 the rain is slightly more-
##  significant than the adult population and is under our .05 requirement for statistical significance.
##  Finally the WinterSeverity is significant with a p-val of 0.0366 though it is less so than others.
