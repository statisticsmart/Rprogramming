set.seed(123)

d1 <- data.frame(y=rnorm(20),
                 x=rnorm(20))
head(d1)

d2 <- data.frame(y=rnorm(30),
                 x=rnorm(30))
head(d2)

x <- list(d1=d1, d2=d2)
x
x$d1
x$d2

lapply(x, lm)

d1 <- data.frame(x1=rnorm(20),
                 x2=rnorm(20))
head(d1)

d2 <- data.frame(x1=rnorm(30),
                 x2=rnorm(30))
head(d2)

x <- list(d1=d1, d2=d2)
x
x$d1
x$d2

lapply(x, lm)

f1 <- function(data){
  lm(x2~x1, data=data)
}

lapply(x, f1)
