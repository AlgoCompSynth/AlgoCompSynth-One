#! /bin/bash

set -e

echo "Installing Linux dependencies"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -qqy --no-install-recommends \
  libopenblas-base \
  libopenmpi-dev \
  libomp-dev
sudo apt-get clean

echo "Finished"
