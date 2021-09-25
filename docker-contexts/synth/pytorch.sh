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

source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate r-reticulate

echo "Installing Linux dependencies"
/usr/bin/time sudo apt install -qqy --no-install-recommends \
  libopenblas-base \
  libopenmpi-dev \
  >> $SYNTH_LOGS/pytorch.log 2>&1

echo "Downloading PyTorch wheel"
wget -q -nc $PYTORCH_WHEEL_URL -O /tmp/$PYTORCH_WHEEL_FILE

echo "Installing PyTorch"
/usr/bin/time pip install /tmp/$PYTORCH_WHEEL_FILE \
  >> $SYNTH_LOGS/pytorch.log 2>&1
