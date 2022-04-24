#! /bin/bash

set -e

echo "We don't have any tests for TensorFlow"
echo "So we just download it"
echo "Downloading TensorFlow wheel"
pushd $SYNTH_WHEELS
wget --quiet $TENSORFLOW_WHEEL_URL --output-document $TENSORFLOW_WHEEL_FILE
popd

echo "Finished"
