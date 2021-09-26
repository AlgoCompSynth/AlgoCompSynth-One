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
rm -f $EDGYR_SYNTH_LOGS/fluidsynth.log
cd $PROJECT_HOME

echo "Installing FluidSynth Linux dependencies"
sudo apt-get install -y --no-install-recommends \
  cmake \
  libglib2.0-dev \
  libsndfile1-dev \
  libpulse-dev \
  libasound2-dev \
  portaudio19-dev \
  libjack-jackd2-dev \
  liblash-compat-dev \
  libsystemd-dev \
  libdbus-1-dev \
  ladspa-sdk \
  libsdl2-dev \
  libreadline-dev \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  >> $EDGYR_SYNTH_LOGS/libinstpatch.log 2>&1
sudo apt-get clean

echo "Downloading libinstpatch"
rm -fr libinstpatch*
curl -Ls \
  https://github.com/swami/libinstpatch/archive/refs/tags/v$LIBINSTPATCH_VERSION.tar.gz \
  | tar --extract --gunzip --file=-
pushd libinstpatch-$LIBINSTPATCH_VERSION

  echo "Configuring libinstpatch"
  mkdir --parents build; cd build
  cmake \
    -Wno-dev \
    -DLIB_SUFFIX="" \
    .. \
    >> $EDGYR_SYNTH_LOGS/libinstpatch.log 2>&1

  echo "Compiling libinstpatch"
  /usr/bin/time make --jobs=`nproc` \
    >> $EDGYR_SYNTH_LOGS/libinstpatch.log 2>&1

  echo "Installing libinstpatch"
  sudo make install \
    >> $EDGYR_SYNTH_LOGS/libinstpatch.log 2>&1
  sudo ldconfig
  popd

echo "Cleanup"
rm -fr $PROJECT_HOME/libinstpatch*

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
    -Denable-portaudio=ON \
    .. \
    >> $EDGYR_SYNTH_LOGS/fluidsynth.log 2>&1

  echo "Compiling FluidSynth"
  /usr/bin/time make --jobs=`nproc` \
    >> $EDGYR_SYNTH_LOGS/fluidsynth.log 2>&1
  echo "Installing FluidSynth"
  sudo make install \
    >> $EDGYR_SYNTH_LOGS/fluidsynth.log 2>&1
  sudo ldconfig
  popd

echo "Cleanup"
rm -fr $PROJECT_HOME/fluidsynth*
