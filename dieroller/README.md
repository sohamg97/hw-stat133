The purpose of this assignment is to create an R package that implements functions for
simulating rolling a die. And then use the package to approximate probabilities to the famous
Chevalier De Mere’s dice problems. 


# development version from GitHub:
#install.packages("devtools") 

# install "dieroll" (without vignettes)
devtools::install_github("gastonstat/dieroll")

# install "dieroll" (with vignettes)
devtools::install_github("gastonstat/dieroll", build_vignettes = TRUE)
## Usage
library(dieroll)

# default die
die <- die()
die

# 1 roll of die
roll(die)

# 1000 rolls of die1
r1000 <- roll(die1, times = 1000)
r1000

# summary
summary(r1000)
