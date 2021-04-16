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
rm -f $LOGS/csound.log
cd $SOURCE_DIR

echo "Installing dependencies"
apt-get install -y --no-install-recommends \
  fluid \
  gettext \
  hdf5-tools \
  libcurl4-openssl-dev \
  libeigen3-dev \
  libfltk1.3-dev \
  libgettextpo-dev \
  libgmm++-dev \
  libhdf5-dev \
  libhdf5-serial-dev \
  liblo-dev \
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
apt-get clean

echo "Downloading csound source"
rm -fr csound*
curl -Ls \
  https://github.com/csound/csound/archive/refs/tags/$CSOUND_VERSION.tar.gz \
  | tar --extract --gunzip --file=-

echo "Configuring CSound"
rm -fr cs6make
mkdir cs6make
pushd cs6make

  export CPATH=/usr/include/lame:/usr/include/pulse:$CPATH
  cmake \
    -Wno-dev \
    -DBUILD_CUDA_OPCODES=ON \
    -DBUILD_STATIC_LIBRARY=ON \
    -DLAME_HEADER="/usr/include/lame/lame.h" \
    -DPULSEAUDIO_HEADER="/usr/include/pulse/simple.h" \
    -DLUA_H_PATH="/usr/include/lua5.2/" \
    -DLUA_LIBRARY="/usr/lib/aarch64-linux-gnu/liblua5.2.so" \
    -DBUILD_JAVA_INTERFACE=OFF \
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
  make install \
    >> $LOGS/csound.log 2>&1
  ldconfig

  echo "Relocating samples to '/usr/local/share/csound/samples'"
  rm -fr /usr/local/share/csound
  mkdir --parents /usr/local/share/csound
  mv /usr/local/share/samples /usr/local/share/csound/samples
  popd

# http://floss.booktype.pro/csound/a-csound-in-pd/
echo "Cloning the 'CSound in PD' repo"
git clone https://github.com/csound/csound_pd.git
pushd csound_pd

  echo "Configuring csound_pd"
  rm -fr build; mkdir --parents build; cd build
  cmake .. \
    >> $LOGS/csound.log 2>&1

  echo "Compiling csound_pd"
  make \
    >> $LOGS/csound.log 2>&1

  echo "Installing csound_pd"
  cp csound6~.pd_linux /usr/local/lib/pd/extra/
  cp ../examples/csound6~-help.pd /usr/local/lib/pd/extra/
  cp -rp ../examples /usr/local/share/csound/samples/csound_pd_examples
  popd

echo "Cleanup"
rm -fr $SOURCE_DIR/cs6make $SOURCE_DIR/csound*
