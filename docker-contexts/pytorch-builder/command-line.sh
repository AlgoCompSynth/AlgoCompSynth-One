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
  python-dev \
  python3-dev \
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

#https://tecadmin.net/how-to-install-python-3-9-on-ubuntu-18-04/
echo "Installing 'deadsnakes' Python 3.9, 3.8 and 3.7"
add-apt-repository ppa:deadsnakes/ppa -y \
  >> $LOGS/command-line.log 2>&1
apt-get install -qqy --no-install-recommends \
  python3.9 \
  python3.9-dev \
  python3.9-distutils \
  python3.8 \
  python3.8-dev \
  python3.8-distutils \
  python3.7 \
  python3.7-dev \
  python3.7-distutils \
  >> $LOGS/command-line.log 2>&1
apt-get clean
