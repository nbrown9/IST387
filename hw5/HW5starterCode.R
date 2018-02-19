##########################################################################
# IST387 Homework 5 - Getting data with JSON 
#                     and analyzing with SQL
# Student name:
# 
##########################################################################

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
summary(mydata) # Create a brief summary of mydata
### Add a comment here describing what you found

View(mydata[[1]]) # Examine the metadata
### Add a comment that gives a definition of the term "metadata"

View(mydata[[2]]) # Examine the main data set
### Add a comment that describes the total number of rows and columns
numRows <- length(mydata[[2]]) # Is this the number of rows or the number of columns?

#-------------------------------------------------------------------------
# In the code below, we "un-nest" the nested list
?unlist   # What does this function do and what package does it come from?
flatList <- unlist(mydata[[2]]) # Make an atomic list
length(flatList)/numRows        
### Add a comment describing why the result of the calculation above makes sense 

matrixData <- matrix(flatList, nrow=numRows, byrow=T) # Make a square matrix
df <- data.frame(matrixData, stringsAsFactors = FALSE) # Turn it into a data frame

# Use the original metadata to name the columns in the data frame
numCols <- (length(flatList)/numRows)
for (col in 1:numCols) {colnames(df)[col] <- mydata[[1]]$view$columns[[col]]$name}
### Super expert mode: Explain the command on the previous line 
View(df)

#-------------------------------------------------------------------------
# Finally, we are ready to run some analyses
#install.packages("sqldf") # Uncomment this if you need to install from the web
library(sqldf)

sqldf("select count(DAY_OF_WEEK) from df where TRIM(DAY_OF_WEEK) = 'FRIDAY'")
### How many accidents on Friday

