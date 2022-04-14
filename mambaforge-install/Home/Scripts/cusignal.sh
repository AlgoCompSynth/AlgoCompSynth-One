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

cd $SYNTH_PROJECTS

echo "Cloning 'cusignal'"
export CUSIGNAL_HOME=$(pwd)/cusignal
rm -fr $CUSIGNAL_HOME
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
cd $CUSIGNAL_HOME
echo "Checking out version v$CUSIGNAL_VERSION"
git checkout v$CUSIGNAL_VERSION

echo "Creating fresh r-reticulate virtual environment"
/usr/bin/time mamba env create --force --file $SYNTH_ENV_FILE
mamba activate r-reticulate

echo "Building 'cusignal'"
/usr/bin/time ./build.sh --allgpuarch

if [ $CUSIGNAL_TEST -gt "0" ]
then
  set +e
  echo "Testing 'cusignal'"
  /usr/bin/time pytest -v
  set -e
fi

echo "Copying '$CUSIGNAL_HOME/notebooks' to '$SYNTH_NOTEBOOKS'"
rm -rf $SYNTH_NOTEBOOKS/cusignal-notebooks
cp -rp $CUSIGNAL_HOME/notebooks $SYNTH_NOTEBOOKS/cusignal-notebooks

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
