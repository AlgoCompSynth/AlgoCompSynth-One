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
rm -f $LOGS/faust.log
cd $SOURCE_DIR

echo "Installing dependencies"
apt-get update \
  >> $LOGS/faust.log 2>&1
apt-get upgrade -y \
  >> $LOGS/faust.log 2>&1
apt-get install -qqy --no-install-recommends \
  build-essential \
  ca-certificates \
  curl \
  libmicrohttpd-dev \
  pkg-config \
  wget \
  >> $LOGS/faust.log 2>&1
apt-get clean

echo "Installing latest 'cmake'"
wget --quiet --no-clobber \
  https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/cmake-$CMAKE_VERSION-linux-aarch64.sh
chmod +x cmake-$CMAKE_VERSION-linux-aarch64.sh
./cmake-$CMAKE_VERSION-linux-aarch64.sh --skip-license --prefix=/usr/local
which cmake
cmake --version
rm cmake-$CMAKE_VERSION-linux-aarch64.sh

echo "Downloading faust source"
rm -fr faust*
curl -Ls \
  https://github.com/grame-cncm/faust/releases/download/$FAUST_VERSION/faust-$FAUST_VERSION.tar.gz \
  | tar --extract --gunzip --file=-

echo "Compiling faust - selecting only 'regular' backends"
cd faust-$FAUST_VERSION/build
export CMAKEOPT="-Wno-dev"
make TARGETS=all.cmake BACKENDS=regular.cmake \
  >> $LOGS/faust.log 2>&1
echo "Installing faust"
make install \
  >> $LOGS/faust.log 2>&1
ldconfig -v \
  >> $LOGS/faust.log 2>&1

echo "Cleanup"
rm -fr $SOURCE_DIR/faust*
