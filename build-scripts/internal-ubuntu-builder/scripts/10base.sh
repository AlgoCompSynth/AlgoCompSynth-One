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
rm -f $LOGS/base.log
cd $SOURCE_DIR

echo "Update and upgrade"
apt-get update \
  >> $LOGS/base.log 2>&1
apt-get upgrade -y \
  >> $LOGS/base.log 2>&1

echo "Installing Ubuntu packages"
apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  ca-certificates \
  curl \
  emacs-nox \
  gnupg \
  lynx \
  mlocate \
  nano \
  software-properties-common \
  time \
  tree \
  vim-nox \
  wget \
  >> $LOGS/base.log 2>&1

echo "Installing latest Erlang OTP"
wget --quiet \
  https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb
dpkg -i erlang-solutions_2.0_all.deb \
  >> $LOGS/base.log 2>&1
apt-get update \
  >> $LOGS/base.log 2>&1
apt-get install -qqy --no-install-recommends \
  erlang-dev \
  >> $LOGS/base.log 2>&1

echo "Updating apt-file database"
apt-file update \
  >> $LOGS/base.log 2>&1

echo "Installing latest 'cmake'"
wget --quiet https://github.com/Kitware/CMake/releases/download/v3.20.0/cmake-3.20.0-linux-aarch64.sh
chmod +x cmake-3.20.0-linux-aarch64.sh 
./cmake-3.20.0-linux-aarch64.sh --skip-license --prefix=/usr/local
which cmake
cmake --version

echo "Updating 'locate' database"
updatedb \
  >> $LOGS/base.log 2>&1
