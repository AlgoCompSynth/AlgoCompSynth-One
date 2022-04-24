#! /bin/bash

set -e

echo "Installing Linux dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  ca-certificates \
  git \
  mlocate \
  software-properties-common \
  sudo \
  time \
  tree \
  vim-nox \
  wget
apt-get clean

echo "Creating 'synth' user"
useradd \
  --shell /bin/bash \
  --user-group \
  --groups adm,audio,cdrom,dip,plugdev,sudo,video \
  --create-home \
  --uid 1000 synth \
  && echo "synth:synth" | chpasswd
