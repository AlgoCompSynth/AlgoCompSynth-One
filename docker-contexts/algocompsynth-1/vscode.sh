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
rm -f $LOGS/vscode.log
cd $SOURCE_DIR

echo "Installing latest 'vscode'"
curl --location --silent --output vscode.deb \
  "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-arm64"
sudo apt-get install -y --no-install-recommends \
  ./vscode.deb \
  >> $LOGS/vscode.log 2>&1
