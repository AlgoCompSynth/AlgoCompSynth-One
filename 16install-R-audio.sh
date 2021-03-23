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

echo "Activating 'r-reticulate'"
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate r-reticulate

# The versions of 'gdal' and 'libpq' in the base
# repos are too old, so we get them from the
# PostgreSQL Global Development Group (PGDG)
# https://wiki.postgresql.org/wiki/Apt
echo "Attaching PostgreSQL Global Development Group Repository"
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo cp misc/pgdg.list /etc/apt/sources.list.d/pgdg.list
sudo apt-get update
echo "Installing Linux dependencies"
sudo apt-get install -y --no-install-recommends \
  libfftw3-dev \
  libgdal-dev \
  libudunits2-dev

echo "Installing R audio packages"
Rscript -e "source('misc/audio.R')"
