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

# https://github.com/supercollider/supercollider/wiki/Installing-supercollider-from-source-on-Ubuntu

set -e
rm -f $LOGS/base.log
cd $SOURCE_DIR

echo "Updating and upgrading"
apt-get update \
  >> $LOGS/base.log 2>&1
apt-get upgrade -y \
  >> $LOGS/base.log 2>&1

echo "Installing dependencies"
apt-get install -qqy --no-install-recommends \
  alsa-tools \
  alsa-utils \
  apt-file \
  bison \
  build-essential \
  ca-certificates \
  curl \
  emacs-nox \
  file \
  flac \
  flex \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  freepats \
  gettext \
  git \
  gnupg \
  jack-tools \
  jacktrip \
  ladspa-sdk \
  libasound2-dev \
  libcurl4-openssl-dev \
  libdbus-1-dev \
  libfftw3-dev \
  libglib2.0-dev \
  libinstpatch-dev \
  libjack-jackd2-dev \
  liblash-compat-dev \
  liblo-dev \
  libmp3lame-dev \
  libncurses5-dev \
  libpng-dev \
  libportmidi-dev \
  libpulse-dev \
  libreadline-dev \
  libsamplerate0-dev \
  libsdl2-dev \
  libsdl-kitchensink-dev \
  libsndfile1-dev \
  libsox-dev \
  libsox-fmt-all \
  libstk0-dev \
  libsystemd-dev \
  lynx \
  mlocate \
  mp3splt \
  nano \
  pkg-config \
  portaudio19-dev \
  python3-dev \
  snd-nox \
  software-properties-common \
  sox \
  sudo \
  time \
  timidity \
  tree \
  vim-nox \
  wget \
  >> $LOGS/base.log 2>&1
apt-get clean
