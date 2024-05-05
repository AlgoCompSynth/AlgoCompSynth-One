#! /usr/bin/env bash

set -e

/usr/bin/time yay --sync --refresh --needed --noconfirm \
  rstudio-server-bin \
  > rstudio-server.log 2>&1

echo "Starting RStudio Server"
sleep 5
sudo systemctl enable --now rstudio-server

echo "Setting $USER password"
sudo passwd $USER

echo "Finished"
