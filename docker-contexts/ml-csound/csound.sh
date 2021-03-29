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
rm -f $HOME/Logfiles/csound.log
cd $HOME/Projects

echo "Installing dependencies"
sudo apt-get install -qqy --no-install-recommends \
  hdf5-tools \
  libeigen3-dev \
  libgmm++-dev \
  libhdf5-dev \
  libhdf5-serial-dev \
  liblua5.2-dev \
  swig3.0 \
  >> $HOME/Logfiles/csound.log 2>&1
sudo apt-get clean

echo "Downloading csound source"
rm -fr csound*
curl -Ls \
  https://github.com/csound/csound/archive/refs/tags/$CSOUND_VERSION.tar.gz \
  | tar --extract --gunzip --file=-

if [ ! -x "/usr/local/cuda/bin/nvcc" ]
then
  echo "CUDA absent"
  export CUDA_PRESENT=OFF
else
  echo "CUDA present!"
  export CUDA_PRESENT=ON
fi

echo "Configuring CSound"
rm -fr cs6make
mkdir cs6make
cd cs6make
export CPATH=/usr/include/lame:/usr/include/pulse:$CPATH
cmake \
  -Wno-dev \
  -DBUILD_CUDA_OPCODES=$CUDA_PRESENT \
  -DBUILD_STATIC_LIBRARY=ON \
  -DLAME_HEADER="/usr/include/lame/lame.h" \
  -DPULSEAUDIO_HEADER="/usr/include/pulse/simple.h" \
  -DLUA_H_PATH="/usr/include/lua5.2/" \
  -DLUA_LIBRARY="/usr/lib/aarch64-linux-gnu/liblua5.2.so" \
  -DBUILD_JAVA_INTERFACE=OFF \
  -DBUILD_P5GLOVE_OPCODES=OFF \
  -DBUILD_VIRTUAL_KEYBOARD=OFF \
  -DBUILD_WIIMOTE_OPCODES=OFF \
  -DUSE_FLTK=OFF \
  ../csound-$CSOUND_VERSION \
  >> $HOME/Logfiles/csound.log 2>&1
echo "Compiling CSound"
/usr/bin/time make --jobs=`nproc` \
  >> $HOME/Logfiles/csound.log 2>&1
echo "Installing CSound"
sudo make install \
  >> $HOME/Logfiles/csound.log 2>&1
sudo ldconfig -v \
  >> $HOME/Logfiles/csound.log 2>&1

echo "Relocating samples to '/usr/local/share/csound/samples'"
sudo rm -fr /usr/local/share/csound
sudo mkdir --parents /usr/local/share/csound
sudo mv /usr/local/share/samples /usr/local/share/csound/samples
