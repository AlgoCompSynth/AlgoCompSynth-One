#! /bin/bash

# Copyright (C) 2021 M. Edward (Ed) Borasky <mailto:znmeb@algocompsynth.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

set -e
mkdir --parents $HOME/Logfiles
rm -f $HOME/Logfiles/l4t-packages.log

echo "Enabling source packages"
diff host-scripts/sources.list /etc/apt/sources.list || true
sudo cp host-scripts/sources.list /etc/apt/sources.list

echo "Installing L4T packages"
sudo apt-get update \
  >> $HOME/Logfiles/l4t-packages.log
sudo apt-get upgrade -y \
  >> $HOME/Logfiles/l4t-packages.log
sudo apt-get install -qqy --no-install-recommends \
  alsa-base \
  alsa-tools \
  alsa-utils \
  apt-file \
  build-essential \
  ca-certificates \
  curl \
  emacs-nox \
  ffmpeg \
  file \
  flac \
  git \
  gnupg \
  gstreamer1.0-alsa \
  gstreamer1.0-libav \
  gstreamer1.0-plugins-base \
  gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-ugly \
  gstreamer1.0-tools \
  jack-tools \
  jackd2 \
  jacktrip \
  ladspa-sdk \
  libalsaplayer-dev \
  libao-dev \
  libasound2-dev \
  libavdevice-dev \
  libfftw3-dev \
  libfftw3-mpi-dev \
  libgstreamer1.0-dev \
  libgstreamermm-1.0-dev \
  libgstreamer-plugins-bad1.0-dev \
  libgstreamer-plugins-base1.0-dev \
  libgstreamer-plugins-good1.0-dev \
  libinstpatch-dev \
  libjack-jackd2-dev \
  liblash-compat-dev \
  libpulse-dev \
  librtaudio-dev \
  librtmidi-dev \
  libsdl2-dev \
  libsndfile1-dev \
  libsox-fmt-all \
  libsox-fmt-alsa \
  libsox3 \
  lynx \
  mlocate \
  mp3splt \
  nano \
  pkg-config \
  portaudio19-dev \
  qjackctl \
  software-properties-common \
  sox \
  sudo \
  time \
  tree \
  vim-nox \
  wget \
  >> $HOME/Logfiles/l4t-packages.log 2>&1

echo "Select 'yes' to enable realtime process priority"
sudo dpkg-reconfigure jackd2
echo "You will need to reboot"
