#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is not $PATH"

echo "Installing Cython with mamba"
mamba install --quiet --yes \
  Cython

echo "Downloading PyTorch wheel"
pushd /tmp
rm -f $PYTORCH_WHEEL_FILE
wget --quiet $PYTORCH_WHEEL_URL --output-document=$PYTORCH_WHEEL_FILE
popd

echo "Installing PyTorch"
pip install /tmp/$PYTORCH_WHEEL_FILE

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
