# Course: IST387
# Author: Nicholas Brown
# Assignment: Homework 9
# Due: 04/04/18
# Delivered: 04/04/18


# Load Packages
install.packages("arules")
install.packages("arulesViz")


# PART A : Explore data set

# load titanic data and place into dataframe "badboat"
load("~/Desktop/IST387/IST387/hw9/titanic.raw.rdata")
badboat <- titanic.raw

# Lets take a look at the dataframe
View(badboat)
# In our dataframe there are four columns (Class, Sex, Age, Survived)
# We can assume that these are the 2,201 passengers on the Titanic
# I would argue the matrix is potentially relativley sparse but currently is not
# with entire columns like Sex being binary containg either male or female therefor 
# a lot of the same answers

# counting total Titanic survivors
pSurvivors <- table(badboat$Survived)
pSurvivors
prop.table(pSurvivors)
# passenger age table
pAge <- table(badboat$Age)
prop.table(pAge)
# passenger sex table
pSex <- table(badboat$Sex)
prop.table(pSex)
# passenger class table
pClass <- table(badboat$Class)
prop.table(pClass)
# contingency table
cTable <- prop.table(table(badboat$Age, badboat$Sex))
cTable
# This table gives us some great insight by using two columns
# of data we are able to extrapolate some interesting figures
# such as the total number of children/adults and their respective
# sexes.


# PART B: Coerce data

# coerce data frame into sparse transactions matrix
badboatX <- as(badboat,"transactions")
# explore the plot
inspect(badboatX)
itemFrequency(badboatX)
itemFrequencyPlot(badboatX)
# view the plot
View(badboatX)
# Within badboatX we can see three 'cups'
# the first cup is 'data' this contains what appears
# to be the ~2200 data entries, next we have dataInfo which we
# can see contains some of the values we would see in the dataframe
# columns like "Male" or "1st Class". Finally we see ItemSetInfo which
# simply shows the count of items in our set

# The difference between badboat and badboatx
# is that our badboatx is no longer a dataframe
# but a sparse transactions matrix in which each possible
# variable or transaction is given a number corresponding to its value
# this is useful in sparse matrixes with limited number of stored values


# PART B: arules to discover patterns
ruleset <- apriori(badboatX, 
                   parameter=list(support=0.005,confidence=0.5),
                   appearance = list(default="lhs", rhs=("Survived=Yes")))
inspectDT(ruleset)
# after inspecting the ruleset we can see the highest degree of confidence for people to survive
# who were 2nd class, female, and children or just 2nd class children. In order to have the highest chance of surviving the 
# disaster you would want to be one of those children in 2nd class, preferably a female. If we 
# sort a selection of 100 from the dataset the confidence level is highest for the group mentioned above.
