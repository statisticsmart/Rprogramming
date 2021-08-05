## With return without return --------
add_numbers <- function(x, y){
  x+y # output last line
  
}
add_numbers(2, 3)

#-------------------------------------

mul_numbers <- function(x, y){
  return(x*y) # output 
  x+y
  
}
mul_numbers(2, 3)

#-------------------------------------

modifymul_numbers <- function(x, y){
  x*y 
  x+y # output 
  
}
modifymul_numbers(2, 3)

#-------------------------------------

## zscore_al - global vs local variables
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


#-------------------------------------

## R for Data Science-Exercises 19.4.4 - Q2
library(lubridate)
greeter <- function(time = now()) {
  
  htime <- lubridate::hour(time)
  
  if (5 < htime | htime <= 12) {
    print("Good morning")
  } else if ( 12 < htime | htime < 18) {
    print("Good afternoon")
  } else {
    print("Good evening")
  }
  
}

greeter(now())
greeter("2021-08-05 06:57:22 +0530")


#-------------------------------------
##
#Write a for loop that iterates over the 
#numbers 1 to 4 and prints the squared of each 
#number using print().

for(i in 1:4){
  print(i^2)
}

#-------------------------------------

## Write a function to count the number of 
## even numbers in a vector.

#Method 1
count_even <- function(x){
  
  cnt <- 0
  lenx <- length(x)
  
  for(j in 1:lenx){
    
    if (x[j] %% 2 ==0){
      cnt = cnt + 1
    }
    
  }
  
  cnt
}
count_even(1:10)

# Method 2
 x <- c(2, 5, 6, 7, 8, 10)
 count <- 0
 
 for (val in x){
   
  if(val %% 2 ==0) count = count + 1
 }
count

#-------------------------------------

#Write a function to print random numbers from the 
#standard normal distribution but stops (breaks) 
#if you get a number bigger than 1.

set.seed(1)
repeat {
  x<-rnorm(1)
  print(x)
  if(x > 1L){
    break
  }
}

#-------------------------------------

# Using next adapt the loop from last 
#exercise so that doesn’t print negative numbers.

repeat {
  x <- rnorm(1)
  
  if( x < 0){
    next
  }
  
  print(x)
  
  if(x > 1L){
    break
  }
}

#-------------------------------------

## switch illustration

x <- "a"
v <- switch(x, "a" = "apple",
               "b" = "banana",
               "c" = "cherry")
v

switch(c("a", "b"), "a" = "apple", # not working
       "b" = "banana",
       "c" = "cherry")
