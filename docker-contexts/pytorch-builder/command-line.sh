#! /bin/bash

set -e
rm -f $LOGS/command-line.log

echo "Installing command line base"
apt-get update \
  >> $LOGS/command-line.log 2>&1
apt-get upgrade -y \
  >> $LOGS/command-line.log 2>&1
apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  ca-certificates \
  cmake \
  curl \
  file \
  git \
  gnupg \
  libopenblas-dev \
  libopenmpi-dev \
  lynx \
  mlocate \
  openmpi-bin \
  patch \
  pkg-config \
  python3-dev \
  python3-distlib \
  python3-distutils-extra \
  python3-pip \
  python3-setuptools \
  python3-venv \
  software-properties-common \
  ssh \
  sudo \
  time \
  tree \
  unzip \
  vim-nox \
  virtualenvwrapper \
  wget \
  >> $LOGS/command-line.log 2>&1
apt-get clean
