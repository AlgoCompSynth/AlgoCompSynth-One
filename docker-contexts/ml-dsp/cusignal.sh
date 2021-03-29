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
rm -f $HOME/Logfiles/cusignal.log
cd $HOME/Projects

rm -fr cusignal*
echo "Downloading cuSignal $CUSIGNAL_VERSION source"
curl -Ls \
  https://github.com/rapidsai/cusignal/archive/refs/tags/v$CUSIGNAL_VERSION.tar.gz \
  | tar --extract --gunzip --file=-
export CUSIGNAL_HOME=$(pwd)/cusignal-$CUSIGNAL_VERSION
cd $CUSIGNAL_HOME

sed --in-place=.bak --expression='s;python setup.py;sudo python3 setup.py;' ./build.sh
/usr/bin/time ./build.sh --allgpuarch \
  >> $HOME/Logfiles/cusignal.log 2>&1
echo "Copying '$CUSIGNAL_HOME/notebooks' to '$HOME/Notebooks/cusignal-notebooks'"
mkdir --parents $HOME/Notebooks
cp -rp $CUSIGNAL_HOME/notebooks $HOME/Notebooks/cusignal-notebooks



