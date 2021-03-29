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
rm -f $HOME/Logfiles/r-packages.log
cd $HOME

sudo apt-get install -qqy --no-install-recommends \
  libgdal-dev \
  libudunits2-dev \
  >> $HOME/Logfiles/r-packages.log 2>&1
sudo apt-get clean
echo "Installing R packages"
echo "This takes about 29 minutes on a 4 GB Nano"
echo "and 14 minutes on an AGX Xavier"
/usr/bin/time Rscript -e "source('Scripts/r-packages.R')" \
  >> $HOME/Logfiles/r-packages.log 2>&1
