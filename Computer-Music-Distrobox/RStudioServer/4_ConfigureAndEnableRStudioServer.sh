#! /usr/bin/env bash

set -e

echo "When the RStudio Server package was installed,"
echo "the system enableds and started the service."
echo "So we need to stop it to modify the configuration"
echo "and then restart it."
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

echo "Setting password for $USER - RStudio Server needs it"
sudo passwd $USER

echo "Finished!"
