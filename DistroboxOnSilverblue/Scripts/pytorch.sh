#! /bin/bash

set -e

source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate $MAMBA_ENV_NAME
export PATH=$PATH:/usr/local/cuda/bin

echo "Installing PyTorch"
mamba install --quiet --yes \
  pytorch \
  pytorch-cuda=$CUDA_VERSION \
  --channel pytorch \
  --channel nvidia

echo "Cleanup"
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

echo "Finished"
