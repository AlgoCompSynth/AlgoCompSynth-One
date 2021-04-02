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
rm -f $HOME/Logfiles/miniforge.log
cd $HOME

mkdir --parents $HOME/Downloads/Installers
cd $HOME/Downloads/Installers
echo "Downloading Miniforge3 installer"
wget -q \
  https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
chmod +x Miniforge3-Linux-aarch64.sh

echo "Installing a fresh copy to '$HOME/miniconda3' ..."
rm -fr $HOME/mambaforge* $HOME/miniforge* $HOME/miniconda*
./Miniforge3-Linux-aarch64.sh -b -p $HOME/miniconda3 \
  && rm ./Miniforge3-Linux-aarch64.sh

echo "Initializing conda for 'bash'"
source $HOME/miniconda3/etc/profile.d/conda.sh
conda init bash \
  >> $HOME/Logfiles/miniforge.log 2>&1
conda config --set auto_activate_base false

echo "Creating fresh 'r-reticulate' environment"
/usr/bin/time conda create --name r-reticulate --quiet --force --yes \
  numpy \
  >> $HOME/Logfiles/miniforge.log 2>&1

echo "Cleaning up"
conda activate r-reticulate
conda clean --tarballs --index-cache --quiet --yes
conda list \
  >> $HOME/Logfiles/miniforge.log 2>&1
