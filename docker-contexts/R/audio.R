Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
install.packages(c(
  "audio",
  "data.table",
  "knitr",
  "monitoR",
  "NatureSounds",
  "phonTools",
  "remotes",
  "renv",
  "rmarkdown",
  "seewave",
  "signal",
  "shiny",
  "soundecology",
  "soundgen",
  "tinytex",
  "tuneR",
  "warbler"
), quiet = TRUE)
warnings()
