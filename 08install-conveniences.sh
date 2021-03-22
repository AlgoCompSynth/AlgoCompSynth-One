#! /bin/bash

set -e

echo "Installing command line conveniences"
sudo apt-get install -y --no-install-recommends \
  apt-file \
  file \
  lynx \
  mlocate \
  time \
  tree \
  vim-nox
echo "Updating 'apt-file' database"
sudo apt-file update
echo "Updating 'locate' database"
sudo updatedb
