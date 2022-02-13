
#1. Rewrite rescale_minmax so that -Inf is set to 0, and Inf is mapped to 1.

rescale_minmax <- function(x) {
  rng <- range(x, na.rm = TRUE, finite = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}
a <- c(Inf, 0:5, NA, -Inf)
a
rescale_minmax(a)




#1. Rewrite rescale_minmax so that -Inf is set to 0, and Inf is mapped to 1.

rescale_minmax <- function(x) {
  rng <- range(x, na.rm = TRUE, finite = TRUE)
  trx <- (x - rng[1]) / (rng[2] - rng[1])
  trx[trx == Inf] <- 1
  trx[trx == -Inf] <- 0
  trx
}
a <- c(Inf, 0:5, NA, -Inf)
a
rescale_minmax(a)

#--------------------------------------------

#2. Practice turning the following code snippets into functions. Think about what each function does.
#What would you call it? How many arguments does it need? Can you rewrite it to be more expressive
#or less duplicative?

x <- 1:10
y <- c(NA, 1:9)
mean(is.na(x))
mean(is.na(y))
is.na(y)

x / sum(x, na.rm = TRUE)

sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)

prop_miss <- function(x) {
  mean(is.na(x))
}





my_prop <- function(x) {
  x / sum(x, na.rm = TRUE)
}

my_prop(x)
my_prop(1:2)



my_cvar <- function(x) { # coefficent of variation
  sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)
}

my_cvar(1:5)

#-----------------------------------------------
## Exercise 19.2.1, Question 4
## Variance
variance <- function(x) {
  n <- length(x)
  m <- mean(x)
  (1/(n - 1)) * sum((x - m)^2)
}
variance(c(1,2,3))

var(c(1,2,3)) # to check the answer using the built in function

## skewness
skewness <- function(x) {
  n <- length(x)
  v <- var(x)
  m <- mean(x)
  third.moment <- (1/(n - 2)) * sum((x - m)^3)
  third.moment/(var(x)^(3/2))
}
skewness(c(1, 2, 3, 4, 5))

## Regression problem

cal_reg <- function(x, y){
  nx <- length(x)
  ny <- length(y)
  x.intercept <- rep(1, nx)
  cbindx <- cbind(x.intercept, x)
  ymat<- matrix(y, ncol=1)
  beta <- solve(t(cbindx) %*% cbindx) %*% t(cbindx) %*% y
  beta
}
data(trees)
cal_reg(trees$Height, trees$Volume)

lm(trees$Volume~ trees$Height) # to check the answer using the built-in function

## Problem 1: cor
corcal <- function(x, y){
  meanx <- mean(x)
  meany <- mean(y)
  
  sdx <- sd(x)
  sdy <- sd(y)
  
  num <- sum((x-meanx) * (y-meany))
  deno <- sqrt((sum((x-meanx)^2)*sum((y-meany)^2)))
  
  num/deno
  
}

a <- 1:10
b <- 1:10

corcal(a, b)

corcal(trees$Height, trees$Volume)
cor(trees$Height, trees$Volume)

#Write a function to generate 100 random numbers from a 
#normal distribution and plot the distribution of the 
#random numbers. Your function should display 
#the generated random numbers and the corresponding plot.


library(ggplot2)
normal.ran <- function(n, mean, std, seed=0){
  set.seed <- seed
  numbers <- rnorm(n, mean=mean, sd=std)
  df <- data.frame(numbers = numbers)
  a <- list(ggplot2::qplot(data=df, y=numbers, geom="boxplot"),
            numbers)
  return(a)
}

normal.ran(100, mean=5, std=1, seed=123)

n = 100
mean = 5
std = 1
seed = 123

## zscore_al

cal_zscore <- function(math, phy, chem){
  mean.maths <- 60
  sd.math <- 10
  mean.chem <- 45
  sd.chem <- 20
  mean.phy <- 55
  sd.phy <- 5
  
  z.m <- (math-mean.maths)/sd.math
  z.p <- (phy-mean.phy)/sd.phy
  z.c <- (chem-mean.chem)/sd.chem
  
  (z.m+z.p+z.c)/3
}



cal_zscore(10, 5, 30)