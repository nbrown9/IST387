# Course: IST387
# Author: Nicholas Brown
# Assignment: Homework 5
# Due: 02/15/18
# Delivered: 02/15/18


#-------------------------------------------------------------------------
# The following starter code will help you retrieve and transform the data
#-------------------------------------------------------------------------
# First, install and "library" new packages:

#install.packages("RCurl") # Uncomment this if you need to install from the web
library(RCurl)
#install.packages("RJSONIO") # Uncomment this if you need to install from the web
library(RJSONIO)


#-------------------------------------------------------------------------
# Next, retrieve and examine the data from the URL
?getURL   # What does this function do and what package does it come from?
dataset <- getURL("http://data.maryland.gov/api/views/pdvh-tf2u/rows.json?accessType=DOWNLOAD")

?fromJSON   # What does this function do and what package does it come from?
mydata <- fromJSON(dataset, simplify = FALSE, nullValue = NA)

typeof(mydata)  # Find out the type of mydata
### Add a comment here describing what you found
### -- We have a list which we got from JSON data
summary(mydata) # Create a brief summary of mydata
### Add a comment here describing what you found
### -- Summary shows that we have 1 metadata object and 18638 data rows
View(mydata[[1]]) # Examine the metadata
### Add a comment that gives a definition of the term "metadata"
### -- Metadata is data about data, in this case it can be compared to-
### -- the top row of a spreadsheet giving the categorys of data in the rows below.
View(mydata[[2]]) # Examine the main data set
### Add a comment that describes the total number of rows and columns
### -- there are 26 columns and 18638 rows
numRows <- length(mydata[[2]]) # Is this the number of rows or the number of columns?

#-------------------------------------------------------------------------
# In the code below, we "un-nest" the nested list
?unlist   # What does this function do and what package does it come from?
flatList <- unlist(mydata[[2]]) # Make an atomic list
length(flatList)/numRows        
### Add a comment describing why the result of the calculation above makes sense 
### -- Because the length of flatList is 484,588 we then divide that by numRows which is
### -- our number of 18,638. So therefore our value returned should be 26
matrixData <- matrix(flatList, nrow=numRows, byrow=T) # Make a square matrix
df <- data.frame(matrixData, stringsAsFactors = FALSE) # Turn it into a data frame

# Use the original metadata to name the columns in the data frame
numCols <- (length(flatList)/numRows)

for (col in 1:numCols) {
  colnames(df)[col] <- mydata[[1]]$view$columns[[col]]$name
  }
### Super expert mode: Explain the command on the previous line 
### It is a for loop using 1-26 to assign each column in the dataframe
### the names found inside the mydata[[1]] list
View(df)

#-------------------------------------------------------------------------
# Finally, we are ready to run some analyses
#install.packages("sqldf") # Uncomment this if you need to install from the web
library(sqldf)

sqldf("select count(DAY_OF_WEEK) from df where TRIM(DAY_OF_WEEK) = 'FRIDAY'")
### How many accidents on Friday
### There were 3014 accidents on friday

sqldf("select count(DAY_OF_WEEK) from df where TRIM(DAY_OF_WEEK) = 'FRIDAY' and INJURY = 'YES'")
### How many accidents on Friday where people were injured, about 1/3 of accidents on Friday have injuries (1043) !

sqldf("select count(DAY_OF_WEEK) from df where TRIM(DAY_OF_WEEK) = 'FRIDAY' and INJURY = 'NO'")
### How many accidents on Friday where people were not injured, about 2/3 of accidents on Friday have injuries (1971) !

fridayDF <- sqldf("select * from df where TRIM(DAY_OF_WEEK) = 'FRIDAY'")
### Create a df of friday accidents
### View to test
View(fridayDF)

## Now we have to convert our Str / Char data to integers
fridayDF <- fridayDF[complete.cases(fridayDF),]
fridayDF[,'VEHICLE_COUNT'] <- as.numeric(fridayDF[,'VEHICLE_COUNT']) 

## Calculate the mean ! 1.918251
mean(fridayDF[,'VEHICLE_COUNT'])
## Create a histogram
hist(fridayDF[,'VEHICLE_COUNT'], xlab = "Vehicle Count", main = "Vehicle Count Frequency in Accidents")

## My query of interest
myQuery <- sqldf("select COUNT(DAY_OF_WEEK), TRIM(DAY_OF_WEEK) from df group by DAY_OF_WEEK")
myQuery[,'COUNT(DAY_OF_WEEK)'] <- as.numeric(myQuery[,'COUNT(DAY_OF_WEEK)']) 
View(myQuery)

testLabs <-  myQuery[,'COUNT(DAY_OF_WEEK)']

barplot(myQuery[,'COUNT(DAY_OF_WEEK)'], ylab = 'Accidents', horiz = FALSE, names.arg = testLabs, main = 'Accidents per Weekday')