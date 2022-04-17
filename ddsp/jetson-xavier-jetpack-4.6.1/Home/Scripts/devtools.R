#! /usr/bin/env Rscript

options(warn=2)
Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
install.packages(c(
  "data.table",
  "devtools",
  "IRkernel",
  "knitr",
  "renv",
  "reticulate",
  "rmarkdown",
  "tinytex"
), repos = "https://cloud.r-project.org/")
warnings()

tinytex::install_tinytex
