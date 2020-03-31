---
title: "STA 326 2.0 Programming and Data Analysis with R ^[All rights reserved by Thiyanga S. Talagala]"
subtitle: "Exploring `iris` dataset with `qplot`"
toc: TRUE
date: "31 March 2020"
geometry: "left=3cm,right=3cm,top=2cm,bottom=2cm"
output: pdf_document
---



\newpage

# Stage 1:  Planning your analysis

## Step 1: Dataset overview and description

Before we get started let's look at the data and plan a analysis.

**Load iris dataset**

```r
data(iris)
```

Here is a glimpse of the dataset.


```r
head(iris)
```

```
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
1          5.1         3.5          1.4         0.2  setosa
2          4.9         3.0          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa
4          4.6         3.1          1.5         0.2  setosa
5          5.0         3.6          1.4         0.2  setosa
6          5.4         3.9          1.7         0.4  setosa
```

We have four quantitative variables: Sepal.Length, Sepal.Width, Petal.Length, Petal.Width and one qualitative variable: Species

## Step 2: One-way analysis

Let's look at the graphs we could use to explore variables one by one.

Plots that could be used to to summarize qualitative variables

  - Bar chart

  - Pie chart

Plots that could be used to to summarize quantitative variables

  - Box and whisker plot

  - Histograms

  - Dot plots 

  - Density plot
  
  - Stem and leaf displays
  
Note: Stem and leaf displays are best-suited for small to moderate datasets, whereas others such as histograms and Box and whisker plots are best-suited for large datasets. Box and whisker plots and histograms are also good at depicting differences between distributions and identifying outliers.


## Step 3: Two-way analysis

Next, we will look at two variables at a time.

- Quantitative vs Quantitative: Scatter plots

- Quantitative vs Qualitative: Box plots/ Histograms/ Dot plots/ Density plots with groups allow us to compare across different levels of the qualitative variable. **Faceting** can be used to generate the same plot for different levels of the qualitative variable.

## Step 4: Three-way analysis

Now, let's look at three variables at a time.

- Two quantitative variables and one qualitative variable: Scatter plot with different markers  (eg: size, shapes, colours) for different levels of the qualitative variable.

# Stage 2: Getting started with `qplot()` in the ggplot2 package.

Now we are going to use the `qplot` function to make some quick plots. This section demonstrates how different graphs can be plotted for various purposes using the `qplot`.

## Recap: some important arguments in `qplot`


```r
qplot(
  x, # X variable
  y, # Y variable
  data, # name of the dataframe
  facets = NULL, 
  margins = FALSE,
  geom = "auto",
  xlim = c(NA, NA), # numeric vector of length 2 giving the x coordinates
  ylim = c(NA, NA), # numeric vector of length 2 giving the 7 coordinates
  log = "",
  main = NULL, # Figure title
  xlab = NULL, # X-axis title
  ylab = NULL, # Y-axis title
  asp = NA,
  stat = NULL,
  position = NULL,
)

```


\newpage
   
## One-way analysis

### Load packages


```r
library(ggplot2)
```

### 1. Summarizing qualitative variables


```r
qplot(x = Species, data = iris, geom = "bar", ylab = "Count",
      main = "Composition of Species")
```

![Composition of the sample](Week3Answers_files/figure-latex/unnamed-chunk-4-1.pdf) 

\newpage

### 2. Summarizing quantitative variables

Here, I have drawn plots only for `Sepal.Width`. Please take suitable graphs for other quantitative variables in the iris dataset.

#### Histogram


```r
qplot(x = Sepal.Width, data = iris, geom = "histogram")
```

![Histogram of sepal width](Week3Answers_files/figure-latex/unnamed-chunk-5-1.pdf) 

#### Density plot


```r
qplot(x = Sepal.Width, data = iris, geom = "density")
```

![Density plot of sepal width](Week3Answers_files/figure-latex/unnamed-chunk-6-1.pdf) 

\newpage

#### Box and whisker plot


```r
qplot(y = Sepal.Width, data = iris, geom = "boxplot")
```

![Boxplot of sepal width](Week3Answers_files/figure-latex/unnamed-chunk-7-1.pdf) 

## Two-way analysis

### 1. Visualizing two qualitative variables at a time


```r
qplot(x = Sepal.Length, y = Sepal.Width, data = iris, geom = "point")
```

![Scatterplot of sepal length and sepal width](Week3Answers_files/figure-latex/unnamed-chunk-8-1.pdf) 

\newpage

### 2. Visualizing qualitative and quantitative variables


```r
qplot(x = Species, y = Sepal.Width, data = iris, geom = "boxplot")
```

![Boxplot of sepal width by species](Week3Answers_files/figure-latex/unnamed-chunk-9-1.pdf) 

#### Different ways to modify your graph


```r
qplot(x = Species, y = Sepal.Width, data = iris, geom = "boxplot", fill = Species)
```

![Boxplot of sepal width by species](Week3Answers_files/figure-latex/unnamed-chunk-10-1.pdf) 

\newpage


```r
qplot(x = Species, y = Sepal.Width, data = iris, geom = c("point","jitter","boxplot"), 
      alpha = 0.5, colour = Species)
```

![Boxplot of sepal width by species](Week3Answers_files/figure-latex/unnamed-chunk-11-1.pdf) 


```r
qplot(x = Sepal.Width, data = iris, geom = c("histogram"), 
     colour = Species)
```

![Histogram of sepal width](Week3Answers_files/figure-latex/unnamed-chunk-12-1.pdf) 

\newpage


```r
qplot(x = Sepal.Width, data = iris, geom = c("histogram"), 
     fill = Species)
```

![Histogram of sepal width](Week3Answers_files/figure-latex/unnamed-chunk-13-1.pdf) 



```r
qplot(x = Sepal.Width, data = iris, geom = c("density"), 
     colour = Species)
```

![Density plot of sepal width](Week3Answers_files/figure-latex/unnamed-chunk-14-1.pdf) 

\newpage

## Three-way analysis

**Everything on a single panel**


```r
qplot(x = Sepal.Length, y = Sepal.Width, data = iris, 
      geom = "point", color = Species)
```

![Scatterplot of sepal length and sepal width by species](Week3Answers_files/figure-latex/unnamed-chunk-15-1.pdf) 


**Separate panels for each species: column-wise**


```r
qplot(x = Sepal.Length, y = Sepal.Width, 
      facets = .~Species, data = iris, geom = "point") 
```

![Scatterplot of sepal length and sepal width by species](Week3Answers_files/figure-latex/unnamed-chunk-16-1.pdf) 

\newpage

**Separate panels for each species: row-wise**


```r
qplot(x = Sepal.Length, y = Sepal.Width, 
      facets = Species~., data = iris, geom = "point")
```

![Scatterplot of sepal length and sepal width by species](Week3Answers_files/figure-latex/unnamed-chunk-17-1.pdf) 


\newpage

# `patchwork` package in R


```r
library(patchwork) 
```


First you need to assign a name for each graph. Here, I use `q1` and `q2`.


```r
q1 <- qplot(x = Species, y = Sepal.Width, data = iris, geom = c("point","jitter","boxplot"), 
      alpha = 0.5, colour = Species, main = "Distribution of Sepal.Width")
q2 <- qplot(x = Species, y = Sepal.Length, data = iris, geom = c("point","jitter","boxplot"), 
      alpha = 0.5, colour = Species, main = "Distribution of Sepal.Length")
```


## Arrange multiple graphs row-wise use "/"


```r
q1/q2
```

![Arrange multiple graphs row-wise](Week3Answers_files/figure-latex/unnamed-chunk-20-1.pdf) 

\newpage

## Arrange multiple graphs column-wise: use "|"


```r
q1|q2
```

![Arrange multiple graphs column-wise](Week3Answers_files/figure-latex/unnamed-chunk-21-1.pdf) 



\newpage

## Arrange multiple graphs both row-wise and column-wise


```r
(q1|q2)/(q1|q2)
```

![Arrange multiple graphs both row-wise and column-wise](Week3Answers_files/figure-latex/unnamed-chunk-22-1.pdf) 

\newpage

# Stage 3: Final analysis

You do not need to include all the graphs to your final analysis. Please select only the useful graphs which help you to tell the story in your dataset. Here is mine.

## 1. Composition of the sample



```r
qplot(x = Species, data = iris, geom = "bar", ylab = "Count", 
      colour = Species, fill = Species,
      main = "Composition of Species")
```

![Composition of the sample](Week3Answers_files/figure-latex/unnamed-chunk-23-1.pdf) 


\newpage

## 2. Distribution of the features of sepal and petal by species


```r
q1 <- qplot(x = Species, y = Sepal.Width, data = iris, geom = c("point","jitter","boxplot"), 
      alpha = 0.5, colour = Species, main = "(a) Distribution of Sepal Width")
q2 <- qplot(x = Species, y = Sepal.Length, data = iris, geom = c("point","jitter","boxplot"), 
      alpha = 0.5, colour = Species, main = "(b) Distribution of Sepal Length")
q3 <- qplot(x = Species, y = Petal.Width, data = iris, geom = c("point","jitter","boxplot"), 
      alpha = 0.5, colour = Species, main = "(c) Distribution of Petal Width")
q4 <- qplot(x = Species, y = Petal.Length, data = iris, geom = c("point","jitter","boxplot"), 
      alpha = 0.5, colour = Species, main = "(d) Distribution of Petal Length")
(q1|q2)/(q3|q4)
```

![Distribution of features related to sepal and petal by species](Week3Answers_files/figure-latex/unnamed-chunk-24-1.pdf) 

\newpage

## 3. Relationship between features of sepal and petal by species


```r
p1 <- qplot(x = Sepal.Length, y = Sepal.Width, data = iris, geom = c("point","jitter"), 
      alpha = 0.5, colour = Species, 
      main="(a) Sepal Length and Sepal Width")
p2 <- qplot(x = Petal.Length, y = Petal.Width, data = iris, geom = c("point","jitter"), 
      alpha = 0.5, colour = Species, 
      main = "(b) Petal Length and Petal Width")
p3 <- qplot(x = Sepal.Length, y = Petal.Length, data = iris, geom = c("point","jitter"), 
      alpha = 0.5, colour = Species, 
      main = "(c) Sepal Length and Petal Length")
p4 <- qplot(x = Sepal.Length, y = Petal.Width, data = iris, geom = c("point","jitter"), 
      alpha = 0.5, colour = Species, 
      main = "(d) Sepal length and Petal Width")
(p1|p2)/(p3|p4)
```

![Relationship between features of sepal and petal by species](Week3Answers_files/figure-latex/unnamed-chunk-25-1.pdf) 

**Note: Interpret all figures in your final analysis.**
