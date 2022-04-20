#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Enabling R kernel"
Rscript -e "IRkernel::installspec()"

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
