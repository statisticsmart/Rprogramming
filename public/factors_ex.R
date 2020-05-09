# Factors tutorial

## First load libraries
library(tidyverse)

## Load data set
data(diamond)

## Explore the dataset
### To obtain the helpfile
?diamond
### To observe the type of data
typeof(diamond)
### To see the first few observations
head(diamond)
### To get glimpse of the data
glimpse(diamond)
### Dimensions of the dataset
dim(diamond)

#***************
#Q1: Identify tscales of measurement of every column (Nominal, Ordinal, Ratio, Interval)

#***************


summary(diamond)
#***************
#Q2: Are there any missing values in the dataset?
#***************

## Data visualisation
#1. Using qplot

#2. Change the about plot to

#3. Add a title to your graph

#4. Add a label to x-axis

#5. Add a label y-axis


#3. Using ggplot: Run the code and observe the output
#(This is to familiarise you with ggplot codeing,
#We will talk more about this in our upcoming lectures).



