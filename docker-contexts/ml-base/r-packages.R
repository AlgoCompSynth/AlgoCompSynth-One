#! /usr/bin/env Rscript

source("~/.Rprofile")
Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
update.packages(ask = FALSE, instlib = Sys.getenv("R_LIBS_USER"), quiet = TRUE)
install.packages(c(
  "audio",
  "caracas",
  "data.table",
  "IRkernel",
  "keras",
  "knitr",
  "monitoR",
  "NatureSounds",
  "phonTools",
  "remotes",
  "renv",
  "rmarkdown",
  "rTorch",
  "seewave",
  "signal",
  "soundecology",
  "soundgen",
  "tinytex",
  "tuneR",
  "warbler"
), quiet = TRUE)
warnings()

# enable R kernel in Jupyter
IRkernel::installspec()

# install TinyTeX
tinytex::install_tinytex()
tinytex::tlmgr_conf()
