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
export LOGS=$SYNTH_HOME/Logfiles
export SOURCE_DIR=$SYNTH_HOME/Projects
rm -f $LOGS/pure-data.log
cd $SOURCE_DIR

echo "Installing Linux dependencies"
sudo apt-get update \
  >> $LOGS/pure-data.log 2>&1
sudo apt-get install -qqy --no-install-recommends \
  autoconf \
  automake \
  libtool-bin \
  >> $LOGS/pure-data.log 2>&1
sudo apt-get clean \
  >> $LOGS/pure-data.log 2>&1

echo "Downloading pure-data source"
rm -fr pure-data*
export PURE_DATA_REPO="https://github.com/pure-data/pure-data/archive/refs/tags"
export PURE_DATA_FILE="$PURE_DATA_VERSION.tar.gz"
curl -Ls $PURE_DATA_REPO/$PURE_DATA_FILE \
  | tar --extract --gunzip --file=-
cd pure-data-$PURE_DATA_VERSION

echo "Configuring Pure Data"
./autogen.sh \
  >> $LOGS/pure-data.log 2>&1
./configure \
  --enable-alsa \
  --enable-fftw \
  --enable-jack \
  --disable-oss \
  --enable-portaudio \
  --enable-portmidi \
  --without-local-portaudio \
  --without-local-portmidi \
  >> $LOGS/pure-data.log 2>&1
echo "Compiling Pure Data"
/usr/bin/time make --jobs=`nproc` \
  >> $LOGS/pure-data.log 2>&1
echo "Installing Pure Data"
sudo make install \
  >> $LOGS/pure-data.log 2>&1
sudo ldconfig \
  >> $LOGS/pure-data.log 2>&1