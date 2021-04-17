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
rm -f $LOGS/wxWidgets.log
cd $SOURCE_DIR

echo "Installing dependencies"
apt-get install -y --no-install-recommends \
  libgtk2.0-dev \
  >> $LOGS/wxWidgets.log 2>&1
apt-get clean

echo "Cloning wxWidgets"
rm -fr wxWidgets*
git clone --recurse-submodules https://github.com/audacity/wxWidgets.git \
  >> $LOGS/wxWidgets.log 2>&1
cd wxWidgets
mkdir buildgtk
cd buildgtk
../configure --with-cxx=14 --with-gtk=2 \
  >> $LOGS/wxWidgets.log 2>&1
make --jobs=`nproc` install \
  >> $LOGS/wxWidgets.log 2>&1
ldconfig
