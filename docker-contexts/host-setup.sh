#! /bin/bash

set -e

sudo apt-get install -qqy --no-install-recommends \
  apt-file \
  file \
  mlocate \
  sysstat \
  time \
  tree \
  vim-nox
echo "Updating 'mlocate' database"
sudo updatedb
echo "Updating 'apt-file search' database"
sudo apt-file update
echo "Adding '${USER}' to the 'docker' group"
sudo usermod -aG docker ${USER}
