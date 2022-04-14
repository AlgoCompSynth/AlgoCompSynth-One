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

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Cloning 'torchaudio'"
cd $SYNTH_PROJECTS
rm -fr audio*
git clone --recurse-submodules https://github.com/pytorch/audio.git
cd audio
git checkout v$TORCHAUDIO_VERSION

echo "Installing 'torchaudio'"
echo "PATH = $PATH"
/usr/bin/time python setup.py install

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
