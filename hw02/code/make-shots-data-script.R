#==============================================================================
#title: Make-Shots-Data-Script
#description: The script is about data preparation.
#input(s): andre-iguodala.csv, kevin-durant.csv, draymond-green.csv, klay-thompson.csv, stephen-curry.csv 
#output(s): shot-data.csv
#==============================================================================

library(dplyr)
library(readr)

curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)

Curry <- mutate(curry, name = "Stephen Curry")
Iguodala <- mutate(iguodala, name = "Andre Iguodala")
Durant <- mutate(durant, name = "Kevin Durant")
Thompson <- mutate(thompson, name = "Klay Thompson")
Green <- mutate(green, name = "Draymond Green")

Curry$shot_made_flag[Curry$shot_made_flag == "y"] = "made_shot"
Curry$shot_made_flag[Curry$shot_made_flag == "n"] = "missed_shot"

Iguodala$shot_made_flag[Iguodala$shot_made_flag == "y"] = "made_shot"
Iguodala$shot_made_flag[Iguodala$shot_made_flag == "n"] = "missed_shot"

Durant$shot_made_flag[Durant$shot_made_flag == "y"] = "made_shot"
Durant$shot_made_flag[Durant$shot_made_flag == "n"] = "missed_shot"

Thompson$shot_made_flag[Thompson$shot_made_flag == "y"] = "made_shot"
Thompson$shot_made_flag[Thompson$shot_made_flag == "n"] = "missed_shot"

Green$shot_made_flag[Green$shot_made_flag == "y"] = "made_shot"
Green$shot_made_flag[Green$shot_made_flag == "n"] = "missed_shot"

Curry <- mutate(Curry, minute = (period-1) * 12 + (12 - minutes_remaining))
Iguodala <- mutate(Iguodala, minute = (period-1) * 12 + (12 - minutes_remaining))
Durant <- mutate(Durant, minute = (period-1) * 12 + (12 - minutes_remaining))
Thompson <- mutate(Thompson, minute = (period-1) * 12 + (12 - minutes_remaining))
Green <- mutate(Green, minute = (period-1) * 12 + (12 - minutes_remaining))

sink(file = "../output/stephen-curry-summary-text")
summary(Curry)
sink()

sink(file = "../output/andre-iguodala-summary-text")
summary(Iguodala)
sink()

sink(file = "../output/kevin-durant-summary-text")
summary(Durant)
sink()

sink(file = "../output/klay-thompson-summary-text")
summary(Thompson)
sink()

sink(file = "../output/draymon-green-summary-text")
summary(Green)
sink()

combined <- rbind(Curry, Iguodala, Durant, Thompson, Green, deparse.level = 1) 
write_csv(combined, "../data/shots-data.csv")

sink(file = "../output/shots-data-summary.txt")
summary(combined)
sink()




  