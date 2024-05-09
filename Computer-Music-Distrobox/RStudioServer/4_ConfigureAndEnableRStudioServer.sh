#! /usr/bin/env bash

set -e

echo "Setting $HOME/.Rprofile"
cp Rprofile $HOME/.Rprofile

echo "Stopping RStudio Server"
echo "You can ignore error messages"
sudo systemctl stop rstudio-server.service || true

echo "Installing configuration file rserver.conf:"
cat rserver.conf
sudo mkdir --parents /etc/rstudio
sudo cp rserver.conf /etc/rstudio/

echo "Enabling / starting RStudio Server"
sudo systemctl enable --now rstudio-server.service 

echo "Setting password for $USER - RStudio Server needs it"
sudo passwd $USER

echo "Finished!"
