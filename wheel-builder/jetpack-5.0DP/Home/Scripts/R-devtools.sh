#! /bin/bash

set -e

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is now $PATH"

echo "Setting pinned 'r-base' version"
echo "r-base ==$R_BASE_VERSION" > $CONDA_PREFIX/conda-meta/pinned

echo "Installing mamba dependencies"
mamba install --quiet --yes \
  libgit2 \
  pandoc \
  r-base

echo "Installing R packages"
export PKG_CONFIG_PATH=$CONDA_PREFIX/lib/pkgconfig
/usr/bin/time $SYNTH_SCRIPTS/devtools.R

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
