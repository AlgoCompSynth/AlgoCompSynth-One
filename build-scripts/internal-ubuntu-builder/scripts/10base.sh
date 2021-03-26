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

echo "Update and upgrade"
apt-get update \
  >> $LOGS/base.log 2>&1
apt-get upgrade -y \
  >> $LOGS/base.log 2>&1

echo "Installing Ubuntu packages"
apt-get install -qqy --no-install-recommends \
  apt-file \
  autoconf \
  automake \
  bison \
  build-essential \
  cabal-install \
  ca-certificates \
  curl \
  cython3 \
  emacs-nox \
  flex \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  freepats \
  gettext \
  git \
  gnupg \
  libasound2-dev \
  libavahi-client-dev \
  libcurl4-openssl-dev \
  libfftw3-dev \
  libglib2.0-dev \
  libgtk-3-dev \
  libjack-jackd2-dev \
  libpython3-dev \
  libqt5opengl5-dev \
  libqt5svg5-dev \
  libqt5websockets5-dev \
  librtmidi-dev \
  libsndfile1-dev \
  libtool \
  libudev-dev \
  libvpx-dev \
  libx11-dev \
  libx264-dev \
  libxcomposite-dev \
  libxfixes-dev \
  libxkbfile-dev \
  libxrandr-dev \
  libxt-dev \
  libxtst-dev \
  llvm-3.7-dev \
  lynx \
  mlocate \
  nano \
  python3-cairo-dev \
  python-gi-dev \
  qt5-default \
  qtbase5-dev \
  qtdeclarative5-dev \
  qttools5-dev \
  qtwebengine5-dev \
  software-properties-common \
  time \
  timidity \
  tk \
  tree \
  vim-nox \
  wget \
  >> $LOGS/base.log 2>&1

echo "Installing latest Erlang OTP"
wget --quiet \
  https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb
dpkg -i erlang-solutions_2.0_all.deb \
  >> $LOGS/base.log 2>&1
apt-get update \
  >> $LOGS/base.log 2>&1
apt-get install -qqy --no-install-recommends \
  erlang-dev \
  >> $LOGS/base.log 2>&1

echo "Updating apt-file database"
apt-file update \
  >> $LOGS/base.log 2>&1

echo "Installing latest 'cmake'"
wget --quiet https://github.com/Kitware/CMake/releases/download/v3.20.0/cmake-3.20.0-linux-aarch64.sh
chmod +x cmake-3.20.0-linux-aarch64.sh 
./cmake-3.20.0-linux-aarch64.sh --skip-license --prefix=/usr/local
which cmake
cmake --version

echo "Installing latest pandoc"
curl -Ls https://github.com/jgm/pandoc/releases/download/2.13/pandoc-2.13-linux-arm64.tar.gz \
  | tar --extract --gunzip --strip-components=1 --directory=/usr/local --file=-

echo "Updating 'locate' database"
updatedb \
  >> $LOGS/base.log 2>&1
