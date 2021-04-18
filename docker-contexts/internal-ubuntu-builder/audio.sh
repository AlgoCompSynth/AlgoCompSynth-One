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

echo "Installing PGDG Linux repository"
# https://wiki.postgresql.org/wiki/Apt
curl -Ls https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo cp $SCRIPTS/pgdg.list /etc/apt/sources.list.d/pgdg.list
apt-get update

echo "Installing Linux dependencies"
apt-get install -y --no-install-recommends \
  alsa-tools \
  alsa-utils \
  flac \
  libfftw3-dev \
  libfftw3-mpi-dev \
  libgdal-dev \
  libsox-dev \
  libsox-fmt-all \
  libudunits2-dev \
  mp3splt \
  sox \
  timidity \
  >> $LOGS/audio.log 2>&1
apt-get clean

/usr/bin/time Rscript -e "source('$SCRIPTS/audio.R')" \
  >> $LOGS/audio.log 2>&1
