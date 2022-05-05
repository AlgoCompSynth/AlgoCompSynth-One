#! /bin/bash

set -e

echo "Activating r-reticulate"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PATH=$PATH:/usr/local/cuda/bin

echo "Installing CuPy - this can take some time if it's not cached!"
pip install --verbose "cupy>=9.0.0"

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
