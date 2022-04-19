#! /bin/bash

set -e

echo "Installing Linux dependencies"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -qqy --no-install-recommends \
  ffmpeg \
  flac \
  libsox-dev \
  libsoxr-dev \
  libsox-fmt-all \
  mp3splt \
  openssh-client \
  sox
sudo apt-get clean

echo "Finished"
