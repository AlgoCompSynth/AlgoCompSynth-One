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
rm -f $LOGS/faust.log
cd $SOURCE_DIR

echo "Cloning faust"
rm -fr faust
git clone https://github.com/grame-cncm/faust.git \
  >> $LOGS/faust.log 2>&1
cd faust
git submodule update --init \
  >> $LOGS/faust.log 2>&1
git checkout $FAUST_VERSION \
  >> $LOGS/faust.log 2>&1

echo "Compiling faust - selecting only 'regular' backends"
#cp build/backends/regular.cmake build/backends/all.cmake
cd build
/usr/bin/time make TARGETS=all.cmake BACKENDS=regular.cmake \
  >> $LOGS/faust.log 2>&1
echo "Installing faust"
make install \
  >> $LOGS/faust.log 2>&1
ldconfig \
  >> $LOGS/faust.log 2>&1
