j### Introduction to R, Tisch Library, Fall 2014 ###

# getting help from R documentation 

?function
??function
help(function)


# R is like a fancy calculator 

5 + 5
1 * 2
4 ^ 2

a <- 1
b <- 2
a + b

A <- 3
a + b - A

round(3.145)

factorial(3)

sqrt(9)

mean(c(7.5,8.2,3.1,5.6,10.9,4.6))

factorial(round(2.0015) + 1)



## objects ##

foo <- 42

foo <- round(3.1415) +1

factorial(foo)

#remove object function

rm(foo)


## data types ##

class(0.00001)
class("hello")
paste("hello", "world")
3 > 4

fac <- factor(c("a", "b", "c"))
fac
class(fac)

## structures ##

vec <- c(1, 2, 3, 10, 100) 
vec
nvec <- c(one = 1, two = 2, three = 3)
nvec

mat <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2)
mat <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 3)
mat <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 3, byrow = TRUE)


df <- data.frame(c(1, 2, 3), c("R","S","T"), c(TRUE, FALSE, TRUE))

ndf <- data.frame(numbers = c(1, 2, 3),letters = c("R","S","T"), logic = c(TRUE, FALSE, TRUE))


## subsetting ##

vec <- c(6, 1, 3, 6, 10, 5)

df <- data.frame(
name = c("John", "Paul", "George", "Ringo"),
birth = c(1940, 1942, 1943, 1940),
instrument = c("guitar", "bass", "guitar", "drums")
)

vec[2] 
vec[c(5, 6)] 
vec[-c(5,6)] 
vec[vec > 5] 
lhh
df[c(2, 4), 3]
df[ , 1]
df[ , "instrument"]
df$instrument

#subsetting with integers

df[2,3]
df[c(2,4), c(2,3)]
df[c(2,4), 3]
df[1:4,1:2]

#subsetting with exclusion

vec[-c(5,6)] 

#subsetting with spaces

df[1, ]
df[ ,2]

#subsetting with names

df[ ,"birth"]
df[ ,c("name","birth")]
df$birth

#getting help

help(subset)
?subset

#subsetting with logicals
vec[c(FALSE,TRUE,FALSE,TRUE,TRUE,FALSE)]

#subsetting with logical operators & booleans
df[df$instrument == "guitar", ]
df[df$birth > 1940, 1]
df[df$birth < 1943 & df$instrument != "guitar", ]

#subsetting with subset() function
subset(df, birth > 1940, select = name)
subset(df, name == "Paul")
subset(df, select = birth)


## R packages ##

install.packages("ggplot2")
install.packages("plyr")

library(ggplot2)
library(plyr)

require(ggplot2)
require(plyr)

## baby names dataset ##

# set working directory 

getwd()
setwd("C:\path")

# import babynames dataset 
options(stringsAsFactors = FALSE)
bnames <- read.csv("bnames.csv")

#csv import
bnames <- read.csv("http://tufts.box.com/shared/static/ddv0an47fmwbwv40nmlo.csv")

# see the first and last 6 observations in dataset or specify n 

head(bnames)
tail(bnames)
head(bnames, n=10)

# open a spreadsheet view of data object 
View(bnames) 
fix(bnames)

#drop variable, not necessary because subsetting is preferred method
bnames$v6 <- NULL

#rename variables
names(bnames) <- c("year", "name", "prop", "sex", "soundex")

#basic summary of object
summary(bnames)

#subset function to create a new object with only "Joshua" names 

joshua <- subset(bnames, name == "Joshua")

#above line is equivalent to: 
joshua <- bnames[bnames$name == "Joshua", ] 

#mutate function to create a new variable derived from existing one
joshua <- mutate(joshua, perc = prop * 100)

#arrange function to sort on new variable, see the most popular years for Joshua
joshua <- arrange(joshua, desc(perc))
head(joshua, n=10)

#quick plot of popularity for Joshua over time
qplot(year, perc, data = joshua, geom = "line")
qplot(year, perc, data = joshua, geom = "point") 
qplot(year, perc, data = joshua, geom = "point", color = sex) 

#create a new subset to specify only boys named Joshua
joshua <- subset(joshua, name == "Joshua" & sex == "boy")

#quick plot with new subset and additional title
qplot(year, perc, data = joshua, geom = "line") + ggtitle("Popularity of Joshua, 1880-2008") 


### practice ###

#plot Joshua with Jacob#
j <- subset(bnames, name == "Joshua" & sex == "boy" | name == "Jacob" & sex == "boy" )
j <- mutate(j, perc = prop * 100)
qplot(year, perc, data = j, geom = "line", color = name)+ ggtitle("Popularity of Joshua and Jacob,1880-2008")



# your turn

# 1. Create a data frame containing a subset of your name.

# 2. Create a new percentage variable ‘perc’, where prop * 100

# 3. Create a plot of the popularity of your name over time. Weird trends? Do you need to subset again?

# 4. Reorder the rows from highest to lowest perc. What year was most popular for your name?

# 5. Reorder by year. What were the most popular names in your birth year?



## linear modeling- crime dataset ##

crime <- read.csv("crime.csv")
crime <- read.csv("http://tufts.box.com/shared/static/6n86k2kys1biw0c0x5t15dr4wvoepthy.csv")
head(crime)

#create linear model 
mod <- lm(tc2009 ~ low, data=crime)
mod #looking at model object will return only intercept and coefficient

#to see model summary "store and explore"
summary(mod) 

# turn off scientific notation  
options(scipen=999)

#to list residual and predicted values
predict(mod)
resid(mod)

#quick plot of data with regression line 
require(ggplot2)
qplot(low, tc2009, data = crime) + geom_smooth(method = "lm")
qplot(low, tc2009, data = crime) + geom_smooth(se = FALSE, method = "lm")
qplot(low, tc2009, data = crime) + geom_smooth(se = FALSE, method = "lm") +
  geom_text(aes(label=abbr),hjust=1, vjust=.5) + geom_jitter() 






#show boxplot
qplot(low, tc2009, data = crime,  geom = ("boxplot"))

#diagnostic plots

par(mfrow = c(2,2))


## linear modeling- heights dataset ##

heights <- read.csv("heights.csv")
heights <- read.csv("https://tufts.box.com/shared/static/q1ovh1hzc3qn95odazkd66n9yyzc3ntx.csv")

head(heights)

#create model
m1 <- lm(earn ~ height, data = heights)
m1
summary(m1)
predict(m1)
resid(m1)

#plot with regression line
qplot(height, earn, data = heights) + geom_smooth(method = "lm")

# effect of height and sex on earnings: introducting categorical variables to model 
# whathappened to the effect for height
m2 <- lm(earn ~ height + sex, data = heights)
summary(m2)

# change men to baseline to look female coefficient

heights$sex <- factor(heights$sex, levels = c("male", "female"))
m3 <- lm(earn ~ height + sex, data = heights)
summary(m3)

#plot with gender regression lines

qplot(height, earn, color= sex, data = heights) + geom_smooth(method = "lm", se = FALSE)


# effect of height, age, sex, race and education on earnings #

m4 <- lm(earn ~ height + sex + race + ed + age, data = heights)
coef(m4)
summary(m4)

#shortcut to regress on all variables #
m4 <- lm(earn ~ ., data = heights)
summary(m4)


#regression with interaction terms
m5 <- lm(earn ~ height + sex + height:sex, data = heights)

#export
sink(file="output.txt", split=TRUE) # start logging
print("This is the result from model m5")
print(summary(m5))
sink() ## sink with no arguments turns logging off

##
plot(m5)
par(mfrow = c(2,2))



