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
rm -f $LOGS/pandoc.log
cd $SOURCE_DIR

echo "Downloading pandoc binary"
export BASE_URL=https://github.com/jgm/pandoc/releases/download/$PANDOC_VERSION
export FILE=pandoc-$PANDOC_VERSION-linux-arm64.tar.gz
echo $BASE_URL/$FILE
curl -Ls $BASE_URL/$FILE \
  | tar --directory=/usr/local --strip-components=2 --extract --gunzip --file=-
/usr/local/bin/pandoc --version
