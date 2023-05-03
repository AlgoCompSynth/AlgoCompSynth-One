#! /bin/bash

set -e

echo "Upgrading"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get upgrade -qqy

echo "Installing command line utilities"
sudo apt-get install -qqy --no-install-recommends \
  apt-file \
  bash-completion \
  build-essential \
  ca-certificates \
  dirmngr \
  ffmpeg \
  git \
  gnupg2 \
  gstreamer1.0-libav \
  gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-base \
  gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-ugly \
  gstreamer1.0-tools gstreamer1.0-alsa \
  less \
  libffmpeg-nvenc-dev \
  libjpeg-dev \
  libomp-dev \
  libopenblas-dev \
  libopenmpi-dev \
  libpng-dev \
  mlocate \
  openssh-client \
  software-properties-common \
  time \
  tree \
  unzip \
  vim-nox \
  wget \
  zip
