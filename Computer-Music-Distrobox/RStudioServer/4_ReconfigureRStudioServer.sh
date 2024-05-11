#! /usr/bin/env bash

set -e

echo "When the RStudio Server package was installed,"
echo "the installer enabled and started the service."
echo "So we need to stop it before modifying the"
echo "configuration and then restart it."
echo ""
echo "You can ignore error messages"
sudo systemctl stop rstudio-server.service || true
sleep 10

echo "Installing configuration file 'rserver.conf':"
echo ""
echo ""
cat rserver.conf
echo ""
echo ""
sudo mkdir --parents /etc/rstudio
sudo cp rserver.conf /etc/rstudio/

echo "Enabling / starting RStudio Server"
sudo systemctl enable --now rstudio-server.service 

echo "Finished!"
