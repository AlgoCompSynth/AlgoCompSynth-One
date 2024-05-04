#! /usr/bin/env bash

echo "Installing RStudio"
yay --sync --refresh --needed --noconfirm \
  gcc-fortran \
  rstudio-server-bin

echo "Starting RStudio Server"
sleep 5
sudo systemctl enable --now rstudio-server

echo "Setting $HOME/.Rprofile"
cp Rprofile $HOME/.Rprofile

echo "Finished"
