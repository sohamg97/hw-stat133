# Title: archive-functions.R
# Description: This is for being able to read archive data.
# Input(s): code
# Output(s): Reading archive data
# Author(s): Soham Ghosh
# Date: 04-11-2019

library(XML)
library(stringr)
library(ggplot2)

# 1.1) Read Archive Data Table

#' @title read_archive
#' @description returns a data frame from HTML table
#' @param string package name
#' @return data frame

read_archive <- function(string = '') {
  url <- paste0('http://cran.r-project.org/src/contrib/Archive/', string)
  table_html <- readHTMLTable(url)
  return(data.frame(table_html[1]))
}
raw_data <- read_archive('stringr')
raw_data

# 1.2) Data Cleaning

#' @title clean_archive
#' @description cleans up the data
#' @param product of read_archive function from earlier
#' @return a data frame 

clean_archive <- function(x) {
  n <- dim(x)[1] -1
  x <- x[3:n, ]
  name <- sapply(x$NULL.Name, version_names)
  version <- sapply(x$NULL.Name, version_numbers)
  date <- as.Date(sapply(x$NULL.Last.modified, version_dates), origin = "1970-01-01")
  size <- sapply(x$NULL.Size, version_sizes)
  return(data.frame(name, version, date, size))
}


#' @title version_names
#' @description extracts name of package
#' @param string
#' @return string

version_names <- function(x) {
  final <- str_split_fixed(x, '_', n = 2)
  return(final[1])
}

#' @title version_numbers
#' @description extracts number of the version
#' @param string
#' @return string

version_numbers <- function(x) {
  rough <- str_split_fixed(x, '_', n=2)
  final <- str_replace(rough[2], ".tar.gz", '')
  return(final)
}

#' @title version_dates
#' @description extracts dates of the version
#' @param string
#' @return string

version_dates <- function(x) {
  rough <- str_split_fixed(x, " ", n = 2)
  final <- rough[1]
  date <- as.Date(final)
  format(date, '%Y-%m-%d')
  return(date)
}

#' @title version_sizes
#' @description extracts sizes of the version
#' @param data frame
#' @return data frame

version_sizes <- function(x){
  number <- str_sub(x, 0, -2)
  type <- str_sub(x, -1)
  if(type == "K"){
    return(as.numeric(number))
  }
  else{
    return(1000*as.numeric(number))
  }
}

clean_data <- clean_archive(raw_data)
clean_data

###1.3) Timeline Plot

#' @title plot_archive
#' @description creates a timeline of version sizes
#' @param data frame
#' @return plot

plot_archive <- function(dat){
  title <- paste0(dat$name[1], ": timeline of version size")
  ggplot(dat, aes(x = dat$date, y = dat$size)) +
    labs(title = title, y = 'Size (kilobytes)', x = 'Date') +
    geom_step()
}

plot_archive(clean_data)



