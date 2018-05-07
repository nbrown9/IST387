# Course: IST387
# Author: Nicholas Brown
# Assignment: Homework 11
# Due: 04/19/18
# Delivered: 04/19/18
install.packages('tm')
require('tm')
setwd('~/Desktop/IST387/IST387/hw11')

charVector <- scan("speech.txt",character(0),sep = "\n")
head(charVector)
summary(charVector)

words.vec <- VectorSource(charVector)
words.corpus <- Corpus(words.vec)

# clean up the data
# make it all lower case
words.corpus <- tm_map(words.corpus,content_transformer(tolower))
#remove punctuation marks
words.corpus <- tm_map(words.corpus, removePunctuation)
#remove numbers
words.corpus <- tm_map(words.corpus, removeNumbers)
# remove all non english words
words.corpus <- tm_map(words.corpus,removeWords,stopwords("english"))

#inspect
inspect(words.corpus)
# create tdm
tdm <- TermDocumentMatrix(words.corpus)

## Part 2
wordCounts <- sort(rowSums(as.matrix(tdm)), decreasing = TRUE)
head(wordCounts)
# After running head(wordCounts) we get the top most used
#  words in the speech we are analyzing.

## Part 3
pos <- scan("positive-words.txt", character(0), sep = "\n")
neg <- scan("negative-words.txt", character(0), sep = "\n")

head(pos, 10)
head(neg, 10)

# Calculate total number of words
totalWords <- sum(wordCounts)
# Vector with those words
words <- names(wordCounts)

# Counting the pos and neg words
# Positive
posMatched <- match(words, pos, nomatch=0)
head(posMatched,100)
# Negative matches
negMatched <- match(words, neg, nomatch=0)
head(negMatched,100)

mCounts <- wordCounts[which(posMatched != 0)]
length(mCounts)
mWords <- names(mCounts)
nPos <- sum(mCounts)
# Number of positive words
nPos
# Number of unique positive words
length(mCounts)
nCounts <- wordCounts[which(negMatched != 0)]
nNeg <- sum(nCounts)
nWords <- names(nCounts)
# Number of negative words
nNeg
# Number of unique negative words
length(nCounts)

# Calculate percentage
totalWords <- length(words)
ratioPos <- nPos/totalWords
ratioNeg <- nNeg/totalWords
ratioNeg
ratioPos

## RESULTS
# We can see that the ratio of positive words in the speech is
# 0.178 or 17.8% of words were positive. As for negative words
# the speech is at 0.089 or 8.9% negative words. We can infer that
# the speech has mostly positive things to say so perhaps it is a 
# celebration or something.

# Part 4
# Negative
sortedWords <- sort(wordCounts[which(negMatched != 0)])
barplot(sortedWords, las=2, cex.names=0.75)
# Positve
sortedWords <- sort(wordCounts[which(posMatched != 0)])
barplot(sortedWords, las=2, cex.names=0.75)
