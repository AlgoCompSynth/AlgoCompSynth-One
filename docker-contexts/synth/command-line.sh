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
rm -f $LOGS/command-line.log

echo "Installing command line base"
apt-get update \
  >> $LOGS/command-line.log
apt-get upgrade -y \
  >> $LOGS/command-line.log
apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  ca-certificates \
  curl \
  emacs-nox \
  file \
  git \
  gnupg \
  llvm-10-dev \
  lynx \
  man-db \
  mlocate \
  mutt \
  nano \
  ninja-build \
  pkg-config \
  screen \
  software-properties-common \
  sudo \
  time \
  tmux \
  tree \
  unzip \
  vim-nox \
  wget \
  >> $LOGS/command-line.log 2>&1
ln -sf /usr/bin/llvm-config-10 /usr/bin/llvm-config
apt-get clean