# Title: roll.R
# Description: Functions for simulating a roll of a die.
# Input(s): code
# Output(s): Returns object of class rolls
# Author(s): Soham Ghosh
# Date: 04-22-2018

#' @title roll
#' @description simulating roll of a die
#' @param sides and probability
#' @return an object

roll <- function(die, times = 1) {
  check_times(times)
  rolls <- sample(die$sides, size = times, replace = TRUE, prob = die$prob)
  make_roll(die, rolls)
}

#' @title check_times
#' @description checks if the number of times is valid
#' @param number of rolls
#' @return TRUE or stop statement

check_times <- function(times) {
  if (times <= 0 | !is.numeric(times)) {
    stop("\nargument 'times' must be a positive integer")
  } else {
    TRUE
  }
}

#' @title make_roll
#' @description makes a list of the roll
#' @param die and number of rolls
#' @return a list of an object

make_roll <- function(die, rolls) {
  res <- list(
    rolls = rolls,
    sides = die$sides,
    prob = die$prob,
    total = length(rolls)
  )
  class(res) <- "roll"
  res
}

#' @title print.roll
#' @description shows the simulation results
#' @param die and number of rolls
#' @return an object in list form

print.roll <- function(die, ...) {
  cat('object "roll"\n\n')
  cat('$rolls\n')
  cat(die$rolls, "\n")
  invisible(die)
}

fair_die <- die()
fair_50rolls <- roll(fair_die, times = 50)
fair_50rolls
names(fair_50rolls)
fair_50rolls$rolls
fair_50rolls$sides
fair_50rolls$prob
fair_50rolls$total

str_die <- die(
  sides = c('a', 'b', 'c', 'd', 'e', 'f'),
  prob = c(0.075, 0.1, 0.125, 0.15, 0.20, 0.35))
set.seed(123)
str_rolls <- roll(str_die, times = 20)
names(str_rolls)
str_rolls

# Summary Method for Roll Object

#' @title summary.roll
#' @description gives a summary of the simulated rolls
#' @param x a certain die
#' @return data frame of sides, count, and proportions

summary.roll <- function(x, ...) {
  proportions <- c(
    sum(x$rolls == x$sides[1]) / x$total,
    sum(x$rolls == x$sides[2]) / x$total,
    sum(x$rolls == x$sides[3]) / x$total,
    sum(x$rolls == x$sides[4]) / x$total,
    sum(x$rolls == x$sides[5]) / x$total,
    sum(x$rolls == x$sides[6]) / x$total
  )
  counts <- c(sum(x$rolls == x$sides[1]),
              sum(x$rolls == x$sides[2]),
              sum(x$rolls == x$sides[3]),
              sum(x$rolls == x$sides[4]),
              sum(x$rolls == x$sides[5]),
              sum(x$rolls == x$sides[6]))
  freqs <- data.frame(
    side = x$sides,
    count = counts,
    prop = proportions)
  obj <- list(freqs = freqs)
  class(obj) <- "summary.roll"
  obj
}
set.seed(123)
fair_50rolls <- roll(fair_die, times = 50)
fair50_sum <- summary(fair_50rolls)
fair50_sum
class(fair50_sum)
names(fair50_sum)
fair50_sum$freqs

#' @title print.summary.roll
#' @description shows the summary of the simulation results
#' @param x die with sides and number of roles
#' @return print of summary data frame

print.summary.roll <- function(x, ...) {
  cat('summary "roll"\n\n')
  print(x$freqs)
  invisible(x)
}
print.summary.roll(fair50_sum)

#' @title plot.roll
#' @description shows a bar graph of the simulation of die rolls
#' @param x sides and number of rolls of die
#' @return a bar graph

plot.roll <- function(x, ...){
  roll_summary = summary(x)
  barplot(roll_summary$freqs$prop,
          names.arg = x$sides,
          ylab = "relative frequencies",
          xlab = "sides of die",
          main = sprintf("Relative frequencies in a series of %s die rolls", toString(length(x$rolls)))
  )
}
plot(fair_50rolls)

# Additional Methods

#' @title extraction
#' @description extract the value of a given roll
#' @param x, sides and rolls of a die
#' @return value of the i th roll

"[.roll" <- function(roll, i) {
  roll$rolls[i]
}

#' @title replacement
#' @description replace the value of a given roll
#' @param x, sides and rolls of a die
#' @return roll object

"[<-.roll" <- function(roll, i, value) {
  if (value != roll$sides[1] & value != roll$sides[2] & value != roll$sides[3] & value != roll$sides[4] & value != roll$sides[5] & value != roll$sides[6]) {
    stop(sprintf('\nreplacing value must be %s, %s, %s, %s, %s, %s', roll$sides[1], roll$sides[2],roll$sides[3], roll$sides[4], roll$sides[5], roll$sides[6]))
  }
  if (i > roll$total) {
    stop("\nindex out of bounds")
  }
  roll$rolls[i] <- value
  make_roll(roll$die, roll$rolls)
}

#' @title addition
#' @description adds more rolls
#' @param x, die rolls and sides
#' @return new roll object

"+.roll" <- function(roll, incr) {
  if (length(incr) != 1 | incr <= 0) {
    stop("\ninvalid increament")
  }
  more_rolls <- roll(die(roll$sides,roll$prob), times = incr)
  make_roll(die(roll$sides,roll$prob), c(roll$rolls, more_rolls$rolls))
}

set.seed(123)
fair_die <- die()
fair500 <- roll(fair_die, times = 500)
summary(fair500)
fair500[500]
make_roll(fair_die, 50)
fair600 <- fair500 + 100
summary(fair600)
plot(fair500, 500)
