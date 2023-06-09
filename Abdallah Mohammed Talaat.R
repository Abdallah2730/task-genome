setwd("E:/Abdallah Talaat/الكلية/رابعة بايو/الترم التاني/معمل تحليل البيانات الجينومية/labs")
getwd()
mytask <- read.csv('G4_howell.csv')
str(mytask)
summary(mytask)

#using factor , class and levels
class(mytask$sex)
mytask$sex = factor(mytask$sex)
summary(mytask$sex)
levels(mytask$sex) = c("Female","Male" )

# to remove kg word and dealing with weight as a number
mytask$weight = gsub(" kg","",mytask$weight)
class(mytask$weight)
mytask$weight = as.numeric(mytask$weight)

#to remove over weight column as it has all null value
mytask["Overweight"] = NULL

#dealing with missing values
install.packages("mice")
library(mice)
mytask[!complete.cases(mytask), ]
Pre.imputation = mice(mytask , m = 5, meth = c("pmm"), maxit = 20)
Pre.imputation$imp
mytask = complete(Pre.imputation, 5)

# age manipulation
for ( i in 1:length(mytask$age))
  mytask$age[i] = round(mytask$age[i])
mytask$age

#visualization
install.packages("tidyverse")
library(tidyverse)
library(ggplot2)
shape1 = ggplot(mytask)
shape1 = ggplot(mytask, aes(x=height, y=weight))
shape1
shape1 + geom_point()
bar_plot1 = ggplot(mytask, aes(x=sex, fill = sex))
bar_plot1 + geom_bar()