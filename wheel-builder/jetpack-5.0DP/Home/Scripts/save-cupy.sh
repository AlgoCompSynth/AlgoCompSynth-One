#! /bin/bash

set -e

echo "The cupy pip install made a wheel"
echo "Finding it and saving it to $SYNTH_WHEELS"
cp `find $HOME -name 'cupy-*.whl'` $SYNTH_WHEELS/
ls -Altr $SYNTH_WHEELS/

echo "Finished"
