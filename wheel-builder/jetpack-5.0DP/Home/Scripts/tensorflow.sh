#! /bin/bash

set -e

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is now $PATH"

echo "Downloading TensorFlow wheel"
pushd $SYNTH_WHEELS
wget --quiet $TENSORFLOW_WHEEL_URL --output-document $TENSORFLOW_WHEEL_FILE
popd

echo "Installing TensorFlow"
/usr/bin/time pip install $SYNTH_WHEELS/$TENSORFLOW_WHEEL_FILE

echo "pip built a wheel for grpcio"
echo "pip built a wheel for termcolor"
echo "Copying them to $SYNTH_WHEELS/"
cp `find $HOME -name 'grpcio-*.whl'` $SYNTH_WHEELS/
cp `find $HOME -name 'termcolor-*.whl'` $SYNTH_WHEELS/

echo "Cleanup"
pip list

echo "Finished"
