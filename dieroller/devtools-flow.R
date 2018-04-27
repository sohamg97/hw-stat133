# =====================================================
# Devtools workflow
#library(devtools)
# Title: devtools-flow.R
# Description: Install dev tools
# Input(s): code
# Output(s): dev tools properly run
# Author(s): Soham Ghosh
# Date: 04-27-2018
# =====================================================

devtools::document()          # generate documentation
devtools::check_man()         # check documentation
devtools::test()              # run tests
devtools::build_vignettes()   # build vignettes
devtools::build()             # build bundle
devtools::install()           # install package

