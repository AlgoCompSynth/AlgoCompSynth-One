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
  freepats \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  ladspa-sdk \
  libasound2-dev \
  libdbus-1-dev \
  libglib2.0-dev \
  libinstpatch-dev \
  libjack-jackd2-dev \
  liblash-compat-dev \
  libportmidi-dev \
  libpulse-dev \
  libreadline-dev \
  libsdl2-dev \
  libsndfile-dev \
  libsystemd-dev \
  portaudio19-dev \
  >> $LOGS/fluidsynth.log 2>&1
apt-get clean

echo "Downloading fluidsynth"
rm -fr fluidsynth*
curl -Ls \
  https://github.com/FluidSynth/fluidsynth/archive/refs/tags/v$FLUIDSYNTH_VERSION.tar.gz \
  | tar --extract --gunzip --file=-
pushd fluidsynth-$FLUIDSYNTH_VERSION

  echo "Configuring FluidSynth"
  mkdir --parents build; cd build
  cmake \
    -Wno-dev \
    -DLIB_SUFFIX="" \
    .. \
    >> $LOGS/fluidsynth.log 2>&1
  echo "Compiling FluidSynth"
  make --jobs=`nproc` \
    >> $LOGS/fluidsynth.log 2>&1
  echo "Installing FluidSynth"
  make install \
    >> $LOGS/fluidsynth.log 2>&1
  popd

ldconfig -v \
  >> $LOGS/fluidsynth.log 2>&1
fluidsynth --version

echo "Cleanup"
rm -fr $SOURCE_DIR/fluidsynth*
