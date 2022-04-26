#! /bin/bash

set -e

echo "Installing Linux dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  ca-certificates \
  curl \
  git \
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
  wget

if [ $BASE_IMAGE -eq "nvcr.io/nvidia/l4t-pytorch:r32.7.1-pth1.10-py3" ]
then
  echo "JetPack 5 - installing CUDA and CUDNN"
  apt-get install -qqy --no-install-recommends \
    cuda-toolkit-11-4 \
    libcudnn8-dev
fi

echo "Creating 'synth' user"
useradd \
  --shell /bin/bash \
  --user-group \
  --groups adm,audio,cdrom,dip,plugdev,sudo,video \
  --create-home \
  --uid 1000 synth \
  && echo "synth:synth" | chpasswd
