# Title: test-roll.R
# Description: Test roll function
# Input(s): code
# Output(s): testing to check if roll function runs
# Author(s): Soham Ghosh
# Date: 04-27-2018

context("Check arguments for the roll function")

test_that("check_times with ok values", {
  expect_true(check_times(1))
  expect_true(check_times(2))
  expect_true(check_times(3))
})

test_that("check_times with not ok values", {
  expect_error(check_times("one"),"\nargument 'times' must be a positive integer")
  expect_error(check_times(-1),"\nargument 'times' must be a positive integer")
  expect_error(check_times(x),"\nargument 'times' must be a positive integer")
})

test_that("roll works", {

  a = die(c(1, 2, 3, 4, 5, 6), c(1/6, 1/6, 1/6, 1/6, 1/6, 1/6))
  set.seed(1)
  b = roll(a,50)
  expect_equal(b[1], 1)
})

test_that("roll works", {

  a = die(c(6, 5, 4, 3, 2, 1),c(1/6, 1/6, 1/6, 1/6, 1/6, 1/6))
  set.seed(1)
  b = roll(a,10)
  expect_equal(b$rolls,c(6, 5, 1, 5, 3, 5, 2, 4, 1, 3))
})

test_that("index works", {

  a = die(c(6, 5, 4, 3, 2, 1),c(1/6, 1/6, 1/6, 1/6, 1/6, 1/6))
  set.seed(1)
  b = roll(a, 10)
  expect_equal(b[3], 4)
})

test_that("replace works", {

  a = die(c(6, 5, 4, 3, 2, 1),c(1/6, 1/6, 1/6, 1/6, 1/6, 1/6))
  set.seed(1)
  b = roll(a, 10)
  b[10] = 3
  #print(b$rolls)
  expect_equal(b[10],3)
})

test_that("add works", {

  a = die(c(7, 2, 3, 4, 5, 6),c(2/6, 0/6, 3/12, 1/12, 1/6, 1/6))
  set.seed(1)
  b = roll(a, 10)
  #print(b$rolls)
  c = b + 5
  expect_equal(c[11:15],c(7, 7, 6, 3, 5))
})

