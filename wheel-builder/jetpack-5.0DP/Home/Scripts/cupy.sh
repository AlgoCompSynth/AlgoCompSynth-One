#! /bin/bash

set -e

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is now $PATH"

echo "Installing cupy - this takes a while"
/usr/bin/time pip install cupy>=9.0.0

echo "pip built a wheel for cupy"
echo "Copying it to $SYNTH_WHEELS/"
cp `find $HOME -name 'cupy-*.whl'` $SYNTH_WHEELS/

echo "Cleanup"
pip list

echo "Finished"
