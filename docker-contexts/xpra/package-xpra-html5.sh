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
mkdir --parents $HOME/Logfiles
rm -f $HOME/Logfiles/xpra-html5.log

pushd $HOME/Downloads/Installers

  echo "Cloning xpra-html5"
  rm -fr xpra-html5
  git clone https://github.com/Xpra-org/xpra-html5 \
    >> $HOME/Logfiles/xpra-html5.log 2>&1

  echo "Checking out v$XPRA_HTML5_VERSION"
  pushd xpra-html5
    git checkout v$XPRA_HTML5_VERSION \
      >> $HOME/Logfiles/xpra-html5.log 2>&1

    echo "Building packages"
    python3 setup.py deb \
      >> $HOME/Logfiles/xpra-html5.log 2>&1
    popd

  popd
