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
rm -f $LOGS/cmake.log
cd $SOURCE_DIR

echo "Installing latest 'cmake'"
wget --quiet --no-clobber \
  https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/cmake-$CMAKE_VERSION-linux-aarch64.sh
chmod +x cmake-$CMAKE_VERSION-linux-aarch64.sh 
./cmake-$CMAKE_VERSION-linux-aarch64.sh --skip-license --prefix=/usr/local
which cmake
cmake --version
rm cmake-$CMAKE_VERSION-linux-aarch64.sh 
