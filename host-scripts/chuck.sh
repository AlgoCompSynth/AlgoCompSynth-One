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
rm -f $HOME/Logfiles/chuck.log
cd $HOME/Downloads/Installers

rm -fr chuck*
echo "Downloading ChucK $CHUCK_VERSION source"
curl -Ls https://chuck.cs.princeton.edu/release/files/chuck-$CHUCK_VERSION.tgz \
  | tar --extract --gunzip --file=-
pushd chuck-$CHUCK_VERSION/src

  echo "Compiling ChucK for PulseAudio"
  make --jobs=`nproc` linux-pulse \
    >> $HOME/Logfiles/chuck.log 2>&1
  echo "Installing ChucK"
  sudo make install \
    >> $HOME/Logfiles/chuck.log 2>&1
  sudo ldconfig

  echo "Relocating ChucK examples"
  rm -fr $HOME/ChucK-examples
  mv ../examples $HOME/ChucK-examples
  popd

echo "Installing Chugins"
git clone https://github.com/ccrma/chugins.git \
  >> $HOME/Logfiles/chuck.log 2>&1
pushd chugins

  make linux \
    >> $HOME/Logfiles/chuck.log 2>&1
  sudo make install \
    >> $HOME/Logfiles/chuck.log 2>&1
  sudo ldconfig
  pushd Faust

    make linux \
      >> $HOME/Logfiles/chuck.log 2>&1
    sudo make install \
      >> $HOME/Logfiles/chuck.log 2>&1
    sudo ldconfig
    popd

  popd
