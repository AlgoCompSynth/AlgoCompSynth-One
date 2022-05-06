#! /bin/bash

set -e

echo "Activating r-reticulate"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Installing r-base"
mamba install --quiet --yes \
  r-base

echo "Installing the recommended packages from source"
$SYNTH_SCRIPTS/recommended.R > $SYNTH_LOGS/recommended.log 2>&1

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
