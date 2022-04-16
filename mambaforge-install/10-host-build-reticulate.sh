#! /bin/bash

set -e

echo "Getting environment variables from '00envars'"
source 00envars

echo "Creating fresh $SYNTH_HOME"
rm -fr $SYNTH_HOME
cp -rp Home $SYNTH_HOME

echo "Running 'build-r-reticulate.sh'"
./build-r-reticulate.sh
