# Course: IST387
# Author: Nicholas Brown
# Assignment: Homework 3
# Due: 02/01/18
# Delivered: 02/06/18



# Step 1: Get data

# Professor Jeff has saved you typing in this giant URL: Yay!
# This first line opens a connection to the web page
popURL <- url("http://www2.census.gov/programs-surveys/popest/tables/2010-2011/state/totals/nst-est2011-01.csv")

# This next line reads the web page as a CSV file and places the result in a data frame
dfStates <- read.csv(popURL, stringsAsFactors = FALSE)


# Step 2: Clean the datafrome

# Remove unnecessary rows and columns
dfStates <- dfStates[-1:-8,-6:-10]
dfStates <- dfStates[-52:-58,]

# Remove periods from state names and commas from integer values
for (i in 2:5){
  dfStates[,i] <- gsub(",", "", dfStates[,i])
  dfStates[,i] <- as.numeric(dfStates[,i])
  }

dfStates[,1] <- gsub(".", "", dfStates[,1], fixed = TRUE)

# Change column names
colnames(dfStates) <- c("stateName", "Census",  "Estimated", "Pop2010", "Pop2011")

# View dataframe to check our work
View(dfStates)


# Step 3: Calculate the mean, we already used as.numeric in the-
#   for loop in Step 2. Now we have integer values to work with

censusMean <- mean(dfStates[,"Census"])
estimatedMean <- mean(dfStates[,"Estimated"])
pop2010Mean <- mean(dfStates[,"Pop2010"])
pop2011Mean <- mean(dfStates[,"Pop2011"])


# Step 4: State with highest population, we'll consult the 'Census' column-
#   we end up with the state of California having the highest population

highestPop <- which.max(dfStates[,"Census"])
# Grab the name
highestPopName <- dfStates[highestPop,1]


# Step 5: here we'll sort the frame by the values in column 'Estimated'
dfStates[order(dfStates$Estimated),]

# Create barplot
counts <- table(dfStates$Census)
View(counts)

# Worked kind of, would like to try and get state labels
# barplot(dfStates$stateName,counts, main = "States Census", xlab="States")
options(scipen=5)
barplot(dfStates$Census,counts, main="Census Distribution", xlab="States", ylab="Population", beside= TRUE)