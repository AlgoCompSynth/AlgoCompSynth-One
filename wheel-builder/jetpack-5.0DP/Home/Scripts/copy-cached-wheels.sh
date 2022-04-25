#! /bin/bash

set -e

echo "Saving cached wheels"
for wheel in `find $HOME/.cache/pip/wheels -name "*.whl"
do
  echo $wheel
  cp $wheel $SYNTH_WHEELS/
done

echo "Finished"
