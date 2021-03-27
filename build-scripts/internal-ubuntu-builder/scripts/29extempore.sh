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
rm -f $LOGS/extempore.log
cd $SOURCE_DIR

export EXTEMPORE_VERSION="v0.8.8"
echo "Cloning extempore repo"
rm -fr extempore
git clone https://github.com/digego/extempore \
  >> $LOGS/extempore.log 2>&1
pushd extempore
  git checkout $EXTEMPORE_VERSION \
    >> $LOGS/extempore.log 2>&1

  echo "Configuring extempore"
  mkdir build && cd build
  cmake -L .. \
    -DASSETS=ON \
    >> $LOGS/extempore.log
  cmake \
    -DASSETS=ON \
    .. \
    >> $LOGS/extempore.log 2>&1
  echo "Compiling extempore"
  make --jobs=`nproc` \
    >> $LOGS/extempore.log 2>&1
  echo "Installing extempore"
  make install \
    >> $LOGS/extempore.log 2>&1
  ldconfig \
    >> $LOGS/extempore.log 2>&1
  popd
