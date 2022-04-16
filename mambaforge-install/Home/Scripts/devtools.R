#! /usr/bin/env Rscript

options(warn=2)
Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
install.packages(c(
  "data.table",
  "devtools",
  "IRkernel",
  "renv",
  "reticulate"
), repos = "https://cloud.r-project.org/")
warnings()

IRkernel::installspec()
