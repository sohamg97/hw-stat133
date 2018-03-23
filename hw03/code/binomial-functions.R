# Title: binomial-function.R
# Description: This is about using functions to create the binomial equation.
# Input(s): code
# Output(s): Functions for the binomial equations
# Author(s): Soham Ghosh
# Date: 03-22-2019

#' @title is_integer
#' @description Checks to see if the number is an integer or not.
#' @param Put in a number
#' @return True or False

is_integer <- function(x = 0) {
  y = 1 
  while(y < x) {
    y = y + 1
  }
  if(x%%y == 0) {
    return(TRUE)
  }
  return(FALSE)
}
is_integer(-1)
is_integer(0)
is_integer(2)

#' @title is_positive
#' @description Checks to see if the number is positive or not.
#' @param Put in a number
#' @return True or False

is_positive <- function(x = 0) {
  if (x > 0) {
    return(TRUE)
  }
  else return(FALSE)
}
is_positive(0.01)
is_positive(-2)
is_positive(2)

#' @title is_nonnegative
#' @description Checks to see if the number is nonnegative
#' @param Put in a number
#' @return True or False

is_nonnegative <- function(x = 0) {
  if (x >= 0) {
    return(TRUE)
  }
  else return(FALSE)
}
is_nonnegative(0)
is_nonnegative(-0.00001)

#' @title is_positive_integer
#' @description Checks to see if the number is positive and an integer
#' @param Put in a number
#' @return True or False

is_positive_integer <- function(x = 0){
  if (is_integer(x)){
    return(is_positive(x))
  }
  return(FALSE)
}
is_positive_integer(2)
is_positive_integer(0)

is_nonneg_integer <- function(x = 0) {
  if (is_integer(x)) {
    return(is_nonnegative(x))
  }
  else return(FALSE)
}
is_nonneg_integer(0)
is_nonneg_integer(-1)

is_probability <- function(x = 0) {
  if (is_nonnegative(x)) {
    if (x <= 1) {
      return(TRUE)
    }
  }
  return(FALSE)
}
is_probability(0)
is_probability(0.5)
is_probability(1)
is_probability(-1)
is_probability(1.0000001)

bin_factorial <- function(x) {
  y = 1
  while(x > 1) {
    y = y * x
    x = x - 1
  }
  return(y)
}
bin_factorial(5)
bin_factorial(0)

bin_combinations <- function(n,k) {
  num = bin_factorial(n)
  den = bin_factorial(n-k) * bin_factorial(k)
  return(num/den)
}

bin_combinations(n = 5, k = 2)
bin_combinations(10, 3)
bin_combinations(4, 4)

bin_probability <- function(trials, successes, probability) {
  if (is_nonneg_integer(trials) && is_nonneg_integer(successes) && is_probability(probability)){
    total = bin_combinations(trials, successes)
    val = (probability**successes) * ((1-probability)**(trials - successes))
    return(total*val)
  }
  return(0)
}
bin_probability(trials = 5, success = 2, probability = 0.5)

bin_distribution <- function(trials, p){
  success = seq(0,trials)
  probability = rep(0,trials+1)
  for(i in 0:(length(success)-1)){
    probability [i+1] = bin_probability(trials,i,p)
  }
  return(data.frame(success,probability))
}
bin_distribution(trials = 5, p = 0.5)



