#! /bin/bash

set -e

echo "Installing Linux dependencies"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -qqy --no-install-recommends \
  ffmpeg \
  flac \
  libopenblas-base \
  libopenmpi-dev \
  libomp-dev \
  libsox-dev \
  libsoxr-dev \
  libsox-fmt-all \
  mp3splt \
  sox \
  time

echo "Finished"
