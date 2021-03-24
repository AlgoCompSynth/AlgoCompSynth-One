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
export LOGFILES=$HOME/logfiles
rm -f $LOGFILES/R.log

export SOURCE_DIR=$HOME/src
export R_VERSION_MAJOR=4
export R_VERSION_MINOR=0
export R_VERSION_PATCH=4
export R_LATEST=R-$R_VERSION_MAJOR.$R_VERSION_MINOR.$R_VERSION_PATCH
export WEBSITE="https://cloud.r-project.org/src/base"
export RELEASE_DIR="R-$R_VERSION_MAJOR"
export R_TARBALL="$R_LATEST.tar.gz"

echo "Installing build dependencies"
sudo apt-get update
sudo apt-get install -y --no-install-recommends \
  curl \
  gfortran \
  libbz2-dev \
  libcairo2-dev \
  libgit2-dev \
  libicu-dev \
  libjpeg-turbo8-dev \
  libjpeg8-dev \
  liblzma-dev \
  libncurses-dev \
  libopenblas-dev \
  libpango1.0-dev \
  libpcre2-dev \
  libreadline-dev \
  libtiff5-dev \
  openjdk-8-jdk \
  texinfo \
  tk-dev \
  zlib1g-dev \
  >> $LOGFILES/R.log 2>&1

echo "Creating / entering source directory"
mkdir --parents $SOURCE_DIR
pushd $SOURCE_DIR

  echo "Removing old R source directories"
  rm -fr R-*
  
  echo "Downloading $WEBSITE/$RELEASE_DIR/$R_TARBALL"
  curl -Ls "$WEBSITE/$RELEASE_DIR/$R_TARBALL" | tar xzf -
  echo "Using $R_LATEST"
  
  echo "Configuring"
  sudo rm -fr build-dir
  mkdir build-dir
  pushd build-dir

    ../$R_LATEST/configure --enable-R-shlib \
      >> $LOGFILES/R.log 2>&1
  
    echo "Compiling"
    /usr/bin/time make --jobs=`nproc` \
      >> $LOGFILES/R.log 2>&1
  
    echo "Making standalone math library"
    pushd src/nmath/standalone
      /usr/bin/time make --jobs=`nproc` \
        >> $LOGFILES/R.log 2>&1
      sudo make install \
        >> $LOGFILES/R.log 2>&1
      popd
  
    echo "Installing"
    sudo make install \
        >> $LOGFILES/R.log 2>&1
    popd
  
  zip -9rmyq $R_LATEST.zip $R_LATEST
  sudo rm -fr build-dir
  popd

cat misc/Rprofile >> $HOME/.Rprofile

echo "Installing R integration packages"
Rscript -e "source('misc/r-base.R')" \
  >> $LOGFILES/R.log 2>&1
