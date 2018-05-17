# Course: IST387
# Author: Nicholas Brown
# Assignment: Term Project
# Due: 05/09/18
# Delivered: 05/09/18

### Packages
require(ggplot2)
require(ggmap)
require(sqldf)


## Phase 1: Choosing best indicator of satisfaction

# Import data
myData <- read.csv("~/Desktop/IST387/IST387/termproject/BrownNicholas.csv")
View(myData)
str(myData)

# Mean substitution 
for(i in 1:ncol(myData)){
  myData[is.na(myData[,i]), i] <- mean(myData[,i], na.rm = TRUE)
}
# Check to see if it worked
View(myData)

# Create linear models
modelOne <- lm(Likelihood_Recommend_H ~ QUOTED_RATE_C + Guest_Room_H + Tranquility_H 
               + Condition_Hotel_H + Customer_SVC_H + Staff_Cared_H + Internet_Sat_H, data = myData)
summary(modelOne)
# modelOne has an r-squared of 0.6796

modelTwo <- lm(Overall_Sat_H ~ QUOTED_RATE_C + Guest_Room_H + Tranquility_H 
               + Condition_Hotel_H + Customer_SVC_H + Staff_Cared_H + Internet_Sat_H + as.factor(GP_Tier), data = myData)
summary(modelTwo)
# modelTwo has an r-squared of 0.6996, we should use Overall_Sat_H


## Phase 2: Predicting the Indicator of Satisfaction from demographic and stay variables
# Demographic Variables
modelThree <- lm(Overall_Sat_H ~ as.factor(Guest_Country_H) + as.factor(Gender_H) + as.factor(Age_Range_H) + as.factor(Language_H), data = myData)
summary(modelThree)
# There is weak correlation with all coefficients and an r squared of 0.03569, not very good
# Place variables
modelFour <- lm(Overall_Sat_H ~ Award.Category_PL + as.factor(City_PL) + as.factor(Country_PL)
                + as.factor(Currency_PL) + as.factor(Club.Type_PL) 
                + as.factor(Region_PL) + as.factor(Type_PL) + as.factor(Class_PL) 
                + as.factor(Location_PL) + as.factor(Relationship_PL), data = myData)
summary(modelFour)

## Phase 3: Mapping guest satisfaction 
mapData <- tapply(myData$Overall_Sat_H, myData$Hotel.Name.Short_PL, mean)
mapData$Hotel.Name.Short_PL <- rownames(mapData)
colnames(mapData)[1] <- "Score"
str(myData)
colnames(myData)[]
newData <- sqldf("select avg(Overall_Sat_H), * from myData group by Property_ID_PL")
View(newData)

library(ggplot2)
library(ggmap)
library(maps)

world <- map_data("world")
# No hotels in antarctica
world <- world[world$region != "Antarctica",]
View(world)
# rename col
colnames(newData)[1] <- "Score"
gg <- ggplot(newData, aes(map_id = tolower(City_PL)), expand_limits(x = world$long, y = world$lat), coord_map(projection = "mercator"))
gg <- gg + geom_map(data=world, map=world,
                    aes(x=long, y=lat, map_id=region),
                    color="white", fill="#7f7f7f", size=0.05, alpha=1/2)
gg <- gg + geom_point(data=newData, aes(y=Property.Latitude_PL, x=Property.Longitude_PL, size=Score, colour = Score)) + scale_colour_gradient(low = "blue")
# THE MAP
gg

