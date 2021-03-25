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

echo "Installing build dependencies"
#sudo apt-get install -y --no-install-recommends \
  #>> $LOGS/fluidsynth.log 2>&1

cd $SRCDIR
rm -fr fluidsynth*
echo "Downloading FluidSynth $FLUIDSYNTH_VERSION source"
curl -Ls \
  https://github.com/FluidSynth/fluidsynth/archive/v$FLUIDSYNTH_VERSION.tar.gz \
  | tar xzf -
cd fluidsynth-$FLUIDSYNTH_VERSION

echo "Compiling FluidSynth"
mkdir --parents build; cd build
cmake -DLIB_SUFFIX="" .. \
  >> $LOGS/fluidsynth.log 2>&1
/usr/bin/time make --jobs=`nproc` \
  >> $LOGS/fluidsynth.log 2>&1
echo "Installing FluidSynth"
make install \
  >> $LOGS/fluidsynth.log 2>&1
