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
cd $SOURCE_DIR

echo "Installing dependencies"
apt-get install -qqy --no-install-recommends \
  libmicrohttpd-dev \
  libssl-dev \
  libtinfo-dev \
  llvm-10 \
  llvm-10-dev \
  >> $LOGS/faust.log 2>&1
apt-get clean
ln -s /usr/bin/llvm-config-10 /usr/bin/llvm-config

echo "Downloading faust source"
rm -fr faust*
curl -Ls \
  https://github.com/grame-cncm/faust/releases/download/$FAUST_VERSION/faust-$FAUST_VERSION.tar.gz \
  | tar --extract --gunzip --file=-

echo "Compiling faust"
cd faust-$FAUST_VERSION/build
export CMAKEOPT="-Wno-dev"
make TARGETS=all.cmake BACKENDS=all.cmake \
  >> $LOGS/faust.log 2>&1
echo "Installing faust"
make install \
  >> $LOGS/faust.log 2>&1
ldconfig \
  >> $LOGS/faust.log 2>&1

echo "Cleanup"
rm -fr $SOURCE_DIR/faust*
