#! /bin/bash

set -e

echo "Activating r-reticulate"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Installing r-base and r-recommended"
mamba install --quiet --yes \
  r-base \
  r-recommended

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
