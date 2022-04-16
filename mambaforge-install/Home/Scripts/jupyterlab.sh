#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Installing mamba dependencies"
mamba install --quiet --yes \
  jupyterlab

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
