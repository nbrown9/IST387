# Course: IST387
# Author: Nicholas Brown
# Assignment: Homework 7
# Due: 03/07/18
# Delivered: 03/07/18

# Step 1: Load data
## CSV read only worked with full path, you'll need to replace this with 
##  the path to your MedianZIP.csv file location before running it
mydata = read.csv("~/Desktop/IST387/IST387/hw7/MedianZIP.csv")
View(mydata)
# Mean substitution with median, all are acceptable as an average value and in this case the medians are close
# to the mean so it wont skew our data too much to substitute using it
mydata[is.na(mydata[,3])] <- median(mydata[,2], na.rm=TRUE)
View(mydata)
# The data appears to be a list of zipcodes/locations with a mean, median, and population count
# A majority of the mean and median fields for the first ~2,300 zip codes are similar 5 digit numbers


# Step 2: Zip data
# Install and require outside package 'zipcode'
install.packages("zipcode")
library(zipcode)
# assign new zipcodes to the zip column, clean and fix zip codes in the zip column
mydata$zip <- clean.zipcodes(mydata$zip)
# loads zipcode data set
data(zipcode)
# creates new dataframe joining the zipcode table and our df mydata by the zip zolumn. the zipcode parameter is the 
dfNew <- merge(mydata, zipcode, by="zip")
View(dfNew)


# Step 4: Merge new dataset with stateName.csv
statenames = read.csv("~/Desktop/IST387/IST387/hw7/stateNames.csv")
View(statenames)
dfNew2 <- merge(dfNew, statenames, by="state")
View(dfNew2)


# Step 5: Plot points
library(ggplot2)
library(ggmap)
# saves a new df with lat lon coords for different locations in the US
# useful for plotting with ggplot
us <- map_data("state")
# create a ggplot object called dotmap using our new df merged with the state names
# additionally the aes x and y value are taked from map_
dotmap <- ggplot(dfNew2, aes(map_id = tolower(name)))
# add the returned value of geom_map (the map of the us)
dotmap <- dotmap + geom_map(map = us)
# again add another parameter to our dotmap object, also color the map based on mean and plot the coords found in our dfNew2
dotmap <- dotmap + geom_point(aes(x=longitude,y=latitude,color=Mean))
dotmap
##
## It is not very clear what this map is trying to accomplish
##  there is not much use of color or labeling to identify 
##  or infer anything interesting.
##


# Step 6: average income per state
# total cash per zipcode
dfNew2$total <- as.numeric(dfNew2$Mean) * as.numeric(dfNew$Pop)
# add zips together per state using tapply, the arguments tell tapply to sum the total column grouped by the name column
totalIncome <- data.frame(tapply(dfNew2$total, dfNew2$name, sum))
# save results in a new vector called totalIncome with 51 elements for the 50 states + DC
# Interesting thing about this vector is that some states have a much larger number than I would have
# predicted, for example states like Minnesota have a rather large total.

# now we do something similar but with population. again we tell tapply to group by name but sum the pop column this time
totalPop <- data.frame(tapply(dfNew2$Pop, dfNew2$name, sum))
# add average income column to dfSimple
dfSimple <- totalIncome / totalPop
# found on stack overflow to convert first labels into column link: https://stackoverflow.com/questions/29511215/convert-row-names-into-first-column
dfSimple$name <- rownames(dfSimple)
colnames(dfSimple)[1] <- "income"
View(dfSimple)


# Step 7: create map

## My ggmap stopped working at this point so im not sure if this even works or not however i didnt get any errors from the compiler
dotmap <- ggplot(dfSimple, aes(map_id = tolower(name)), expand_limits(x = us$long, y = us$lat), coord_map(projection = "mercator"))
dotmap <- dotmap + geom_map(map = us)
dotmap <- dotmap + aes(fill = dfSimple$income)
dotmap