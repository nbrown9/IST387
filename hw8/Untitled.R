myCars <- mtcars
library(ggplot2)
ggplot(myCars, aes(x=disp,y=mpg)) + geom_point() + geom_smooth(method="lm")

# simple linear model
## Miles per gallon predicted by (~) displacement 
lmOut <- lm(mpg ~ disp, data = myCars)
lmOut <- lm(mpg ~ disp + )