# Title: regex-functions.R
# Description: This is for being able create functions to run on vowels.
# Input(s): code
# Output(s): Result of functions
# Author(s): Soham Ghosh
# Date: 04-13-2019

#' @title split_chars
#' @description takes a character string, and splits the content
#' @param string
#' @return strings

split_chars <- function(x) {
  strsplit(x, split = c())[[1]]
}
split_chars('Go Bears!')

#' @title num_vowels
#' @description returns the number of vowels in a character vector 
#' @param character vector
#' @return vector

num_vowels <- function(x) {
  x <- table(x)
  vowel <- c('a','e','i','o','u')
  x <- x[vowel]
  x[is.na(x)] = 0
  names(x) = vowel
  x
}
vec <- c('G', 'o', ' ', 'B', 'e', 'a', 'r', 's', '!')
num_vowels(vec)

#' @title count_vowels
#' @description counts number of vowels
#' @param character string
#' @return vector

count_vowels <- function(x) {
  num_vowels(split_chars(tolower(x)))
}
count_vowels("The quick brown fox jumps over the lazy dog")

#' @title reverse_chars
#' @description reverses a string
#' @param character vector
#' @return character vector

reverse_chars <- function(x) {
  paste0(rev(split_chars(x)), collapse = '')
}
reverse_chars("gattaca")

#' @title reverse_words
#' @description reverses the words of a sentence
#' @param string
#' @return string

reverse_words <- function(x) {
  paste0(rev(str_split(x, " ")[[1]]), collapse = ' ')
}
reverse_words("sentence! this reverse")

