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

echo "Installing Linux dependencies"
apt-get install -qqy --no-install-recommends \
  libglib2.0-dev \
  libsndfile1-dev \
  libpulse-dev \
  libasound2-dev \
  libjack-jackd2-dev \
  liblash-compat-dev \
  libsystemd-dev \
  libdbus-1-dev \
  ladspa-sdk \
  libinstpatch-dev \
  libsdl2-dev \
  libreadline-dev \
  >> $LOGS/fluidsynth.log 2>&1

echo "Downloading fluidsynth"
rm -fr fluidsynth*
curl -Ls \
  https://github.com/FluidSynth/fluidsynth/archive/refs/tags/v$FLUIDSYNTH_VERSION.tar.gz \
  | tar --extract --gunzip --file=-
pushd fluidsynth-$FLUIDSYNTH_VERSION

  echo "Compiling FluidSynth"
  mkdir --parents build; cd build
  cmake \
    -Wno-dev \
    -DLIB_SUFFIX="" \
    .. \
    >> $LOGS/fluidsynth.log 2>&1
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGS/fluidsynth.log 2>&1
  echo "Installing FluidSynth"
  make install \
    >> $LOGS/fluidsynth.log 2>&1
  ldconfig \
    >> $LOGS/fluidsynth.log 2>&1
  popd

echo "Cleanup"
rm -fr $SOURCE_DIR/fluidsynth*
apt-get clean
fluidsynth --version
