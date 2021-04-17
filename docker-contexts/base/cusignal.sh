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
rm -f $HOME/Logfiles/cusignal.log
cd $HOME/Downloads/Installers

echo "Cloning 'cusignal'"
export CUSIGNAL_VERSION=v0.18.0
export CUSIGNAL_HOME=$(pwd)/cusignal
rm -fr $CUSIGNAL_HOME
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME \
  >> $HOME/Logfiles/cusignal.log 2>&1
cd $CUSIGNAL_HOME
echo "Checking out version '$CUSIGNAL_VERSION'"
git checkout $CUSIGNAL_VERSION \
  >> $HOME/Logfiles/cusignal.log 2>&1

echo "Creating 'r-reticulate' conda environment"
source $HOME/miniconda3/etc/profile.d/conda.sh

# for compatibility with the R / reticulate conventions
# we change the name of the conda environment
sed --in-place=.bak --expression='s/cusignal-dev/r-reticulate/' \
  conda/environments/cusignal_jetson_base.yml
/usr/bin/time conda env create \
  --file conda/environments/cusignal_jetson_base.yml \
  --quiet \
  >> $HOME/Logfiles/cusignal.log 2>&1
conda activate r-reticulate

echo "Building 'cusignal'"
/usr/bin/time ./build.sh --allgpuarch \
  >> $HOME/Logfiles/cusignal.log 2>&1

echo "Installing 'JupyterLab'"
/usr/bin/time conda install --quiet --yes jupyterlab \
  >> $HOME/Logfiles/cusignal.log 2>&1

echo "Copying '$CUSIGNAL_HOME/notebooks' to '$HOME/Notebooks/cusignal-notebooks'"
mkdir --parents $HOME/Notebooks/
cp -rp $CUSIGNAL_HOME/notebooks $HOME/Notebooks/cusignal-notebooks

echo "Cleaning up"
conda clean --tarballs --index-cache --quiet --yes
conda list \
  >> $HOME/Logfiles/cusignal.log 2>&1
rm -fr $CUSIGNAL_HOME
