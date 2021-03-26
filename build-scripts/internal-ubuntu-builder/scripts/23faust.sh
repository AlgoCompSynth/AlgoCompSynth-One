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
rm -f $LOGS/faust.log
cd $SRCDIR

#echo "Installing build dependencies"
#apt-get install -y --no-install-recommends \
  #>> $LOGS/faust.log 2>&1

rm -fr faust*
echo "Downloading faust $FAUST_VERSION source"
curl -Ls https://github.com/grame-cncm/faust/releases/download/$FAUST_VERSION/faust-$FAUST_VERSION.tar.gz \
  | tar xzf -
cd faust-$FAUST_VERSION

echo "Symlinking llvm-10-config"
ln -s /usr/lib/llvm-10/bin/llvm-config /usr/bin/llvm-config
echo "Compiling faust"
/usr/bin/time make --jobs=`nproc` most \
  >> $LOGS/faust.log 2>&1
echo "Installing faust"
make install \
  >> $LOGS/faust.log 2>&1
echo "Removing llvm-10 symlink"
rm /usr/bin/llvm-config
