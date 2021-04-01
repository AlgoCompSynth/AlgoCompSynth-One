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

echo "Downloading libmusicxml source"
rm -fr libmusicxml*
curl -Ls \
  https://github.com/grame-cncm/libmusicxml/archive/refs/tags/v$LIBMUSICXML_VERSION.tar.gz \
  | tar --extract --gunzip --file=-
cd libmusicxml-$LIBMUSICXML_VERSION/build

echo "Compiling libmusicxml"
export CMAKEOPT="-DLILY=off,-Wno-dev"
/usr/bin/time make --jobs=`nproc` \
  >> $HOME/Logfiles/libmusicxml.log 2>&1
echo "Installing libmusicxml"
make install \
  >> $HOME/Logfiles/libmusicxml.log 2>&1
ldconfig -v \
  >> $HOME/Logfiles/libmusicxml.log 2>&1
