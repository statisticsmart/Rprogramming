# Factors (09-May-2020)
## Run the following lines and explore the output.

## Create a numeric vector called data.
data <- rep(c(1, 2, 3), 4)
data
## Convert data into factors
fdata <- factor(data)
fdata
## We want to display values as Roman numerals
roman_fdata <- factor(data, labels=c("I", "II", "III"))
roman_fdata
## To convert the default factor fdata to roman numerals, we use the assignment form of the levels function.
levels(fdata) <- c("I", "II", "III")
fdata

#-------------
## Changing and reordering factors
## Create a character vector
test.results <- rep(c("+", "-"), times=c(150, 30))
test.results
## Observe the class type
class(test.results)
## Convert test.results into a factor
ftest.results <- factor(test.results)
ftest.results
levels(ftest.results)
## Change the level names
levels(ftest.results) <- c("Negative", "Positive")
ftest.results
levels(ftest.results)
## Plot a barchart using qplot
library(ggplot2)
qplot(ftest.results, geom = "bar")
## Change x-axis label
qplot(ftest.results, geom = "bar") + xlab("test outcome")
## Add y-axis label
qplot(ftest.results, geom = "bar") + xlab("test outcome") + ylab("Count")
## Add a title
qplot(ftest.results, geom = "bar") + xlab("test outcome") + ylab("Count") + ggtitle("PCR results")

#------------
## Factors can take only predefined values
letter.vec <- factor(LETTERS[1:6],
                     levels = LETTERS[1:4])
letter.vec
levels(letter.vec)
## To explore LETTERS and letters functions (additional)
LETTERS[1:10]
letters[1:10]

#-------------
## Load iris dataset
data(iris)
class(iris)
class(iris$Sepal.Width)
## Distribution of Sepal.Width by Species
qplot(x = Species, y = Sepal.Width, data = iris, geom = "boxplot", fill = Species)
## Reorder the boxplots according to the accending order
## First convert Species into a factor
iris$Species <- factor(iris$Species)
## Next change the order of levels
iris$Species <- factor(iris$Species, levels=c( "versicolor", "virginica", "setosa")) 
qplot(x = Species, y = Sepal.Width, data = iris, geom = "boxplot", fill = Species)
## Change the label names (observe the difference with the previous command
## iris$Species <- factor(iris$Species, levels=c("setosa", "versicolor", "virginica")))
iris$Species <- factor(iris$Species, labels=c("SE", "VE", "VI")) # We changed labels not the order (earlier we changed the order not the label names)
qplot(x = Species, y = Sepal.Width, data = iris, geom = "boxplot", fill = Species)

#-------------
# Now let's work with diamonds dataset in ggplot2
## Load data
data("diamonds")
## Class type
class(diamonds)
## First 10 rows of the variable
head(diamonds)
## To read the description file of the diamonds dataset
?diamonds
## Plot cut variable. ## cut variable represents the quality of the cut as
## Fair, Good, Very Good, Premium, Ideal. 
table(diamonds$cut)
qplot(diamonds$cut, geom = "bar")
## In the above output default order is not alphabetical. Why?
class(diamonds$cut) 
# The class type is both ordered and factor. Hence, you do not need to manually set the orders.


