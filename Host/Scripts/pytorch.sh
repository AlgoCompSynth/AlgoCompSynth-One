#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PATH=$PATH:/usr/local/cuda/bin

echo "Installing Cython"
mamba install --quiet --yes \
  Cython

pushd $SYNTH_WHEELS
if [ ! -e $PYTORCH_WHEEL_FILE ]
then
  echo "Downloading PyTorch wheel"
  wget --quiet $PYTORCH_WHEEL_URL --output-document=$PYTORCH_WHEEL_FILE
fi
popd

echo "Installing PyTorch"
pip install $SYNTH_WHEELS/$PYTORCH_WHEEL_FILE

echo "Cleanup"
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

mamba list

echo "Finished"
