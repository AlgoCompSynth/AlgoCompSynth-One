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

echo "Installing build dependencies"
apt-get install -qqy --no-install-recommends \
  libasound2-dev \
  libavahi-client-dev \
  libfftw3-dev \
  libjack-jackd2-dev \
  libqt5opengl5-dev \
  libqt5svg5-dev \
  libqt5websockets5-dev \
  libsndfile1-dev \
  libudev-dev \
  libx11-dev \
  libxt-dev \
  qtbase5-dev \
  qtdeclarative5-dev \
  qttools5-dev \
  qtwebengine5-dev \
  >> $LOGS/supercollider.log 2>&1

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
    >> $LOGS/supercollider.log
  cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DNATIVE=ON \
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
