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
apt-get clean

echo "Creating 'synth' user"
useradd \
  --shell /bin/bash \
  --user-group \
  --groups adm,audio,cdrom,dip,plugdev,sudo,video \
  --create-home \
  --uid 1000 synth \
  && echo "synth:synth" | chpasswd
