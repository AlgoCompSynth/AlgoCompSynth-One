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

source $HOME/miniconda3/etc/profile.d/conda.sh
source $HOME/miniconda3/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PKG_CONFIG_PATH=$HOME/miniconda3/envs/r-reticulate/lib/pkgconfig

echo "Installing conda dependencies"
/usr/bin/time mamba install --quiet --yes \
  portaudio \
  >> $SYNTH_LOGS/R-audio.log 2>&1
  #fftw \
  #r-sf \
  #r-units \

echo "Installing R packages"
/usr/bin/time $SYNTH_SCRIPTS/audio.R \
  >> $SYNTH_LOGS/R-audio.log 2>&1

echo "Cleanup"
mamba clean --all --yes \
  >> $SYNTH_LOGS/R-audio.log 2>&1

echo "Finished"
