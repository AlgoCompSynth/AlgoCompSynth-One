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
apt-get install -qqy --no-install-recommends \
  bison \
  dssi-dev \
  flex \
  gettext \
  hdf5-tools \
  ladspa-sdk \
  libasound2-dev \
  libcurl4-openssl-dev \
  libeigen3-dev \
  libfftw3-dev \
  libgmm++-dev \
  libhdf5-dev \
  libhdf5-serial-dev \
  libjack-jackd2-dev \
  liblash-compat-dev \
  liblo-dev \
  liblua5.2-dev \
  libmp3lame-dev \
  libncurses5-dev \
  libpng-dev \
  libportmidi-dev \
  libpulse-dev \
  libpython3-dev \
  libsamplerate0-dev \
  libsndfile1-dev \
  libstk0-dev \
  libwebsockets-dev \
  portaudio19-dev \
  swig3.0 \
  >> $LOGS/csound.log 2>&1
apt-get clean

echo "Cloning CSound"
rm -fr csound
git clone https://github.com/csound/csound.git csound \
  >> $LOGS/csound.log 2>&1
cd csound
git checkout $CSOUND_VERSION \
  >> $LOGS/csound.log 2>&1
cd ..

rm -fr cs6make
mkdir cs6make
cd cs6make
export CPATH=/usr/include/lame:/usr/include/pulse:$CPATH

if [ ! -x "/usr/local/cuda/bin/nvcc" ]
then
  echo "CUDA absent"
  export CUDA_PRESENT=OFF
else
  echo "CUDA present!"
  export CUDA_PRESENT=ON
fi

echo "Configuring CSound"
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
  -DCUDA_cufft_LIBRARY="/usr/local/cuda-10.2/targets/aarch64-linux/lib/libcufft.so" \
  ../csound \
  >> $LOGS/csound.log 2>&1
echo "Compiling CSound"
/usr/bin/time make --jobs=`nproc` \
  >> $LOGS/csound.log 2>&1
echo "Installing CSound"
make install \
  >> $LOGS/csound.log 2>&1
ldconfig \
  >> $LOGS/csound.log 2>&1

echo "Relocating samples to '/usr/local/share/csound/samples'"
rm -fr /usr/local/share/csound
mkdir --parents /usr/local/share/csound
mv /usr/local/share/samples /usr/local/share/csound/samples
