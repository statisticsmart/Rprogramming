## Question 1
library(gapminder)
map(gapminder, ~length(unique(.x)))

## Question 2
map_int(gapminder, ~length(unique(.x))
        
        
## Question 3
iris_species <- split(iris, iris$Species)
models <- map(iris_species, ~ lm(Sepal.Length ~ Sepal.Width, data = .x))

## Question 4
preds <- map2(models, iris_species, predict)
head(preds, 3)
