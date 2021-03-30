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
cd $SOURCE_DIR

echo "Installing Linux dependencies"
apt-get update \
  >> $LOGS/supercollider.log 2>&1
apt-get install -qqy --no-install-recommends \
  build-essential \
  curl \
  ca-certificates \
  libasound2-dev \
  libavahi-client-dev \
  libfftw3-dev \
  libjack-jackd2-dev \
  libsndfile1-dev \
  libudev-dev \
  wget \
  >> $LOGS/supercollider.log 2>&1
apt-get clean

echo "Installing latest 'cmake'"
wget --quiet --no-clobber \
  https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/cmake-$CMAKE_VERSION-linux-aarch64.sh
chmod +x cmake-$CMAKE_VERSION-linux-aarch64.sh 
./cmake-$CMAKE_VERSION-linux-aarch64.sh --skip-license --prefix=/usr/local
which cmake
cmake --version
rm cmake-$CMAKE_VERSION-linux-aarch64.sh 

echo "Downloading supercollider source"
rm -fr SuperCollider*
curl -Ls $SUPERCOLLIDER_TARBALL \
  | tar --extract --bzip2 --file=- \
  >> $LOGS/supercollider.log 2>&1
pushd SuperCollider*
  export SC_PATH=$PWD

  echo "Configuring supercollider"
  mkdir build && cd build
  cmake \
    -Wno-dev \
    -DCMAKE_BUILD_TYPE=Release \
    -DNATIVE=ON \
    -DNO_X11=ON \
    -DSC_ABLETON_LINK=OFF \
    -DSC_IDE=OFF \
    -DSC_QT=OFF \
    -DSC_ED=OFF \
    -DSC_VIM=OFF \
    -DENABLE_TESTSUITE=OFF \
    -DSC_EL=NO \
    -DINSTALL_HELP=OFF \
    .. \
    >> $LOGS/supercollider.log 2>&1

  echo "Compiling supercollider"
  make --jobs=`nproc` \
    >> $LOGS/supercollider.log 2>&1

  echo "Installing supercollider"
  make install \
    >> $LOGS/supercollider.log 2>&1
  ldconfig -v \
    >> $LOGS/supercollider.log 2>&1
  popd

echo "Downloading sc3-plugins source"
rm -fr sc3-plugins*
curl -Ls $SC3_PLUGINS_TARBALL \
  | tar --extract --bzip2 --file=- \
  >> $LOGS/supercollider.log 2>&1
pushd sc3-plugins*

  echo "Building sc3-plugins"
  mkdir build && cd build
  cmake \
    -Wno-dev \
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
  ldconfig -v \
    >> $LOGS/supercollider.log 2>&1
  popd

echo "Cleanup"
rm -fr $SOURCE_DIR/SuperCollider*
rm -fr $SOURCE_DIR/sc3-plugins*
