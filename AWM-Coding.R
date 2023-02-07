##### What is R used for? #####
# R is often used for statistics
  # Very useful for life sciences
# There are other uses for R
  # Ex: you can use R for mathematical modeling using ODEs as well as topological data analysis.
  # Talk to me if you'd like to know more about either of those applications.

##### How do I obtain R? #####
# R is FREE for anyone!
# I am using RStudio, which is a (free) integrated developement environment.


  



##### Coding Tips & Tricks #####

# The following examples will work for any coding languages, although the syntax will be different
# We will focus specifically on if statements & for loops.

##### If statements #####
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

# Some problems to try yourself:
  # 1. Use if statements to write a program that tests whether a number is even or odd
      # Hint: you may find the floor() function useful
  # 2. Use if statements to write a program to tell you whether a student has met the prerequisites for Math 161
      # Assume the student has taken both m160 and m124 with a grade of A, B, C, D, or F.
      # Prerequisites of Math 161: 
      # D or higher in both Math 124 and Math 160
  # 3. Use if statements to write a program that will tell you whether the roots of a quadratic polynomial are real or imaginary






##### For Loops #####
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

fruits <- list('apple', 'banana', 'clementine', 'dragonfruit')
  
for (x in fruits){
  print(x)
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

# Some problems to try yourself:
  # 1. Use a for loop to find the squares of the integers 0-10
  # 2. Use for loops and if statements to record which of the integers from 0 to 50 are perfect squares
  # 3. Use for loops to count number of characters in each of the following fruit names:
      # "banana", "strawberry", "apple", "pear", "dragonfruit"
      # Hint: you may find the nchar() function useful






##### Using Built-In Packages in R #####

# R has a lot of useful packages built in
# Load a package by typing in the followig:
library(stats)
# The stats package is (often) preloaded, so you don't actually have to load it. 

# Alternatively, you can use the bottom right screen.
  # Go to the "Packages" tab.
  # Find the package you want to use, and click the box. 
  # In the console, you'll see that the package was loaded.

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

# We can use R's built-in statistics package to get some statistics on our data.

# We can find the average of a list. 
  # Let's find the average finish time of the marathon, in minutes and hours
mean(time)
mean(time)/60

# Note that we cannot take a mean of non-numerical values
# For example:
mean(race_results[["Time.Weird"]])
typeof(race_results[["Time.Weird"]])

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
  # This will tell us if the mean bib number is the same as the mean finish place
t.test(bibs, place, alternative = "two.sided", conf.level = 0.95)

# We can also plot data 

hist(time, breaks = c(0, 60, 120, 180, 240, 300, 360, 420, 480, 540, 600),
     main = "Frequency of Finish Times")

plot(time, place, pch=16, col='red', cex=0.7,
     xlab = 'Time', ylab = "Place", 
     main = "Finish Time vs. Place")

# We can add a line of best fit
abline(lm(place ~ time), col='blue', lty='dashed')

# Compare previous plot to the scatter plot of Bib Number vs. Overall Place, 
plot(bibs, place, pch=16, col='red', cex=0.7,
     xlab = 'Bib Number', ylab = "Place", 
     main = "Bib Number vs. Place")
abline(lm(place ~ bibs), col='blue', lty='dashed')






##### Acknowledgements #####

# I used OpenSplitTime to gather race results from the 2022 Blue Sky Marathon
# I used the following book as a reference: "Learning Base R" by Lawrence M. Leemis
# Shoutout to my undergraduate statistics professor (Dr. Timothy Lucas) for teaching me how to use R for statistics
# Thank YOU for coming to the workshop!

# To access this file again, go to my github page!
  # https://github.com/trask0730
  # Here, you can also find solutions to the sample problems in the file "Solutions.R"
