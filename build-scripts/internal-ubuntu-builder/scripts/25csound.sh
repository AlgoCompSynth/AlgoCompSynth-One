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
