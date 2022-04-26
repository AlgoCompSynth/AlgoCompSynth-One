#! /bin/bash

set -e

echo "Installing command line utilities"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  bash-completion \
  build-essential \
  ca-certificates \
  curl \
  git \
  less \
  lynx \
  mlocate \
  pkg-config \
  python3-dev \
  python3-venv \
  software-properties-common \
  sudo \
  time \
  tree \
  unzip \
  vim-nox \
  wget \
  zip
apt-get clean

echo "Creating 'synth' user"
useradd \
  --shell /bin/bash \
  --user-group \
  --groups adm,audio,cdrom,dip,plugdev,sudo,video \
  --create-home \
  --uid 1000 synth \
  && echo "synth:synth" | chpasswd
