# Course: IST387
# Author: Nicholas Brown
# Assignment: Homework 1
# Due: 01/24/18
# Delivered: 01/24/18

## Setup
height <- c(59,60,61,58,67,72,70)
weight <- c(150,140,180,220,160,140,130)
a <- 150


## Step 1

# Average using mean()
avgHeight <- mean(height)
avgWeight <- mean(weight)

# Number of observations
lenHeight <- length(height)
lenWeight <- length(weight)

# Sum using sum()
sumHeight <- sum(height)
sumWeight <- sum(weight)

# Recompute average
avgHeight <- sumHeight/lenHeight
avgWeight <- sumWeight/lenWeight


## Step 2

# Max and min functions
maxH <- max(height)
minW <- min(weight)


## Step 3

# extra weight new vector
extraWeight <- weight + 5

# compute average
avgExtweight <- mean(extraWeight)


## Step 4

# Conditional statements
# Sample: if(100 < 150) "100 is less than 150" else "100 is greater than 150"
if (maxH > 60) "yes" else "no"
if (minW > a) "yes" else "no"

