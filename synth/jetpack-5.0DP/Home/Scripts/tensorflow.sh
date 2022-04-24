#! /bin/bash

set -e

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is now $PATH"

echo "Installing TensorFlow"
/usr/bin/time pip install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v50 tensorflow

echo "Cleanup"
pip list

echo "Finished"
