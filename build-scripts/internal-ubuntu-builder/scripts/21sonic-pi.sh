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

# https://github.com/sonic-pi/supercollider/wiki/Installing-supercollider-from-source-on-Ubuntu

set -e
rm -f $LOGS/sonic-pi.log
cd $SOURCE_DIR

echo "Cloning sonic-pi repo"
rm -fr sonic-pi
git clone --recursive https://github.com/sonic-pi-net/sonic-pi.git \
  >> $LOGS/sonic-pi.log 2>&1
pushd sonic-pi
  git checkout $SONIC_PI_VERSION \
    >> $LOGS/sonic-pi.log 2>&1
  cd app

  echo "Linux pre-build"
  set +e
  ./linux-prebuild.sh \
    >> $LOGS/sonic-pi.log 2>&1
  set -e

  echo "Linux configuration"
  ./linux-config.sh \
    >> $LOGS/sonic-pi.log 2>&1

  echo "Build"
  cd build/
  cmake --build . --config Release \
    >> $LOGS/sonic-pi.log 2>&1
  popd

ldconfig \
  >> $LOGS/sonic-pi.log 2>&1
