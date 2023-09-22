#! /bin/bash

set -e

source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate $MAMBA_ENV_NAME
export PATH=$PATH:/usr/local/cuda/bin

echo "Installing cupy"
mamba install --quiet --yes \
  cupy \
  --channel rapidsai \
  --channel conda-forge \
  --channel nvidia

echo "Cleanup"
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

echo "Finished"
