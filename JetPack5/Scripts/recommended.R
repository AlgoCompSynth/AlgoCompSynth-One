#! /usr/bin/env Rscript

# detonate on first uninstallable
options(warn=2)
install.packages(c(
  "boot",
  "class",
  "cluster",
  "codetools",
  "foreign",
  "KernSmooth",
  "lattice",
  "MASS",
  "Matrix",
  "mgcv",
  "nlme",
  "nnet",
  "rpart",
  "spatial",
  "survival"
), quiet = TRUE, repos = "https://cloud.r-project.org/")
warnings()
print(rownames(installed.packages()))
