# Course: IST387
# Author: Nicholas Brown
# Assignment: Homework 5
# Due: 02/15/18
# Delivered: 02/22/18

# Install and import packages
#install.packages('ggplot2')
#install.packages('imputeTS') 
require(imputeTS)
require(ggplot2)

# Step 1: Make a copy of the data-
#  A timeseries with daily entries from May
# to September
air = airquality
View(air)


# Step 2: Mean Substitution
for (i in 1:ncol(air)) {
  air$i[is.na(air[,i])] <- mean(air[,i], na.rm=TRUE)
}
# We could also use a package called imputeTS, made for imputing-
#  time-series data
air2 = airquality
air2 = na.interpolation(air2)
View(air2)


# Step 3: ggplot
# This plot was made with na.interpolation

# Ozone plot
myPlot = ggplot(air2, aes(x=Ozone))
myPlot = myPlot + geom_histogram(binwidth=5)
myPlot = myPlot + ggtitle("Histogram of Ozone")
myPlot 

# Solar Radiation
myPlot = ggplot(air2, aes(x=Solar.R))
myPlot = myPlot + geom_histogram(binwidth=8)
myPlot = myPlot + ggtitle("Histogram of Solar Radiation")
myPlot

# Wind 
myPlot = ggplot(air2, aes(x=Wind))
myPlot = myPlot + geom_histogram(binwidth=2)
myPlot = myPlot + ggtitle("Histogram of Wind")
myPlot

# Temp
myPlot = ggplot(air2, aes(x=Temp))
myPlot = myPlot + geom_histogram(binwidth=2)
myPlot = myPlot + ggtitle("Histogram of Temp")
myPlot

