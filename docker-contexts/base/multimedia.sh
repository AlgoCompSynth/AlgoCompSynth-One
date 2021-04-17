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
rm -f $LOGS/multimedia.log

echo "Installing multimedia tools"
apt-get update \
  >> $LOGS/multimedia.log 2>&1
apt-get install -y --no-install-recommends \
  alsa-tools \
  alsa-utils \
  ffmpeg \
  flac \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  gedit \
  gstreamer1.0-alsa \
  gstreamer1.0-libav \
  gstreamer1.0-tools \
  gstreamer1.0-plugins-base \
  gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-ugly \
  jacktrip \
  ladspa-sdk \
  libasound2-dev \
  libavahi-client-dev \
  libdbus-1-dev \
  libfftw3-dev \
  libfftw3-mpi-dev \
  libglib2.0-dev \
  libgstreamer1.0-dev \
  libgstreamer-plugins-base1.0-dev \
  libgstreamer-plugins-good1.0-dev \
  libgstreamer-plugins-bad1.0-dev \
  libinstpatch-dev \
  libjack-jackd2-dev \
  liblash-compat-dev \
  libmicrohttpd-dev \
  libncurses5-dev \
  libsox-dev \
  libsox-fmt-all \
  libpulse-dev \
  libqt5opengl5-dev \
  libqt5svg5-dev \
  libqt5websockets5-dev \
  libreadline-dev \
  libsdl2-dev \
  libsndfile1-dev \
  libssl-dev \
  libsystemd-dev \
  libtinfo-dev \
  libxcb-icccm4-dev \
  libxcb-util-dev \
  mp3splt \
  portaudio19-dev \
  qjackctl \
  qtbase5-dev \
  qtdeclarative5-dev \
  qttools5-dev \
  qtwebengine5-dev \
  sox \
  timidity \
  >> $LOGS/multimedia.log 2>&1
