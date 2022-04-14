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

echo "Installing R packages"
#export PKG_CONFIG_PATH=$SYNTH_HOME/mambaforge/envs/r-reticulate/lib/pkgconfig
#export PKG_CPPFLAGS="-DHAVE_WORKING_LOG1P"
#export CPATH=$CPATH:$CONDA_PREFIX/include
/usr/bin/time ./audio.R

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
