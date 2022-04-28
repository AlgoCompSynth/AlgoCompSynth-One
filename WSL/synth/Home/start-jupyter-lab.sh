#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Generating Jupyter configuration file"
jupyter notebook --generate-config
echo "Enter the same strong password twice"
jupyter notebook password
echo "If running remotely, browse to port 8888 on this host instead of 'localhost'"
SHELL=/bin/bash jupyter lab --no-browser --ip=0.0.0.0
