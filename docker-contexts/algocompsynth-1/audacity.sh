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
rm -f $LOGS/audacity.log
cd $SOURCE_DIR

echo "Installing Linux dependencies"
apt-get install -qqy --no-install-recommends \
  libavcodec-dev \
  libavformat-dev \
  libavutil-dev \
  >> $LOGS/audacity.log 2>&1
apt-get clean

echo "Cloning audacity source"
rm -fr audacity*
git clone --recurse-submodules https://github.com/audacity/audacity.git \
  >> $LOGS/audacity.log 2>&1
pushd audacity
  git checkout "Audacity-$AUDACITY_VERSION"
    >> $LOGS/audacity.log 2>&1

  echo "Configuring audacity"
  rm -fr build && mkdir build && cd build
  cmake \
    -Wno-dev \
    -DCMAKE_BUILD_TYPE=Release \
    -Daudacity_use_ffmpeg=loaded \
    .. \
    >> $LOGS/audacity.log 2>&1

  echo "Compiling audacity"
  make --jobs=`nproc` \
    >> $LOGS/audacity.log 2>&1

  echo "Installing audacity"
  make install \
    >> $LOGS/audacity.log 2>&1
  ldconfig
  popd

echo "Cleanup"
rm -fr $SOURCE_DIR/audacity*
