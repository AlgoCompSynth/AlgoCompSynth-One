#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is now $PATH"

echo "Installing CuPy - this takes a long time!"
/usr/bin/time pip install cupy>=9.0.0

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
