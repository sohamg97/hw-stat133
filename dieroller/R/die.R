# Title: die.R
# Description: Functions for simulating a die roll.
# Input(s): code
# Output(s): Functions for simulating a die roll
# Author(s): Soham Ghosh
# Date: 04-22-2018

#' @title die
#' @description creating die object
#' @param x sides and probability
#' @return an object

die <- function(sides = c(1, 2, 3, 4, 5, 6), prob = c(1/6, 1/6, 1/6, 1/6, 1/6, 1/6)) {
  check_sides(sides)
  check_prob(prob)

  object <- list(
    sides = sides,
    prob = prob)
  class(object) <- "die"
  object
}

#' @title check_sides
#' @description check to see if sides vector is valid
#' @param side vector
#' @return TRUE or stop statement

check_sides <- function(sides) {
  if (length(sides) != 6) {
    stop("\n'sides' must be a vector of length 6")
  }
  if (!is.numeric(sides) & !is.character(sides)) {
    stop("\n'sides' must be a character or numeric vector")
  }
  TRUE
}

#' @title check_prob
#' @description checks to see if probability vector is valid
#' @param probability vector
#' @return TRUE or stop statement

check_prob <- function(prob) {
  if (length(prob) != 6 | !is.numeric(prob)) {
    stop("\n'prob' must be a numeric vector of length 6")
  }
  if (any(is.na(prob))) {
    stop("\n'prob' cannot contain missing values")
  }
  if (any(prob < 0) | any(prob > 1)) {
    stop("\n'prob' values must be between 0 and 1")
  }
  if (sum(prob) != 1) {
    stop("\nelements in 'prob' must add up to 1")
  }
  TRUE
}

#' @title print.die
#' @description prints out the tabular data of the object created
#' @param x 2 arguments
#' @return object

print.die <- function(x, ...) {
  cat('object "die"\n\n')
  dat = data.frame(side = x$sides,prob = x$prob)
  print(dat)
  invisible(x)
}

fair_die <- die()
fair_die

weird_die <- die(sides = c('i', 'ii', 'iii', 'iv', 'v', 'vi'))
weird_die

loaded_die <- die(prob = c(0.075, 0.1, 0.125, 0.15, 0.20, 0.35))
loaded_die
