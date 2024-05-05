#! /usr/bin/env bash

set -e
yay --sync --refresh --needed \
  rstudio-server-bin

echo "Starting RStudio Server"
sleep 5
sudo systemctl enable --now rstudio-server

echo "Setting $USER password"
sudo passwd $USER

echo "Finished"
