#! /bin/bash

set -e

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is now $PATH"

echo "Downloading PyTorch wheel"
pushd $SYNTH_WHEELS
rm -f $PYTORCH_WHEEL_FILE
wget --quiet $PYTORCH_WHEEL_URL --output-document=$PYTORCH_WHEEL_FILE
popd

echo "Installing PyTorch"
pip install $SYNTH_WHEELS/$PYTORCH_WHEEL_FILE

echo "Cleanup"
pip list

echo "Finished"
