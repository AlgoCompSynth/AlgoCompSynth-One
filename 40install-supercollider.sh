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

# https://github.com/supercollider/supercollider/wiki/Installing-SuperCollider-from-source-on-Ubuntu
echo "Installing build dependencies"
sudo apt-get install -y \
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
  vim-nox
source $HOME/miniconda3/etc/profile.d/conda.sh

export SUPERCOLLIDER_VERSION="Version-3.11.1"
export SC3_PLUGINS_VERSION="Version-3.11.1"

echo "Creating fresh 'SuperCollider' conda environment"
conda env remove --name SuperCollider --yes
conda create --name SuperCollider --quiet --yes \
  cmake
conda activate SuperCollider
mkdir --parents $CONDA_PREFIX/src
pushd $CONDA_PREFIX/src
  rm -fr SuperCollider*

  echo "Cloning 'supercollider' repo"
  git clone --recursive https://github.com/supercollider/supercollider.git
  pushd supercollider
    git checkout $SUPERCOLLIDER_VERSION
    export SC_PATH=$PWD

    echo "Building 'SuperCollider'"
    mkdir build && cd build
    cmake -L ..
    cmake \
      -DCMAKE_BUILD_TYPE=Release \
      -DNATIVE=ON \
      -DNO_X11=ON \
      -DSC_IDE=OFF \
      -DSC_QT=OFF \
      -DSC_ABLETON_LINK=OFF \
      -DSC_USE_QTWEBENGINE=OFF \
      ..
    make --jobs=`nproc`
    echo "Installing 'SuperCollider'"
    sudo make install
    sudo /sbin/ldconfig
    popd

  echo "Cloning 'sc3-plugins' repo"
  git clone --recursive https://github.com/supercollider/sc3-plugins.git
  pushd sc3-plugins
    git checkout $SC3_PLUGINS_VERSION

    echo "Building 'sc3-plugins'"
    mkdir build && cd build
    cmake -L ..
    cmake \
      -DCMAKE_BUILD_TYPE=Release \
      -DNATIVE=ON \
      -DQUARKS=ON \
      ..
    make --jobs=`nproc`
    echo "Installing 'sc3-plugins'"
    sudo make install
    sudo /sbin/ldconfig
    popd

  popd
