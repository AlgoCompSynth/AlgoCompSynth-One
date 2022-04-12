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
rm -f $SYNTH_LOGS/R-audio.log

echo "Installing Linux packages"
sudo apt-get install -qqy --no-install-recommends \
  ffmpeg \
  flac \
  less \
  libsox-fmt-all \
  mp3splt \
  >> $SYNTH_LOGS/R-audio.log 2>&1
sudo apt-get clean

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Installing conda packages"
mamba install --quiet --yes \
  fftw \
  portaudio \
  >> $SYNTH_LOGS/R-audio.log 2>&1

echo "Installing R packages"
export PKG_CONFIG_PATH=$SYNTH_HOME/mambaforge/envs/r-reticulate/lib/pkgconfig
export PKG_CPPFLAGS="-DHAVE_WORKING_LOG1P"
/usr/bin/time $SYNTH_SCRIPTS/audio.R \
  >> $SYNTH_LOGS/R-audio.log 2>&1

echo "Cleanup"
mamba list \
  >> $SYNTH_LOGS/R-audio.log 2>&1
mamba clean --tarballs --yes \
  >> $SYNTH_LOGS/R-audio.log 2>&1

echo "Finished"
