#! /usr/bin/env bash

set -e

echo "Starting RStudio Server"
sleep 5
sudo systemctl enable --now rstudio-server

echo "Setting $USER password"
sudo passwd $USER

echo "Browse to 'localhost:8787' to use RStudio Server"
echo "Finished"
