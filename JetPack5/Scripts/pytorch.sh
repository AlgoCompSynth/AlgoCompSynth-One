#! /bin/bash

set -e

source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PATH=$PATH:/usr/local/cuda/bin

echo "Installing Cython"
mamba install --quiet --yes \
  Cython

pushd $SYNTH_WHEELS
rm -f $PYTORCH_WHEEL_FILE
echo "Downloading PyTorch wheel"
wget --verbose $PYTORCH_WHEEL_URL --output-document=$PYTORCH_WHEEL_FILE
popd

echo "Installing PyTorch"
pip install $SYNTH_WHEELS/$PYTORCH_WHEEL_FILE

echo "Cleanup"
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

mamba list

echo "Finished"
