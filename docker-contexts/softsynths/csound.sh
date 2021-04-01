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
rm -f $LOGS/csound.log
cd $SOURCE_DIR

echo "Installing dependencies"
sudo apt-get update \
  >> $LOGS/csound.log 2>&1
sudo apt-get install -y --no-install-recommends \
  default-jdk \
  libfltk1.3-dev \
  fluid \
  gettext \
  hdf5-tools \
  libeigen3-dev \
  libgettextpo-dev \
  libgmm++-dev \
  libhdf5-dev \
  libhdf5-serial-dev \
  liblua5.2-dev \
  libmp3lame-dev \
  libncurses5-dev \
  libpng-dev\
  libsamplerate0-dev \
  libstk0-dev \
  libwebsockets-dev \
  python-dev \
  python3-dev \
  swig3.0 \
  >> $LOGS/csound.log 2>&1
sudo apt-get clean \
  >> $LOGS/csound.log 2>&1

echo "Downloading csound source"
rm -fr csound*
curl -Ls \
  https://github.com/csound/csound/archive/refs/tags/$CSOUND_VERSION.tar.gz \
  | tar --extract --gunzip --file=-

echo "Configuring CSound"
rm -fr cs6make
mkdir cs6make
cd cs6make
export CPATH=/usr/include/lame:/usr/include/pulse:$CPATH
cmake \
  -Wno-dev \
  -DBUILD_CUDA_OPCODES=OFF \
  -DBUILD_STATIC_LIBRARY=ON \
  -DLAME_HEADER="/usr/include/lame/lame.h" \
  -DPULSEAUDIO_HEADER="/usr/include/pulse/simple.h" \
  -DLUA_H_PATH="/usr/include/lua5.2/" \
  -DLUA_LIBRARY="/usr/lib/aarch64-linux-gnu/liblua5.2.so" \
  -DBUILD_JAVA_INTERFACE=ON \
  -DBUILD_P5GLOVE_OPCODES=OFF \
  -DBUILD_VIRTUAL_KEYBOARD=OFF \
  -DBUILD_WIIMOTE_OPCODES=OFF \
  -DUSE_FLTK=ON \
  ../csound-$CSOUND_VERSION \
  >> $LOGS/csound.log 2>&1
echo "Compiling CSound"
make --jobs=`nproc` \
  >> $LOGS/csound.log 2>&1
echo "Installing CSound"
sudo make install \
  >> $LOGS/csound.log 2>&1
sudo ldconfig -v \
  >> $LOGS/csound.log 2>&1

echo "Relocating samples to '/usr/local/share/csound/samples'"
sudo rm -fr /usr/local/share/csound
sudo mkdir --parents /usr/local/share/csound
sudo mv /usr/local/share/samples /usr/local/share/csound/samples

echo "Cleanup"
rm -fr $SOURCE_DIR/cs6make $SOURCE_DIR/csound*
