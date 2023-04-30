#! /bin/bash

set -e

echo "Activating r-reticulate"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Installing r-base"
/usr/bin/time mamba install --quiet --yes \
  r-base

echo "Installing the recommended packages from source"
/usr/bin/time $SYNTH_SCRIPTS/recommended.R > $SYNTH_LOGS/recommended.log 2>&1

echo "Cleanup"
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

mamba list

echo "Finished"
