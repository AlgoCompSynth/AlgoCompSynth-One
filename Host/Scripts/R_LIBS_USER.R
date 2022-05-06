#! /usr/bin/env Rscript

if (!dir.exists(Sys.getenv('R_LIBS_USER'))) {
  cat("\nCreating", Sys.getenv('R_LIBS_USER'), "\n")
  dir.create(Sys.getenv('R_LIBS_USER'), recursive = TRUE, mode = '0755')
}
