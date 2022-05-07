#! /usr/bin/env Rscript

# detonate on first uninstallable
options(warn=2)
install.packages(c(
  "caracas",
  "data.table",
  "devtools",
  "IRkernel",
  "knitr",
  "renv",
  "reticulate",
  "rmarkdown"
), quiet = TRUE, repos = "https://cloud.r-project.org/")
warnings()
print(rownames(installed.packages()))
