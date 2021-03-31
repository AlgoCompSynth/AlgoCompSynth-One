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

echo "Updating and upgrading"
apt-get update \
  >> $LOGS/base.log 2>&1
apt-get upgrade -y \
  >> $LOGS/base.log 2>&1

echo "Installing dependencies"
apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  ca-certificates \
  curl \
  file \
  git \
  gnupg \
  lynx \
  mlocate \
  nano \
  pkg-config \
  software-properties-common \
  sudo \
  time \
  tree \
  vim-nox \
  wget \
  >> $LOGS/base.log 2>&1
apt-get clean
