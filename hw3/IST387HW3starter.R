


# Professor Jeff has saved you typing in this giant URL: Yay!
# This first line opens a connection to the web page
popURL <- url("http://www2.census.gov/programs-surveys/popest/tables/2010-2011/state/totals/nst-est2011-01.csv")

# This next line reads the web page as a CSV file and places the result in a data frame
dfStates <- read.csv(popURL, stringsAsFactors = FALSE)
View(dfStates)
dfStates <- dfStates[-60]
dfStates <- dfStates[-1,-6:-10]


#String sub
dfStates <- gsub(",", "",myDF[,"x2"])
View(dfStates)