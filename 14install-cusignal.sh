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
export LOGFILES=$HOME/logfiles
rm -f $LOGFILES/cusignal.log

export CUSIGNAL_VERSION=v0.18.0
export CUPY_NUM_BUILD_JOBS=`nproc`
export CUSIGNAL_JETSON_BASE=$PWD/misc/cusignal_jetson_base.yml

echo "Cloning 'cusignal'"
mkdir --parents $HOME/Projects
pushd $HOME/Projects

  export CUSIGNAL_HOME=$(pwd)/cusignal
  rm -fr $CUSIGNAL_HOME
  git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
  cd $CUSIGNAL_HOME
  echo "Checking out version '$CUSIGNAL_VERSION'"
  git checkout $CUSIGNAL_VERSION
  
  echo "Creating fresh 'r-reticulate' environment"
  echo "This takes about 45 minutes on a Jetson Xavier NX"
  source $HOME/miniconda3/etc/profile.d/conda.sh
  /usr/bin/time conda env create --quiet --force --file \
    $CUSIGNAL_JETSON_BASE \
    >> $LOGFILES/cusignal.log 2>&1
  
  echo "Activating 'r-reticulate'"
  conda activate r-reticulate
  
    echo "Installing 'cusignal'"
    export PATH=$PATH:/usr/local/cuda-10.2/bin
    /usr/bin/time ./build.sh \
    >> $LOGFILES/cusignal.log 2>&1
    echo "Copying '$CUSIGNAL_HOME/notebooks' to '$HOME/Notebooks/cusignal-notebooks'"
    mkdir --parents $HOME/Notebooks
    cp -rp $CUSIGNAL_HOME/notebooks $HOME/Notebooks/cusignal-notebooks
  
    echo "Installing JupyterLab"
    conda install --quiet --yes \
      jupyterlab \
      pandas \
      sympy \
      >> $LOGFILES/cusignal.log 2>&1
  
    echo "Installed packages:"
    conda list \
      >> $LOGFILES/cusignal.log 2>&1

    echo "Enabling R kernel"
    Rscript -e "IRkernel::installspec()"
  
    echo "deactivating 'r-reticulate'"
    conda deactivate
  
  popd
