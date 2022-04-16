#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Setting pinned packages"
cp $SYNTH_SCRIPTS/pinned $CONDA_PREFIX/conda-meta/

echo "Installing mamba dependencies"
mamba install --quiet --yes \
  libgit2 \
  r-base

echo "Installing R packages"
export PKG_CONFIG_PATH=$CONDA_PREFIX/lib/pkgconfig
/usr/bin/time $SYNTH_SCRIPTS/devtools.R

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
