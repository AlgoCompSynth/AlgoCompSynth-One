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
rm -f $SYNTH_LOGS/cusignal.log
cd $SYNTH_PROJECTS

echo "Cloning 'cusignal'"
export CUSIGNAL_HOME=$(pwd)/cusignal
rm -fr $CUSIGNAL_HOME
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME \
  >> $SYNTH_LOGS/cusignal.log 2>&1
cd $CUSIGNAL_HOME
echo "Checking out version v$CUSIGNAL_VERSION"
git checkout v$CUSIGNAL_VERSION \
  >> $SYNTH_LOGS/cusignal.log 2>&1

echo "Creating 'r-reticulate'"
source $HOME/miniconda3/etc/profile.d/conda.sh
/usr/bin/time conda env create -f $SYNTH_SCRIPTS/cusignal_jetson_base.yml \
  >> $SYNTH_LOGS/cusignal.log 2>&1
conda activate r-reticulate

echo "Building 'cusignal'"
/usr/bin/time ./build.sh --allgpuarch \
  >> $SYNTH_LOGS/cusignal.log 2>&1

echo "Testing 'cusignal'"

set +e
/usr/bin/time pytest -v \
  >> $SYNTH_LOGS/cusignal.log 2>&1
set -e

echo "Copying '$CUSIGNAL_HOME/notebooks' to '$SYNTH_NOTEBOOKS'"
rm -rf $SYNTH_NOTEBOOKS/cusignal-notebooks
cp -rp $CUSIGNAL_HOME/notebooks $SYNTH_NOTEBOOKS/cusignal-notebooks

echo "Cleanup"
conda clean --all --yes \
  >> $SYNTH_LOGS/cusignal.log 2>&1
rm -fr $CUSIGNAL_HOME
