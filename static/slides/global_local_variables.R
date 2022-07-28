## Local and global variables
y <- 1:10 #global variable

f1 <- function(x){
  z <- 10 # local variable
  x + z
}

y
z
f1(1:3)
y
z

f2 <- function(x){
  z <- 10 # local variable
  w <<- 100
  x + z + w
}

z

w

f2(1:3)

w
