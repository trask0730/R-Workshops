##### What is R used for? #####
# R is often used for statistics
  # Very useful for life sciences
# There are other uses for R in data science
  # Plotting is easy with ggplot2
  # Ex: you can use R for mathematical modeling using ODEs as well as topological data analysis (tda).
  # Talk to me if you'd like to know more about either applications - we will see a taste of tda towards the end



##### How do I obtain R? #####
# R is FREE for anyone!
# I am using RStudio, which is a (free) integrated developement environment.






##### R Syntax #####

## The Basics ##
# As you've probably already guessed, we use '#' for comments.

# Variable assignment is done using '<-'.
  # Keyboard shortcut: 'alt' + '-'.
  # You can also use '=' but '<-' is preferred.

# Naming variables:
  # R IS case sensitive

x <- 3
X

# Insert strings using quotation marks
  # You can also use apostrophes, but observe what the outputs looks like below...

string <- "Hello world!"
print(string)

string2 <- 'Hello world!'
print(string2)

# Creating vectors

x <- c(2,4,6,8)
y <- seq(1,10)
names <- c('Alice', 'Bob', 'Catie', 'Dorothea')


## If statements ##
# An if statement is a conditional statement
# Tells the computer what to do, given certain conditions

# General format:

if (criteria){
  command
}

# Note: the "criteria" should be a logical statement

# An example

a = 7
b = 12

if (b > a) {
  print("b is greater than a")
}

typeof(b>a)

# Notice that if b is not greater than a, nothing is printed
# We fix this using "else"

a = 15
b = 12

if (b > a) {
  print("b is greater than a")
} else {
  print("b is not greater than a")
}

# General format:

if (cirteria){
  command1
} else {
  command2
}

# Command2 will execute if (criteria) is false.

# What if we want something telling us when a and b are equal, or if a is greater than b?
# We can specify more conditions using "else if"

a = 12
b = 12

if (b > a) {
  print("b is greater than a")
} else if (b < a) {
  print("b is less than a")
} else if (b == a) {
  print("b is equal to a")
}

# General format:

if (condition1) {
  command1
} else if (condition2) {
  command2
} 

# We can also nest if statements
# This is helpful if you want to satisfy two conditions

a = 12
b = 13

if (b >= a){
  if (a >= b){
    print("b is equal to a")
  } else {
    print("b is not equal to b")
  }
}

## For Loops ##
# A for loop iterates along a list

# General format:
for (name in list){
  command
}

# Here is an example

for (i in 1:20) {
  print(i / 2)
}

# Our list does not have to be made up of numbers, which we will see below

fruits <- list('apples', 'bananas', 'clementines', 'dragonfruits')

for (x in fruits){
  print(paste(x, 'are my favorite fruit'))
}

# We can nest for loops to allow for multiple iterations
# Think "sum of sums"

# General format:

for (name1 in list1) {
  for (name2 in list2) {
    command
  }
}

# Here is an example
#  This example is akin to expanding the polynomial (a*x + b)*(c*x + d)

poly1 <- c('a*x', 'b')
poly2 <- c('c*x', 'd')

for (x in poly1) {
  for (y in poly2){
    print(c(x, y))
  }
}


## Creating Functions ##
# General format:

function_name <- function(parameter1, parameter2){
  action
}

# We can also create a 'divide by 2' functions, as above:

half <- function(number){
  new <- number / 2
  print(new)
}

# Observe what happens if we input a vector vs a single number:

half(4)
half(y)

# As hinted above, functions can have multiple parameters:
add <- function(num1, num2){
  print(num1 + num2)
}

# We will encouter more R syntax throughout this document.
# Please interrupt if you see a symbol you are not familiar with! 
# I will explain as we go, but I might miss something :)


## Questions ##
# 1. What happens if you run the following:
      # add(4, y)
      # add(x, y)
  # Interpret the output and/or the error message. 
  


##### Using Built-In Packages in R #####

# R has a lot of useful packages built in
# Load a package by typing in the followig:
library(stats)
# The stats package is (often) preloaded, so you don't actually have to load it. 

# Alternatively, you can use the bottom right screen.
# Go to the "Packages" tab.
# Find the package you want to use, and click the box. 
# In the console, you'll see that the package was loaded.

# A common package utilized by data scientists as below:
library(tidyverse)
# When loading a new package, make sure to keep track of conflicts. 
# Tidyverse includes a package 'ggplot2' that we will cover today.

# We will use these packages throughout this workshop



##### Loading Data #####
# Let's practice loading data from a csv file into R
# If your csv file is in the same directory as your R file, then do the following:
# "Session" -> "Set Working Directory" -> "To Source File Location"
race_results <- data.frame(read.csv('./BlueSky2022.csv',
                                    header=TRUE, sep=","))

# Let's get some information about our data frame
nrow(race_results)
ncol(race_results)

dim(race_results)

# Suppose we are only interested in certain columns

time <- race_results[["Time"]]
bibs <- race_results[[1]]
place <- race_results[["Place"]]

# Or, suppose we are only interested in a certin row

first_place <- race_results[1, ]
first_place

# Suppose we are interested in finding the row with a specific bib number... 
# We can combine for loops and if statements to find out which row we need to look in!
for (i in 1:nrow(race_results)){
  if (race_results[i, "Bib"] == "10"){
    bib <- i
  }
}
bib_ten <- race_results[bib, ]
bib_ten

# Or, we can use the package 'dplyr' that was included in tidyverse
# dplyr is a useful package for wrangling data
race_results %>%
  filter(Bib == 10)



##### Statistics in R #####
# We can use R's built-in statistics package to get some statistics on our data.

# We can find the average of a list. 
# Let's find the average finish time of the marathon, in both minutes and hours
mean(time)
mean(time)/60

# Note that we cannot take a mean of non-numerical values
# For example:
mean(race_results[["Time.Weird"]])
typeof(race_results[["Time.Weird"]])

# As data scientists, we may (or, will likely) have to preprocess our data before working with it
# In the data above, I worked in excel to make the "time" a data type that R could perform arithmetic on

# We can also run t-tests
# Let's see whether a runner's bib number correlated to their place at the end of the race

# Let d be the difference between bib number and place
# We will test the hypothesis that on average d is close to 0
# If it is, then it is likley that a runner's bib number will predict their race result
d <- bibs - place 

t.test(d, alternative = "two.sided", conf.level = 0.95)

# Not sure what to put in the argument of this function?
help(t.test)

# You can also run two sample t-tests
# We'll show that here, but notice that this is not the best test to run in our case
# We are interested if each runner's bib number correpsonds to their finish place
t.test(bibs, place, alternative = "two.sided", conf.level = 0.95)

# We can also compute the 0th, 25th, 50th, 75th, and 100th percentiles:
quantile(race_results$Time)

# We can also find correlation coefficients
cor(race_results$Bib, race_results$Time)

# We can also plot data in a histogram

hist(time, breaks = c(0, 60, 120, 180, 240, 300, 360, 420, 480, 540, 600),
     main = "Frequency of Finish Times")


## Question ##
# 1. I used excel to create a column with a racer's finish time in minutes using the data from the column 'Time.Weird'
      # However, you can also do this using the command from dyplr 'mutate'
      # Using the command mutate, see if you can convert Time.Weird to time in minutes
      # Hint: you will have to get creative, given that the data type of Time.Weird is 'character'



##### Plotting with ggplot2 #####
# Although R does have plotting capabiltiies, ggplot2 is a great tool for data visualization

# Let's start with creating our plot
# Specify the data you are using and what the x- and y- axes are
ggplot(
  data = race_results,
  mapping = aes(x = .data[["Time"]], y = .data[["Place"]])
) + 
# notice no points showed up. We need to specify whow we want our data represented
  geom_point() +
# we can add a line of best fit
  geom_smooth(method = "lm") +
# lets add labels
  labs(
    title = "Finish Time vs. Place",
    subtitle = "Blue Sky Marathon 2022",
    x = "Finish Place", y = "Finish Time (minutes)"
  ) 
# what if we want to save our plot?
ggsave(filename = "time-vs-place.png")

# Note: we used R's built-in plotting for historgrams, but ggplot also does those.

# Play around with ggplot! There are a lot of cool plots you can create, not just scatterplots


## Questions ##
# 1. Plot Bib Number vs. Overall Place using ggplot2 and add a line of best fit. 
    # Compare your plot to the correlation coefficient between Bib and Place. Does this make sense? Why or why not?
# 2. Compute correlation coefficient between Time and Place. 
    # Compare this number to the plot of Time vs. Place. Does this make sense? Why or why not?
# 3. Play around with ggplot: colors, point styles, grid vs. no grid, etc. 
    # It's fun to make your plots visually appealling to you!



##### Linear Regression #####
# We've already used a linear regression model to get the line of best fit on our plot above
# Now, we dive into linear regression a bit

# We are assuking that the linear relationship between finish place place and finish time is approximately linear
# We want to learn the coefficients a_0 and a_1 in the model Place = a_0 + a_1*Time
linear_model <- lm(race_results$Place ~ race_results$Time, data = race_results)
coef(linear_model)

# We estimate that someone's overall place in the race increases by 1 whenever their finish time increases by 
# (about) 0.88 minutes 

# For a more in-depth summary:
summary(linear_model)
confint(linear_model, level = 0.95)

# Find the mean square error:
sigma(linear_model)^2

# Multiple linear regression
# We want to elarn the coefficients a_0, a_1, and a_2 in the model Place = a_0 + a_1*Time + a_2*Bib
m_linear_model <- lm(race_results$Place ~ race_results$Time + race_results$Bib, data = race_results)
coef(m_linear_model)
summary(m_linear_model)

## Questions ##
# 1. 


##### Acknowledgements #####

# I used OpenSplitTime to gather race results from the 2022 Blue Sky Marathon
# I used the following books as a reference: 
  #"Learning Base R" by Lawrence M. Leemis 
  # "R for Data Science" by Wickham, Rundel, and Grolemund. 
    # Available for free online here: https://r4ds.hadley.nz/
  # "Hands-On Machine Learning with R" by Bradley Boehmke and Brandon Greenwell
    # Available for free online here: https://bradleyboehmke.github.io/HOML/
# Shoutout to my undergraduate statistics professor (Dr. Timothy Lucas) for teaching me how to use R for statistics
# Thank YOU for coming to the workshop!

# To access this file again, go to my github page!
# https://github.com/trask0730
# Solutions will be on github soon! 
