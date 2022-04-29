#! /bin/bash

set -e

echo "Upgrading"
apt-get update
apt-get upgrade -y

echo "Installing gnupg2 if needed"
apt-get install -qqy --no-install-recommends gnupg2

echo "Updating NVIDIA keys"
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub

echo "Installing command line utilities"
apt-get install -qqy --no-install-recommends \
  apt-file \
  bash-completion \
  build-essential \
  ca-certificates \
  ffmpeg \
  git \
  gstreamer1.0-libav \
  gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-base \
  gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-ugly \
  gstreamer1.0-tools gstreamer1.0-alsa \
  less \
  lynx \
  mlocate \
  openssh-client \
  software-properties-common \
  sudo \
  time \
  tree \
  unzip \
  vim-nox \
  wget \
  zip

echo "Installing PyTorch Linux dependencies"
apt-get install -qqy --no-install-recommends \
  libopenblas-base \
  libopenmpi-dev \
  libomp-dev

if [ ! -x /usr/local/cuda/bin/nvcc ]
then
  echo "CUDA toolkit missing - installing!"
  apt-get install -qqy --no-install-recommends \
    cuda-toolkit-11-4 \
    libcudnn8-dev
fi

apt-get clean

echo "Creating 'synth' user"
useradd \
  --shell /bin/bash \
  --user-group \
  --groups adm,audio,cdrom,dip,plugdev,sudo,video \
  --create-home \
  --uid 1000 synth \
  && echo "synth:synth" | chpasswd
