#! /bin/bash

set -e

echo "Installing Linux dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  ca-certificates \
  cuda-toolkit-11-4 \
  curl \
  git \
  libcudnn8-dev \
  mlocate \
  python3-dev \
  python3-venv \
  software-properties-common \
  sudo \
  time \
  tree \
  vim-nox \
  wget

echo "Creating 'synth' user"
useradd \
  --shell /bin/bash \
  --user-group \
  --groups adm,audio,cdrom,dip,plugdev,sudo,video \
  --create-home \
  --uid 1000 synth \
  && echo "synth:synth" | chpasswd
