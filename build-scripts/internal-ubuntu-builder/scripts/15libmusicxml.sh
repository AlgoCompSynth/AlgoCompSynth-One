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
rm -f $LOGS/libmusicxml.log
cd $SOURCE_DIR

echo "Cloning libmusicxml repo"
rm -fr libmusicxml
git clone https://github.com/grame-cncm/libmusicxml.git \
  >> $LOGS/libmusicxml.log 2>&1
cd libmusicxml
git checkout $LIBMUSICXML_VERSION \
  >> $LOGS/libmusicxml.log 2>&1
cd build

echo "Compiling libmusicxml"
/usr/bin/time make --jobs=`nproc` \
  >> $LOGS/libmusicxml.log 2>&1
echo "Installing libmusicxml"
make install \
  >> $LOGS/libmusicxml.log 2>&1
