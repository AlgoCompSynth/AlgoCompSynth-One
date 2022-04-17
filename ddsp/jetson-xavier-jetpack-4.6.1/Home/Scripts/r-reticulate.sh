#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh

echo "Creating fresh r-reticulate virtual environment"
/usr/bin/time mamba env create --force --file $SYNTH_ENV_FILE
mamba activate r-reticulate

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
