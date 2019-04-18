# 0: Load the data in RStudio
## Set working directory to Springboard  
setwd("~/Capstone Project Proposal/Asteroids") 

asteroids <- read.csv("asteroids_data.csv")
head(asteroids)
View(asteroids)
asteroids<-data.frame(lapply(asteroids,as.numeric))
library(dplyr)
library(tidyr)
library(data.table)
#2: Separate and cleaning
asteroids<- separate(asteroids, Close.Approach..CA..Date, c("year","month", "day","restdate"), sep="-")
head(asteroids)
View(asteroids)
asteroids<- separate(asteroids, day, c("day", "dayrest"), sep=" ")
View(asteroids)
asteroids<- separate(asteroids, dayrest, c("minutes", "minutesrest"), sep="Â")
View(asteroids)
asteroids<-asteroids[,-6]
View(asteroids)
asteroids<-asteroids[,-6]
View(asteroids)
head(asteroids)
asteroids1<-separate(asteroids, CA.Distance.Nominal..LD...au., c("Moondist_LD_nom", "Solardist_AU_max"), sep=" ")
View(asteroids1)
head(asteroids1)
asteroids1<-separate(asteroids1, CA.Distance.Minimum..LD...au., c("Moondist_LD_min", "Solardist_AU_min"), sep=" ")
View(asteroids1)
asteroids1<-asteroids1[,-7]
View(asteroids1)
asteroids1<-asteroids1[,-8]
#Separate and fill NA with zeros
View(asteroids1)
asteroids1[is.na(asteroids1)]<-0
asteroids1<-separate(asteroids1, Estimated.Diameter, c("Diam_min_m", "Diam_max_m"), sep=" - ")
View(asteroids1)
asteroids1<-separate(asteroids1, Diam_min_m, c("Diam_min", "min_m"), sep=" ")
View(asteroids1)
asteroids1<-asteroids1[,-12]
View(asteroids1)
asteroids2<-unite(asteroids1, Date, year, month, day, sep="-")
#cut to 1000 row
asteroids2<-asteroids2[1:1000,]
View(asteroids2)
#change column names for speed
colnames(asteroids2)[colnames(asteroids2)=="V.relative..km.s."] <- "Speed_kms"
#delete max speed column
asteroids2<-asteroids2[,-7]
asteroids2<-asteroids2[,-9]
asteroids2<-asteroids2[,-9]
#select columns charater and transform them in numeric like Diam_min
select_data<-select(asteroids2, Diam_min)
select_data<-data.frame(lapply(select_data,as.numeric))
select_data1<-select(asteroids2, Moondist_LD_nom)
select_data1<-data.frame(lapply(select_data1,as.numeric))

#delet old column
asteroids2<-asteroids2[,-8]
asteroids2<-asteroids2[,-4]
# bind new column back with numeric values
asteroids2<-bind_cols(asteroids2, select_data)
asteroids2<-bind_cols(asteroids2, select_data1)
write.csv(asteroids2, "asteroids_clean.csv")


##Now the data is ready we can play with it using ggplot2
asteroids_clean <- read.csv("asteroids_clean.csv")

#select Diam_min from less than 15m
#asteroids2<-subset(asteroids_clean,  Estimated.Diameter  < 500)


# 2 - Use ggplot() for the first instruction
  ggplot(asteroids_clean, aes(x = Date, y = Diam_min)) + geom_point()
#geom_histogram(binwidth = 1, stat="count")
