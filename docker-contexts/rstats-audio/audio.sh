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
rm -f $LOGS/audio.log
cd $SOURCE_DIR

echo "Installing Linux dependencies"
apt-get install -qqy --no-install-recommends \
  libfftw3-dev \
  libfftw3-mpi-dev \
  libgdal-dev \
  libudunits2-dev \
  >> $LOGS/audio.log 2>&1
apt-get clean

/usr/bin/time Rscript -e "source('$SCRIPTS/audio.R')" \
  >> $LOGS/audio.log 2>&1
