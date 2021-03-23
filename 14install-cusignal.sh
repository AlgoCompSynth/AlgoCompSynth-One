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

export CUSIGNAL_VERSION=v0.18.0
export CUPY_NUM_BUILD_JOBS=`nproc`
export CUSIGNAL_JETSON_BASE=$PWD/misc/cusignal_jetson_base.yml
export INSTALLED_PACKAGES=$PWD/installed-packages.txt
export AVAILABLE_R_PACKAGES=$PWD/available-R-packages.txt
cat misc/Rprofile >> $HOME/.Rprofile

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
    $CUSIGNAL_JETSON_BASE
  
  echo "Activating 'r-reticulate'"
  conda activate r-reticulate
  
  echo "Installing 'cusignal'"
  export PATH=$PATH:/usr/local/cuda-10.2/bin
  /usr/bin/time ./build.sh
  echo "Copying '$CUSIGNAL_HOME/notebooks' to '$HOME/Notebooks/cusignal-notebooks'"
  mkdir --parents $HOME/Notebooks
  cp -rp $CUSIGNAL_HOME/notebooks $HOME/Notebooks/cusignal-notebooks

  echo "Installing JupyterLab and R base"
  conda install --quiet --yes \
    jupyterlab \
    pandas \
    sympy \
    r-base \
    r-data.table \
    r-renv \
    r-irkernel \
    r-reticulate

  echo "Installing R kernel in JupyterLab"
  Rscript -e "IRkernel::installspec()"

  echo "Installing R library package 'caracas'"
  Rscript -e "install.packages('caracas', quiet = TRUE)"
  echo "Available R packages"
  conda search 'r-' | grep ^r- | sed 's/ .*$//' | sort -u | tee $AVAILABLE_R_PACKAGES
  
  echo "Installed packages:"
  conda list | tee $INSTALLED_PACKAGES

  popd
