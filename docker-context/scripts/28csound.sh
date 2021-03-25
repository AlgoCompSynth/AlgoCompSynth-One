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

echo "Installing build dependencies"
apt-get install -y --no-install-recommends \
  >> $LOGS/csound.log 2>&1

cd $SRCDIR
echo "Downloading CSound $CSOUND_VERSION source"
rm -fr csound*
wget -q -O - https://github.com/csound/csound/archive/$CSOUND_VERSION.tar.gz \
  | tar xzf -
cd csound-$CSOUND_VERSION/
mkdir cs6make
cd cs6make/
export CPATH=/usr/include/lame:/usr/include/pulse:$CPATH

echo "Compiling CSound"
cmake \
  -DBUILD_CUDA_OPCODES=ON \
  -DBUILD_STATIC_LIBRARY=ON \
  -DLAME_HEADER="/usr/include/lame/lame.h" \
  -DPULSEAUDIO_HEADER="/usr/include/pulse/simple.h" \
  ..  >> $LOGS/csound.log 2>&1
/usr/bin/time make --jobs=`nproc` \
  >> $LOGS/csound.log 2>&1
echo "Installing CSound"
make install >> $LOGS/csound.log 2>&1
/sbin/ldconfig --verbose \
  >> $LOGS/csound.log 2>&1
cd ..
rm -fr cs6make

rm -fr /usr/local/share/csound
mkdir --parents /usr/local/share/csound
mv /usr/local/share/samples /usr/local/share/csound/samples
