#! /bin/bash

set -e

echo "Upgrading"
sudo apt-get update
sudo apt-get upgrade -qqy

echo "Installing command line conveniences and Linux dependencies"
sudo apt-get install -qqy --no-install-recommends \
  apt-file \
  bash-completion \
  build-essential \
  ca-certificates \
  dirmngr \
  ffmpeg \
  fftw-dev \
  flac \
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
  libfftw3-dev \
  libfftw3-mpi-dev \
  libflac-dev \
  libjpeg-dev \
  libogg-dev \
  libomp-dev \
  libopenblas-dev \
  libopenmpi-dev \
  libpng-dev \
  libsox-dev \
  libsox-fmt-all \
  libsoxr-dev \
  mlocate \
  mp3splt \
  musescore3 \
  openssh-client \
  software-properties-common \
  sox \
  time \
  tree \
  unzip \
  vim-nox \
  wget \
  zip
