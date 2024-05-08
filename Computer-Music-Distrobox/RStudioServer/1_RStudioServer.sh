#! /usr/bin/env bash

set -e

echo "Installing RStudio Server and Quarto CLI"
/usr/bin/time yay --sync --refresh --needed --noconfirm \
  gcc-fortran \
  pandoc-cli \
  pandoc-crossref \
  rstudio-server-bin \
  quarto-cli-bin \
  > ../Logs/1_RStudioServer.log 2>&1

echo "Setting .Rprofile"
cp Rprofile $HOME/.Rprofile

echo "Starting RStudio Server"
sleep 5
sudo systemctl enable --now rstudio-server

echo "Setting $USER password"
sudo passwd $USER

echo "Browse to 'localhost:8787' to use RStudio Server"
echo "Finished"
