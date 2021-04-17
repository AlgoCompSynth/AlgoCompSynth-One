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
rm -f $LOGS/chuck.log
cd $SOURCE_DIR

echo "Installing dependencies"
apt-get install -y --no-install-recommends \
  bison \
  flex \
  >> $LOGS/chuck.log 2>&1

rm -fr chuck*
echo "Downloading ChucK $CHUCK_VERSION source"
curl -Ls https://chuck.cs.princeton.edu/release/files/chuck-$CHUCK_VERSION.tgz \
  | tar --extract --gunzip --file=-
pushd chuck-$CHUCK_VERSION/src

  echo "Compiling ChucK for jack"
  make --jobs=`nproc` linux-jack \
    >> $LOGS/chuck.log 2>&1
  echo "Installing ChucK"
  make install \
    >> $LOGS/chuck.log 2>&1
  ldconfig

  echo "Relocating ChucK examples"
  rm -fr /usr/local/share/chuck
  mkdir --parents /usr/local/share/chuck
  mv ../examples /usr/local/share/chuck/examples
  popd

echo "Installing Chugins"
git clone https://github.com/ccrma/chugins.git \
  >> $LOGS/chuck.log 2>&1
pushd chugins

  make linux \
    >> $LOGS/chuck.log 2>&1
  make install \
    >> $LOGS/chuck.log 2>&1
  ldconfig
  pushd Faust

    echo "Installing Fauck"
    make linux \
      >> $LOGS/chuck.log 2>&1
    make install \
      >> $LOGS/chuck.log 2>&1
    ldconfig
    popd

  popd

echo "Cleanup"
rm -fr $SOURCE_DIR/chuck $SOURCE_DIR/chugins
