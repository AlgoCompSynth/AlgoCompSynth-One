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
rm -f $HOME/Logfiles/faust.log
cd $HOME/Projects

echo "Installing dependencies"
sudo apt-get install -qqy --no-install-recommends \
  libmicrohttpd-dev \
  >> $HOME/Logfiles/faust.log 2>&1
sudo apt-get clean

echo "Downloading faust source"
rm -fr faust*
curl -Ls \
  https://github.com/grame-cncm/faust/releases/download/$FAUST_VERSION/faust-$FAUST_VERSION.tar.gz \
  | tar --extract --gunzip --file=-

echo "Compiling faust - selecting only 'regular' backends"
cd faust-$FAUST_VERSION/build
#cp build/backends/regular.cmake build/backends/all.cmake
export CMAKEOPT="-Wno-dev"
/usr/bin/time make TARGETS=all.cmake BACKENDS=regular.cmake \
  >> $HOME/Logfiles/faust.log 2>&1
echo "Installing faust"
sudo make install \
  >> $HOME/Logfiles/faust.log 2>&1
sudo ldconfig -v \
  >> $HOME/Logfiles/faust.log 2>&1