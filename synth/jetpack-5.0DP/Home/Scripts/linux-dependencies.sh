#! /bin/bash

set -e

echo "Installing Linux dependencies"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -qqy --no-install-recommends \
  bash-completion \
  firefox \
  ffmpeg \
  flac \
  gfortran \
  hdf5-tools \
  less \
  libblas-dev \
  libhdf5-dev \
  libhdf5-serial-dev \
  libjpeg8-dev \
  liblapack-dev \
  libopenblas-base \
  libopenmpi-dev \
  libomp-dev \
  libsox-dev \
  libsoxr-dev \
  libsox-fmt-all \
  mp3splt \
  openssh-client \
  sox \
  zip \
  zlib1g-dev
sudo apt-get clean

echo "Finished"
