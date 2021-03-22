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

# see https://github.com/edgyR/edgyR-containers/issues/31,
# https://docs.cupy.dev/en/stable/reference/environment.html#for-installation,
# and https://developer.nvidia.com/cuda-gpus
echo "Setting 'CUDA' path"
export CUDA_PATH=/usr/local/cuda-10.2
export PATH=$PATH:$CUDA_PATH/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_PATH/targets/aarch64-linux/lib/
export CPATH=$CPATH:$CUDA_PATH/targets/aarch64-linux/include/

echo "Discovering CUDA capability"
/usr/local/bin/deviceQuery \
  | grep -e "CUDA Capability Major/Minor version number:" \
  | sed 's;CUDA Capability Major/Minor version number:;;' \
  | sed 's;\s;;g' \
  | sed 's;\.;;' > /tmp/cuda_capability.txt
export CUDA_CAPABILITY=`cat /tmp/cuda_capability.txt`
export \
  CUPY_NVCC_GENERATE_CODE="arch=compute_$CUDA_CAPABILITY,code=sm_$CUDA_CAPABILITY"
echo "CUPY_NVCC_GENERATE_CODE = $CUPY_NVCC_GENERATE_CODE"
export CUPY_NUM_BUILD_JOBS=`nproc`
export CONDA_ENV_FILE=$PWD/misc/cusignal_jetson_base.yml
cat Rprofile >> ~/.Rprofile

echo "Cloning 'cusignal'"
export PROJECT_HOME=$HOME/Projects
mkdir --parents $PROJECT_HOME
pushd $PROJECT_HOME

  export CUSIGNAL_VERSION=v0.18.0
  export CUSIGNAL_HOME=$(pwd)/cusignal
  rm -fr $CUSIGNAL_HOME
  git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
  cd $CUSIGNAL_HOME
  echo "Checking out version '$CUSIGNAL_VERSION'"
  git checkout $CUSIGNAL_VERSION

  echo "Creating fresh 'r-reticulate' environment"
  echo "This takes about 18 minutes on a Jetson Xavier NX"
  source $HOME/miniconda3/etc/profile.d/conda.sh
  conda env remove --name r-reticulate --quiet --yes
  /usr/bin/time conda env create --quiet --force --file \
    "$CONDA_ENV_FILE"

  echo "Activating 'r-reticulate'"
  conda activate r-reticulate

  echo "Installing R kernel in JupyterLab"
  Rscript -e "IRkernel::installspec()"

  echo "Installing R library package 'caracas'"
  Rscript -e "install.packages('caracas', quiet = TRUE)"
  echo "Writing the R shopping list"
  conda search 'r-' | grep ^r- | sed 's/ .*$//' | sort -u > r-shopping-list.txt

  echo "Installing 'cusignal'"
  export CUPY_NUM_BUILD_JOBS=`nproc`
  /usr/bin/time ./build.sh
  echo "Copying '$CUSIGNAL_HOME/notebooks' to '$HOME/Notebooks/cuSignal'"
  mkdir --parents $HOME/Notebooks
  cp -rp $CUSIGNAL_HOME/notebooks $HOME/Notebooks/cuSignal

  echo "Installed packages"
  conda list
  conda deactivate
  popd
