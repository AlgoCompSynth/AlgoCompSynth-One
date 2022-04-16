#! /usr/bin/env Rscript

# reference 
#@book{sueur2018sound,
#  title={Sound analysis and synthesis with R},
#  author={Sueur, J{\'e}r{\^o}me and others},
#  year={2018},
#  publisher={Springer}
#}

options(warn=2)
Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
install.packages(c(
  "audio",
  "monitoR",
  "music",
  "NatureSounds",
  "phonTools",
  "remotes",
  "reticulate",
  "Rraven",
  "seewave",
  "signal",
  "soundecology",
  "soundgen",
  "tabr",
  "tuneR",
  "warbleR"
), repos = "https://cloud.r-project.org/")
warnings()
