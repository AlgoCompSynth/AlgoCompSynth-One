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
rm -f $LOGS/libinstpatch.log
cd $SOURCE_DIR

echo "Installing Linux dependencies"
apt-get install -y --no-install-recommends \
  libglib2.0-dev \
  libsndfile1-dev \
  >> $LOGS/libinstpatch.log 2>&1
apt-get clean

echo "Downloading libinstpatch"
rm -fr libinstpatch*
curl -Ls \
  https://github.com/swami/libinstpatch/archive/refs/tags/v$LIBINSTPATCH_VERSION.tar.gz \
  | tar --extract --gunzip --file=-
pushd libinstpatch-$LIBINSTPATCH_VERSION

  echo "Compiling libinstpatch"
  mkdir --parents build; cd build
  cmake \
    -Wno-dev \
    -DLIB_SUFFIX="" \
    .. \
    >> $LOGS/libinstpatch.log 2>&1
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGS/libinstpatch.log 2>&1
  echo "Installing libinstpatch"
  make install \
    >> $LOGS/libinstpatch.log 2>&1
  ldconfig
  popd

echo "Cleanup"
rm -fr $SOURCE_DIR/libinstpatch*
