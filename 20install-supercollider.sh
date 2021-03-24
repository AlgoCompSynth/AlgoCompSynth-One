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
export LOGFILES=$HOME/logfiles
rm -f $LOGFILES/supercollider.log

echo "Installing build dependencies"
sudo apt-get install -y --no-install-recommends \
  emacs-nox \
  libasound2-dev \
  libavahi-client-dev \
  libfftw3-dev \
  libicu-dev \
  libncurses5-dev \
  libqt5opengl5-dev \
  libqt5sensors5-dev \
  libqt5svg5-dev \
  libqt5websockets5-dev \
  libreadline6-dev \
  libsndfile1-dev \
  libudev-dev \
  libxcb-icccm4-dev \
  libxcb-util-dev \
  libxt-dev \
  pkg-config \
  qt5-default \
  qt5-qmake \
  qtbase5-dev \
  qtdeclarative5-dev \
  qtpositioning5-dev \
  qttools5-dev \
  qttools5-dev-tools \
  qtwebengine5-dev \
  vim-nox \
  >> $LOGFILES/supercollider.log 2>&1

export SUPERCOLLIDER_VERSION="Version-3.11.1"
export SC3_PLUGINS_VERSION="Version-3.11.1"

echo "Creating fresh 'supercollider' conda environment"
source $HOME/miniconda3/etc/profile.d/conda.sh
conda env remove --name supercollider --yes
conda create --name supercollider --quiet --yes \
  cmake
conda activate supercollider
mkdir --parents $CONDA_PREFIX/src
pushd $CONDA_PREFIX/src

  echo "Cloning 'supercollider' repo"
  git clone --recursive https://github.com/supercollider/supercollider.git
  pushd supercollider
    git checkout $SUPERCOLLIDER_VERSION
    export SC_PATH=$PWD

    echo "Building 'supercollider'"
    mkdir build && cd build
    cmake -L .. \
      >> $LOGFILES/supercollider.log
    cmake \
      -DCMAKE_BUILD_TYPE=Release \
      -DNATIVE=ON \
      .. \
      >> $LOGFILES/supercollider.log 2>&1
    make --jobs=`nproc` \
      >> $LOGFILES/supercollider.log 2>&1
    echo "Installing 'supercollider'"
    sudo make install
    sudo /sbin/ldconfig
    popd

  echo "Cloning 'sc3-plugins' repo"
  git clone --recursive https://github.com/supercollider/sc3-plugins.git
  pushd sc3-plugins
    git checkout $SC3_PLUGINS_VERSION

    echo "Building 'sc3-plugins'"
    mkdir build && cd build
    cmake -L .. \
      >> $LOGFILES/supercollider.log 2>&1
    cmake \
      -DCMAKE_BUILD_TYPE=Release \
      -DNATIVE=ON \
      -DQUARKS=ON \
      .. \
      >> $LOGFILES/supercollider.log 2>&1
    make --jobs=`nproc` \
      >> $LOGFILES/supercollider.log 2>&1
    echo "Installing 'sc3-plugins'"
    sudo make install \
      >> $LOGFILES/supercollider.log 2>&1
    sudo /sbin/ldconfig
    popd

  popd
