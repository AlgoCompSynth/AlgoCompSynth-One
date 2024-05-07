#! /usr/bin/env bash

set -e

echo "Installing RStudio Server and Quarto CLI"
/usr/bin/time yay --sync --refresh --needed --noconfirm \
  pandoc-cli \
  pandoc-crossref \
  rstudio-server-bin \
  quarto-cli-bin \
  > Logs/30RStudio.log 2>&1

echo "Starting RStudio Server"
sleep 5
sudo systemctl enable --now rstudio-server

echo "Setting $USER password"
sudo passwd $USER

echo "Finished"
