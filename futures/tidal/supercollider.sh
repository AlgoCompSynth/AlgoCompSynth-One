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
rm -f $HOME/Logfiles/supercollider.log
cd $HOME/Projects

echo "Cloning supercollider repo"
rm -fr supercollider
git clone --recursive https://github.com/supercollider/supercollider.git \
  >> $HOME/Logfiles/supercollider.log 2>&1
pushd supercollider
  git checkout $SUPERCOLLIDER_VERSION \
    >> $HOME/Logfiles/supercollider.log 2>&1
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
    .. \
    >> $HOME/Logfiles/supercollider.log 2>&1

  echo "Compiling supercollider"
  /usr/bin/time make --jobs=`nproc` \
    >> $HOME/Logfiles/supercollider.log 2>&1

  echo "Installing supercollider"
  sudo make install \
    >> $HOME/Logfiles/supercollider.log 2>&1
  sudo ldconfig -v \
    >> $HOME/Logfiles/supercollider.log 2>&1
  popd

echo "Cloning sc3-plugins repo"
rm -fr sc3-plugins
git clone --recursive https://github.com/supercollider/sc3-plugins.git \
  >> $HOME/Logfiles/supercollider.log 2>&1
pushd sc3-plugins
  git checkout $SC3_PLUGINS_VERSION \
    >> $HOME/Logfiles/supercollider.log 2>&1

  echo "Building sc3-plugins"
  mkdir build && cd build
  cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DNATIVE=ON \
    -DQUARKS=ON \
    .. \
    >> $HOME/Logfiles/supercollider.log 2>&1
  /usr/bin/time make --jobs=`nproc` \
    >> $HOME/Logfiles/supercollider.log 2>&1
  echo "Installing sc3-plugins"
  sudo make install \
    >> $HOME/Logfiles/supercollider.log 2>&1
  sudo ldconfig -v \
    >> $HOME/Logfiles/supercollider.log 2>&1
  popd
