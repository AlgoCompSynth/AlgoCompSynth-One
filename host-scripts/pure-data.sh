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
rm -f $HOME/Logfiles/pure-data.log
cd $HOME/Downloads/Installers

echo "Installing Linux dependencies"
sudo apt-get install -qqy --no-install-recommends \
  autoconf \
  automake \
  libfftw3-dev \
  libfftw3-mpi-dev \
  libportmidi-dev \
  libtool-bin \
  tk-dev \
  >> $HOME/Logfiles/pure-data.log 2>&1

echo "Downloading pure-data source"
rm -fr pure-data*
export PURE_DATA_REPO="https://github.com/pure-data/pure-data/archive/refs/tags"
export PURE_DATA_FILE="$PURE_DATA_VERSION.tar.gz"
curl -Ls $PURE_DATA_REPO/$PURE_DATA_FILE \
  | tar --extract --gunzip --file=-
pushd pure-data-$PURE_DATA_VERSION

  echo "Configuring Pure Data"
  ./autogen.sh \
    >> $HOME/Logfiles/pure-data.log 2>&1
  ./configure --help \
    >> $HOME/Logfiles/pure-data.log 2>&1
  ./configure \
    --enable-alsa \
    --enable-fftw \
    --enable-jack \
    --disable-oss \
    --enable-portaudio \
    --enable-portmidi \
    --without-local-portaudio \
    --without-local-portmidi \
    >> $HOME/Logfiles/pure-data.log 2>&1

  echo "Compiling Pure Data"
  /usr/bin/time make --jobs=`nproc` \
    >> $HOME/Logfiles/pure-data.log 2>&1

  echo "Installing Pure Data"
  sudo make install \
    >> $HOME/Logfiles/pure-data.log 2>&1
  sudo ldconfig
  popd
