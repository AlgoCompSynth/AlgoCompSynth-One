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
rm -f $LOGS/install-libraries.log

echo "Installing PGDG Linux repository"
# https://wiki.postgresql.org/wiki/Apt
curl -Ls https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo cp $SCRIPTS/pgdg.list /etc/apt/sources.list.d/pgdg.list
apt-get update \
  >> $LOGS/install-libraries.log 2>&1

echo "Installing install-libraries tools"
apt-get install -y --no-install-recommends \
  alsa-tools \
  alsa-utils \
  bison \
  cmake \
  default-jdk-headless \
  flac \
  flex \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  gfortran \
  ladspa-sdk \
  libasound2-dev \
  libbz2-dev \
  libcairo2-dev \
  libdbus-1-dev \
  libfftw3-dev \
  libfftw3-mpi-dev \
  libgdal-dev \
  libgit2-dev \
  libglib2.0-dev \
  libicu-dev \
  libjack-jackd2-dev \
  libjpeg8-dev \
  libjpeg-turbo8-dev \
  liblash-compat-dev \
  liblzma-dev \
  libmicrohttpd-dev \
  libncurses-dev \
  libpango1.0-dev \
  libpcre2-dev \
  libpulse-dev \
  libreadline-dev \
  libsdl2-dev \
  libsndfile1-dev \
  libsox-dev \
  libsox-fmt-all \
  libssl-dev \
  libsystemd-dev \
  libtiff5-dev \
  libtinfo-dev \
  libudunits2-dev \
  mp3splt \
  portaudio19-dev \
  sox \
  texinfo \
  timidity \
  tk-dev \
  zlib1g-dev \
  >> $LOGS/install-libraries.log 2>&1
apt-get clean
