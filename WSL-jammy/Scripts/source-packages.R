#! /usr/bin/env Rscript

# reference 
#@book{sueur2018sound,
#  title={Sound analysis and synthesis with R},
#  author={Sueur, J{\'e}r{\^o}me and others},
#  year={2018},
#  publisher={Springer}
#}

# detonate on first uninstallable
options(warn=2)
install.packages(c(
  "audio",
  "caracas",
  "fractional",
  "gm",
  "monitoR",
  "music",
  "NatureSounds",
  "phonTools",
  "rTorch",
  "seewave",
  "signal",
  "soundecology",
  "soundgen",
  "tabr",
  "tuneR",
  "warbleR"
), quiet = TRUE, repos = "https://cloud.r-project.org/")
warnings()
