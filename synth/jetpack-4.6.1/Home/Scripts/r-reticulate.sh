#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh

echo "Creating fresh r-reticulate virtual environment"
sed -i.bak "s/PYTHON_VERSION/$PYTHON_VERSION/" $SYNTH_SCRIPTS/r-reticulate.yml
/usr/bin/time mamba env create --force --file $SYNTH_SCRIPTS/r-reticulate.yml

echo "Cleanup"
mamba activate r-reticulate
mamba list
mamba clean --tarballs --yes

echo "Finished"
