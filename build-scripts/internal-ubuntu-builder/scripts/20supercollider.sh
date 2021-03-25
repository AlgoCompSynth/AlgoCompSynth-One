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

# https://github.com/supercollider/supercollider/wiki/Installing-supercollider-from-source-on-Ubuntu

set -e
rm -f $LOGS/supercollider.log

echo "Installing latest 'cmake'"
wget --quiet https://github.com/Kitware/CMake/releases/download/v3.20.0/cmake-3.20.0-linux-aarch64.sh
chmod +x cmake-3.20.0-linux-aarch64.sh 
./cmake-3.20.0-linux-aarch64.sh --skip-license --prefix=/usr/local
which cmake
cmake --version

echo "Installing build dependencies"
apt-get install -qqy --no-install-recommends \
  emacs-nox \
  libasound2-dev \
  libavahi-client-dev \
  libfftw3-dev \
  libjack-jackd2-dev \
  libsndfile1-dev \
  libudev-dev \
  >> $LOGS/supercollider.log 2>&1

cd $SOURCE_DIR
echo "Cloning supercollider repo"
rm -fr supercollider
git clone --recursive https://github.com/supercollider/supercollider.git \
  >> $LOGS/supercollider.log 2>&1
pushd supercollider
  git checkout $SUPERCOLLIDER_VERSION \
    >> $LOGS/supercollider.log 2>&1
  export SC_PATH=$PWD

  echo "Building supercollider"
  mkdir build && cd build
  cmake -L .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DNATIVE=ON \
    -DNO_X11=ON \
    -DSC_ABLETON_LINK=OFF \
    -DSC_ED=OFF \
    -DSC_IDE=OFF \
    -DSC_QT=OFF \
    >> $LOGS/supercollider.log
  cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DNATIVE=ON \
    -DNO_X11=ON \
    -DSC_ABLETON_LINK=OFF \
    -DSC_ED=OFF \
    -DSC_IDE=OFF \
    -DSC_QT=OFF \
    .. \
    >> $LOGS/supercollider.log 2>&1
  make --jobs=`nproc` \
    >> $LOGS/supercollider.log 2>&1
  echo "Installing supercollider"
  make install \
    >> $LOGS/supercollider.log 2>&1
  /sbin/ldconfig >> $LOGS/supercollider.log 2>&1
  popd

echo "Cloning sc3-plugins repo"
rm -fr sc3-plugins
git clone --recursive https://github.com/supercollider/sc3-plugins.git \
  >> $LOGS/supercollider.log 2>&1
pushd sc3-plugins
  git checkout $SC3_PLUGINS_VERSION \
    >> $LOGS/supercollider.log 2>&1

  echo "Building sc3-plugins"
  mkdir build && cd build
  cmake -L .. \
    >> $LOGS/supercollider.log 2>&1
  cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DNATIVE=ON \
    -DQUARKS=ON \
    .. \
    >> $LOGS/supercollider.log 2>&1
  make --jobs=`nproc` \
    >> $LOGS/supercollider.log 2>&1
  echo "Installing sc3-plugins"
  make install \
    >> $LOGS/supercollider.log 2>&1
  /sbin/ldconfig >> $LOGS/supercollider.log 2>&1
  popd
