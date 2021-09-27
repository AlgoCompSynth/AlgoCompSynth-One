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
rm -f $LOGS/llvm.log
cd $SOURCE_DIR

export LLVM_REPO=https://github.com/llvm/llvm-project/releases/download/llvmorg-$LLVM_VERSION
export LLVM_FILE=clang+llvm-$LLVM_VERSION-aarch64-linux-gnu.tar.xz
export LLVM_TARBALL=$LLVM_REPO/$LLVM_FILE
wget --quiet $LLVM_TARBALL
tar --extract --xz --file=$LLVM_FILE --directory=/usr/local --strip-components=1
rm -f $LLVM_FILE
