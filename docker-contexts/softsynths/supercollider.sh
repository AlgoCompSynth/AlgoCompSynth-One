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
export LOGS=$SYNTH_HOME/Logfiles
export SOURCE_DIR=$SYNTH_HOME/Projects
rm -f $LOGS/supercollider.log
cd $SOURCE_DIR

echo "Installing Linux dependencies"
sudo apt-get update \
  >> $LOGS/supercollider.log 2>&1
sudo apt-get install -qqy --no-install-recommends \
  gedit \
  libavahi-client-dev \
  libqt5opengl5-dev \
  libqt5svg5-dev \
  libqt5websockets5-dev \
  libxcb-icccm4-dev \
  libxcb-util-dev \
  qtbase5-dev \
  qtdeclarative5-dev \
  qttools5-dev \
  qtwebengine5-dev \
  >> $LOGS/supercollider.log 2>&1
sudo apt-get clean

echo "Downloading supercollider source"
rm -fr SuperCollider*
curl -Ls $SUPERCOLLIDER_TARBALL \
  | tar --extract --bzip2 --file=- \
  >> $LOGS/supercollider.log 2>&1
pushd SuperCollider*
  export SC_PATH=$PWD

  echo "Configuring supercollider"
  rm -fr build && mkdir build && cd build
  cmake \
    -Wno-dev \
    -DCMAKE_BUILD_TYPE=Release \
    -DNATIVE=ON \
    -DSC_ABLETON_LINK=OFF \
    -DENABLE_TESTSUITE=OFF \
    -DLIBSCSYNTH=OFF \
    .. \
    >> $LOGS/supercollider.log 2>&1

  echo "Compiling supercollider"
  make --jobs=`nproc` \
    >> $LOGS/supercollider.log 2>&1

  echo "Installing supercollider"
  sudo make install \
    >> $LOGS/supercollider.log 2>&1
  sudo ldconfig -v \
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
  sudo make install \
    >> $LOGS/supercollider.log 2>&1
  sudo ldconfig -v \
    >> $LOGS/supercollider.log 2>&1
  popd

echo "Cleanup"
rm -fr $SOURCE_DIR/SuperCollider*
rm -fr $SOURCE_DIR/sc3-plugins*
