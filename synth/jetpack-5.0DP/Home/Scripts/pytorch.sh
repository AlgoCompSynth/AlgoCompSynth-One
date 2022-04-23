#! /bin/bash

set -e

source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin

echo "Installing Cython"
pip install Cython

echo "Downloading PyTorch wheel"
pushd /tmp
rm -f $PYTORCH_WHEEL_FILE
wget --quiet $PYTORCH_WHEEL_URL --output-document=$PYTORCH_WHEEL_FILE
popd

echo "Installing PyTorch"
pip install /tmp/$PYTORCH_WHEEL_FILE

echo "Cleanup"
pip list

echo "Finished"
