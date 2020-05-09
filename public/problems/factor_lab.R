# Factors
## Run the following lines and explore the outputs.

## The data set we want to convert into factor
data <- rep(c(1, 2, 3), 4)
data
## Convert data into factors
fdata <- factor(data)
fdata
## We want to display values as Roman numerals
roman_fdata <- factor(data, labels=c("I", "II", "III"))
roman_fdata
## To convert the default factor fdata to roman numerals, we use the assignment form of the levels function
levels(fdata) <- c("I", "II", "III")
fdata

#-------------
## Changing and reordering factors
test.results <- rep(c("+", "-"), times=c(150, 30))
test.results
ftest.results <- factor(test.results)
ftest.results
levels(ftest.results)
## Change the lavel names
levels(ftest.results) <- c("Negative", "Positive")
ftest.results
levels(ftest.results)
## plot barchart using qplot
library(ggplot2)
qplot(ftest.results, geom = "bar")
## Change x-axis label
qplot(ftest.results, geom = "bar") + xlab("test outcome")
## Adde y-axis label
qplot(ftest.results, geom = "bar") + xlab("test outcome") + ylab("Count")
## Add a title
qplot(ftest.results, geom = "bar") + xlab("test outcome") + ylab("Count") + ggtitle("PCR results")

#------------
## Factors can take only predefined values
letter.vec <- factor(LETTERS[1:6],
                     levels = LETTERS[1:4])
letter.vec
levels(letter.vec)

#-------------
## load iris dataset
data(iris)
class(iris)
class(iris$Sepal.Width)
## Distribution of Sepal.Width by Species
qplot(x = Species, y = Sepal.Width, data = iris, geom = "boxplot", fill = Species)
## reorder the boxplots according to the accending order
## First convert Species into a factor
iris$Species <- factor(iris$Species)
## Next change the order of levels
iris$Species <- factor(iris$Species, levels=c("setosa", "versicolor", "virginica")) 
qplot(x = Species, y = Sepal.Width, data = iris, geom = "boxplot", fill = Species)
## If you want to change the labels (observe the difference with the previous command
## iris$Species <- factor(iris$Species, levels=c("setosa", "versicolor", "virginica")))
iris$Species <- factor(iris$Species, labels=c("SE", "VE", "VI")) # We change labels not the order (earlier we change the order not the label names)

#-------------
# Now let's work with diamonds dataset in ggplot2
## load data
data("diamonds")
## class type
class(diamonds)
## First 10 rows of the variable
head(diamonds)
## To read the description file of the diamonds dataset
?diamonds
## plot cut variable. ## cut variable represents the quality of the cut as
## Fair, Good, Very Good, Premium, Ideal. 
table(diamonds$cut)
qplot(diamonds$cut, geom = "bar")
## Observe in the above output defaul order
## is not alphabetical. Why?
class(diamonds$cut) 
# The class type is both ordered and factor. Hence, you
## do not need to manually set the orders.


