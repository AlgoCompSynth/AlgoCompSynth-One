#! /bin/bash

set -e

echo "Activating $MAMBA_ENV_NAME"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate $MAMBA_ENV_NAME
export PATH=$PATH:/usr/local/cuda/bin

echo "Installing CuPy - this can take some time if it's not cached!"
/usr/bin/time pip install --use-pep517 --verbose cupy

echo "Cleanup"
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

echo "Finished"
