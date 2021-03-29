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
rm -f $HOME/Logfiles/tidal.log
cd $HOME/Projects

echo "Installing dependencies"
sudo apt-get install -qqy --no-install-recommends \
  cabal-install \
  >> $HOME/Logfiles/tidal.log 2>&1
sudo apt-get clean

echo "Updating package list"
rm -fr $HOME/.cabal/
/usr/bin/time cabal update \
  >> $HOME/Logfiles/tidal.log 2>&1
echo "Installing tidal"
/usr/bin/time cabal install \
  --jobs=`nproc` \
  tidal \
  >> $HOME/Logfiles/tidal.log 2>&1
