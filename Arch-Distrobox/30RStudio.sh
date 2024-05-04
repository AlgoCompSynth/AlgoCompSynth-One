#! /usr/bin/env bash

echo "Installing RStudio"
sudo pacman --sync --refresh --needed --noconfirm \
  gcc-fortran \
  imagemagick \
  openssl-1.1 \
  r
yay --sync --refresh --needed \
  rstudio-server-bin

echo "Starting RStudio Server"
sleep 5
sudo systemctl enable --now rstudio-server

echo "Setting $HOME/.Rprofile"
cp Rprofile $HOME/.Rprofile

echo "Setting $USER password"
sudo passwd $USER

echo "Finished"
