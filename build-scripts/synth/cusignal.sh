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

# https://github.com/supercollider/supercollider/wiki/Installing-supercollider-from-source-on-Ubuntu

set -e
rm -f $LOGS/cusignal.log

echo "Updating L4T"
apt-get update >> $LOGS/cusignal.log 2>&1
apt-get upgrade -y >> $LOGS/cusignal.log 2>&1

echo "Installing Linux dependencies"
apt-get install -qqy --no-install-recommends \
  file \
  time \
  tree \
  vim-nox \
  >> $LOGS/cusignal.log 2>&1
apt-get clean >> $LOGS/cusignal.log 2>&1 

echo "Cloning cusignal"
cd $SOURCE_DIR
export CUSIGNAL_HOME=$(pwd)/cusignal
rm -fr $CUSIGNAL_HOME
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME \
  >> $LOGS/cusignal.log 2>&1
cd $CUSIGNAL_HOME

echo "Checking out version '$CUSIGNAL_VERSION'"
git checkout $CUSIGNAL_VERSION  \
  >> $LOGS/cusignal.log 2>&1

echo "Installing cusignal"
sed --in-place=.bak --expression='s;python setup.py;python3 setup.py;' ./build.sh
/usr/bin/time ./build.sh --allgpuarch \
  >> $LOGS/cusignal.log 2>&1

echo "Copying '$CUSIGNAL_HOME/notebooks' to '/usr/local/share/cusignal-notebooks'"
cp -rp $CUSIGNAL_HOME/notebooks /usr/local/share/cusignal-notebooks
