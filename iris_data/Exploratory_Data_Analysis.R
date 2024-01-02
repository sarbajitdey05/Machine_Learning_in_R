### Loading data set Method 1

library(datasets)
data(iris)

### Loading data set Method 2

#install.packages("RCurl")
library(RCurl)
#read.csv(text = getURL("paste_URL"))

View(iris) # view the data

# Display summary statistics of your data

head(iris,4) # view first 4 lines
tail(iris,4) # view last 4 lines

summary(iris)
summary(iris$Sepal.Length)

# Check whether data set contains any missing value
sum(is.na(iris))

#install.packages("skimr")
library(skimr)

skim(iris) # data summary

# Grouping by Species using skim
iris %>%
  dplyr::group_by(Species) %>%
  skim()

### Quick data visualization
### R base plot

# Panel plots
plot(iris) 
plot(iris, col = "blue")

# Scatter plot
plot(iris$Sepal.Width, iris$Sepal.Length)

# Manually select color and name axis
plot(iris$Sepal.Width, iris$Sepal.Length, col = "red", 
     xlab = "Sepal Width", ylab = "Sepal Length")

# Histogram
hist(iris$Sepal.Width)
hist(iris$Sepal.Width, col = "orange") # Orange bars

# Feature plots using caret package
featurePlot(x = iris[,1:4], y = iris$Species, plot = "box",
            strip=strip.custom(par.strip.text=list(cex=.7)),
            scales = list(x = list(relation="free"),
                          y = list(relation="free")))
