library(devtools)
library(usethis)


usethis::use_description()
use_mit_license("Kaiping Yang")

usethis::use_package("shiny")
usethis::use_package("htmlwidgets")

document()
check()
devtools::install()
