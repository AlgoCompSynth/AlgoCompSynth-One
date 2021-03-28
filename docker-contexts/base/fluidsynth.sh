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
rm -f $LOGS/fluidsynth.log
cd $SOURCE_DIR

echo "Cloning fluidsynth"
rm -fr fluidsynth
git clone --recursive https://github.com/FluidSynth/fluidsynth.git \
  >> $LOGS/fluidsynth.log 2>&1
cd fluidsynth
git checkout $FLUIDSYNTH_VERSION \
  >> $LOGS/fluidsynth.log 2>&1

echo "Compiling FluidSynth"
mkdir --parents build; cd build
cmake -DLIB_SUFFIX="" .. \
  >> $LOGS/fluidsynth.log 2>&1
/usr/bin/time make --jobs=`nproc` \
  >> $LOGS/fluidsynth.log 2>&1
echo "Installing FluidSynth"
make install \
  >> $LOGS/fluidsynth.log 2>&1
ldconfig \
  >> $LOGS/fluidsynth.log 2>&1
fluidsynth --version
