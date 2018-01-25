# Course: IST387
# Author: Nicholas Brown
# Assignment: Homework 2
# Due: 01/31/18
# Delivered: 01/25/18

# Setup Commands
myCars <- mtcars
summary(myCars)
View(myCars)

# Step 1

# Higher HP is best
which.max(myCars$hp)
# This tells us the name of the car with the most HP
row.names(myCars[which.max(myCars$hp),])


# Step 2

# Value of the highest mpg
max(myCars$mpg)
# Car with highest mpg
which.max(myCars$mpg)
# Name of car with highest mpg
row.names(myCars[which.max(myCars$mpg),])
#Sorted dataframe based on mpg
mySortedCars <- myCars[order(myCars$mpg),]

# Step 3

# I would multiply them together to score a combination
which.max(myCars$hp*myCars$mpg)
# Get the name
row.names(myCars[which.max(myCars$hp*myCars$mpg),])
# I might also try adding them
which.max(myCars$hp+myCars$mpg)
# Get the name
row.names(myCars[which.max(myCars$hp+myCars$mpg),])

# Step 4

# best combined mpg and hp where both columns receive equal weight
which.max(scale(myCars$mpg)+scale(myCars$hp))
# Get name of weighted winner
row.names(myCars[which.max(scale(myCars$mpg)+scale(myCars$hp)),])

