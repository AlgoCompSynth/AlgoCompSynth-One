#! /usr/bin/env bash

set -e

echo "Installing RStudio Server and Quarto CLI"
/usr/bin/time yay --sync --refresh --needed --noconfirm \
  cmake \
  gcc-fortran \
  pandoc-cli \
  pandoc-crossref \
  rstudio-server-bin \
  quarto-cli-bin \
  > ../Logs/1_RStudioServer.log 2>&1

echo "Setting .Rprofile"
cp Rprofile $HOME/.Rprofile

echo "Finished"
