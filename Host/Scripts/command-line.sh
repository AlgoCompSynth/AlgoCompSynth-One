#! /bin/bash

set -e

echo "Upgrading"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get upgrade -qqy

echo "Installing gnupg2 if needed"
sudo apt-get install -qqy --no-install-recommends gnupg2

echo "Updating NVIDIA keys"
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub

echo "Installing command line utilities"
sudo apt-get install -qqy --no-install-recommends \
  apt-file \
  bash-completion \
  build-essential \
  ca-certificates \
  dirmngr \
  ffmpeg \
  git \
  gstreamer1.0-libav \
  gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-base \
  gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-ugly \
  gstreamer1.0-tools gstreamer1.0-alsa \
  less \
  mlocate \
  openssh-client \
  software-properties-common \
  time \
  tree \
  unzip \
  vim-nox \
  wget \
  zip

echo "Installing PyTorch Linux dependencies"
sudo apt-get install -qqy --no-install-recommends \
  libopenblas-base \
  libopenmpi-dev \
  libomp-dev
