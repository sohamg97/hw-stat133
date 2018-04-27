# Title: test-die.R
# Description: Test die function
# Input(s): code
# Output(s): testing to check if die function runs
# Author(s): Soham Ghosh
# Date: 04-27-2018

context("Check die arguments")

test_that("check_sides with ok vectors", {

  expect_true(check_sides(c(111,222,333,444,555,666)))
  expect_true(check_sides(c("a", "b","c","d","e","f")))
})


test_that("check_sides fails with invalid lengths", {

  expect_error(check_sides(c('one', 'two', 'three')))
  expect_error(check_sides(c('one')))
  expect_error(check_sides(1:5))
  expect_error(check_sides(1))
})


test_that("check_sides fails with invalid types", {

  expect_error(check_sides(c('one', 'two', 'three')))
  expect_error(check_sides(c('one')),
               "\n'sides' must be a vector of length 6")
})


test_that("check_prob works", {

  expect_true(check_prob(c(1/6,1/6,1/6,1/6,1/6,1/6)))
  expect_true(check_prob(c(1/4, 1/4, 1/4, 1/12, 1/12, 1/12)))
})


test_that("check_prob fails with invalid lengths", {

  expect_error(check_prob(1:4))
  expect_error(check_prob(1))
})


test_that("check_prob fails with invalid probabilities", {

  expect_error(check_prob(0.16, 0.16, 0.16, 0.16, 0.16, 0.16))
  expect_error(check_prob(0.1, 0.2, 0.3, 0.4, -0.5, 0.5))
  expect_error(check_prob(NA, NA, NA, NA, NA, NA))
})

test_that("die works with valid parameters", {

  a = die(c('a', 'b', 'c', 'd', 'e', 'f'),c(2/6, 0/6, 2/6, 0/6, 2/6, 0/6))
  expect_equal(a$sides, c('a', 'b', 'c', 'd', 'e', 'f'))
  expect_equal(a$prob, c(2/6, 0/6, 2/6, 0/6, 2/6, 0/6))
})

test_that("die doesn't work with invalid parameters  ", {
  expect_error(die(c(1, 2, 3, 4, 5),c(1/6, 1/6, 1/6, 1/6, 1/6)))
})





