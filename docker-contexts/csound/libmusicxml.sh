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
rm -f $LOGS/libmusicxml.log
cd $SOURCE_DIR

echo "Updating and upgrading"
apt-get update \
  >> $LOGS/libmusicxml.log 2>&1
apt-get upgrade -y \
  >> $LOGS/libmusicxml.log 2>&1

echo "Installing dependencies"
apt-get install -qqy --no-install-recommends \
  build-essential \
  curl \
  git \
  emacs-nox \
  nano \
  sudo \
  time \
  vim-nox \
  wget \
  >> $LOGS/libmusicxml.log 2>&1
apt-get clean

echo "Installing latest 'cmake'"
wget --quiet --no-clobber \
  https://github.com/Kitware/CMake/releases/download/v3.20.0/cmake-3.20.0-linux-aarch64.sh
chmod +x cmake-3.20.0-linux-aarch64.sh 
./cmake-3.20.0-linux-aarch64.sh --skip-license --prefix=/usr/local
which cmake
cmake --version
rm cmake-3.20.0-linux-aarch64.sh 

echo "Cloning libmusicxml repo"
rm -fr libmusicxml
git clone https://github.com/grame-cncm/libmusicxml.git \
  >> $LOGS/libmusicxml.log 2>&1
cd libmusicxml
git checkout $LIBMUSICXML_VERSION \
  >> $LOGS/libmusicxml.log 2>&1
cd build

echo "Compiling libmusicxml"
/usr/bin/time make --jobs=`nproc` \
  >> $LOGS/libmusicxml.log 2>&1
echo "Installing libmusicxml"
make install \
  >> $LOGS/libmusicxml.log 2>&1
ldconfig \
  >> $LOGS/libmusicxml.log 2>&1
