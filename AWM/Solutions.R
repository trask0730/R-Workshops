##### Solutions to the Practice Problems in "AWM-Coding.R" #####
# Disclaimer: these are niether the only ways to solve the given problems, nor can I guarantee they're the most efficient


# Use if statements to write a program that tests whether a number if even or odd

a = 3
  
if (a/2 - floor(a/2) == 0){
  print("a is even")
} else {
  print("a is odd")
}


# Use if statements to write a program to tell you whether a student has met the prerequisites for Math 161
  # Assume the student has taken both m160 and m124 with a grade of A, B, C, D, or F.
  # Prerequisites of Math 161: 
  # D or higher in both Math 124 and Math 160

m124 <- "C"
m160 <- "B"

if (m124 != "F"){
  if (m160 != "F"){
    print("The student has met the prerequisites for Math 161")
  } else {
    print("The student has not met the prerequisites for Math 161")
  }
} else {
  print("The student has not met the prerequisites for Math 161")
}
    

# Use if statements to write a program that will tell you whether the roots of a quadratic polynomial are real or imaginary

# I will be sing the form a*x^2 + b*x + c
a <- 4
b <- 3
c <- 2
disc <- b^2 - 4*a*c

if (disc > 0) {
  print("The polynomial has 2 real roots")
} else if (disc == 0) {
  print("The polynomial has 1 real, repeated root")
} else if (disc < 0) {
  print("The polynomial has 2 complex roots")
}
    

# Use a for loop to find the squares of the integers 0-10

for (x in 0:10){
  print(x*x)
}


# Use for loops and if statements to find which of the integers from 0 to 50 are perfect squares

for (x in 0:50){
  if (sqrt(x) - floor(sqrt(x)) == 0){
    print(x)
  }
}


# Use for loops to count number of characters in each of the following fruit names:
    # "banana", "strawberry", "apple", "pear", "dragonfruit"

frootz <- c("banana", "strawberry", "apple", "pear", "dragonfruit")

for (fruit in frootz){
  print(nchar(fruit))
}


