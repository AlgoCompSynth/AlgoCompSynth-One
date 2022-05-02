#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PATH=$PATH:/usr/local/cuda/bin

if [ `mamba list | grep torch | wc -l` -gt "0" ]
then
  echo "PyTorch already installed - exiting"
  exit
fi

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
mamba list
mamba clean --tarballs --yes

echo "Finished"
