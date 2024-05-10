#! /usr/bin/env bash

set -e

echo "Stopping RStudio Server"
echo "You can ignore error messages"
sudo systemctl stop rstudio-server.service || true

echo "Installing configuration file rserver.conf:"
echo ""
echo ""
cat rserver.conf
echo ""
echo ""
sudo mkdir --parents /etc/rstudio
sudo cp rserver.conf /etc/rstudio/

echo "Enabling / starting RStudio Server"
sudo systemctl enable --now rstudio-server.service 

echo "Setting password for $USER - RStudio Server needs it"
sudo passwd $USER

echo "Finished!"
