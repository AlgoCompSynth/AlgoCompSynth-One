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
conda activate r-reticulate

echo "Installing conda dependencies"
conda install r-sf r-units --quiet --yes \
  >> $SYNTH_LOGS/R-audio.log 2>&1

echo "Installing Linux dependencies"
sudo apt-get install -qqy --no-install-recommends \
  libfftw3-dev \
  libfftw3-mpi-dev \
  >> $SYNTH_LOGS/R-audio.log 2>&1
sudo apt-get clean

echo "Installing R packages"
$HOME/Installers/R/audio.R \
  >> $SYNTH_LOGS/R-audio.log 2>&1

echo "Finished"
