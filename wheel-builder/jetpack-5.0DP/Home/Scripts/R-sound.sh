#! /bin/bash

set -e

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is now $PATH"

echo "Installing mamba dependencies"
mamba install --quiet --yes \
  fftw

echo "Installing R packages"
export PKG_CPPFLAGS="-DHAVE_WORKING_LOG1P"
export PKG_CONFIG_PATH=$CONDA_PREFIX/lib/pkgconfig
/usr/bin/time $SYNTH_SCRIPTS/sound.R

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
