# How tapply works
randNum <- floor(rnorm(21) * 10)  # 21 random numbers

groupVar <- as.factor(c("a","b","c")) # Three groups

lilDF <- data.frame(randNum, groupVar) # Auto-repeat group var

View(lilDF)



mean(lilDF$randNum[lilDF$groupVar=="a"])

mean(lilDF$randNum[lilDF$groupVar=="b"])

mean(lilDF$randNum[lilDF$groupVar=="c"])



# tapply is part of the apply family

# Look on datacamp, youtube, or r-bloggers

tapply(lilDF$randNum,lilDF$groupVar,length) # How many per group?

tapply(lilDF$randNum,lilDF$groupVar,mean) # Mean within each group

tapply(lilDF$randNum,lilDF$groupVar,sd) # Std Dev within each group

tapply(lilDF$randNum,lilDF$groupVar,sum) # Sum of each group


groupSum <- tapply(lilDF$randNum,lilDF$groupVar,sum) # Sum of each group

View(groupSum)
rownames(groupSum)


