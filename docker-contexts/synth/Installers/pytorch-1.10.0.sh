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
rm -f $SYNTH_LOGS/pytorch.log

echo "Installing Linux dependencies"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  libopenblas-base \
  libopenmpi-dev \
  >> $SYNTH_LOGS/pytorch.log 2>&1
sudo apt-get clean

echo "Downloading PyTorch wheel"
export PYTORCH_WHEEL_URL="https://nvidia.box.com/shared/static/fjtbno0vpo676a25cgvuqc1wty0fkkg6.whl"
export PYTORCH_WHEEL_FILE="torch-1.10.0-cp36-cp36m-linux_aarch64.whl"
export TORCHAUDIO_VERSION="0.10.0"

rm -f /tmp/$PYTORCH_WHEEL_FILE
wget -q $PYTORCH_WHEEL_URL -O /tmp/$PYTORCH_WHEEL_FILE

echo "Installing PyTorch"
/usr/bin/time sudo pip3 install /tmp/$PYTORCH_WHEEL_FILE \
  >> $SYNTH_LOGS/pytorch.log 2>&1

echo "Cloning 'torchaudio'"
pushd /tmp
sudo rm -fr audio
git clone --recurse-submodules https://github.com/pytorch/audio.git \
  >> $SYNTH_LOGS/pytorch.log 2>&1
cd audio
git checkout v$TORCHAUDIO_VERSION \
  >> $SYNTH_LOGS/pytorch.log 2>&1

echo "Installing 'torchaudio'"
/usr/bin/time sudo python3 setup.py install \
  >> $SYNTH_LOGS/pytorch.log 2>&1
popd

echo "Cleanup"
sudo rm -fr /tmp/audio
