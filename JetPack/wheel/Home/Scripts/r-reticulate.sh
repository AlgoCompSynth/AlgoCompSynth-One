#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh

echo "Creating fresh r-reticulate virtual environment"
sed "s/PYTHON_VERSION/$PYTHON_VERSION/" $SYNTH_SCRIPTS/r-reticulate.template > $SYNTH_SCRIPTS/r-reticulate.yml
/usr/bin/time mamba env create --force --file $SYNTH_SCRIPTS/r-reticulate.yml

echo "Activating r-reticulate"
mamba activate r-reticulate

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
