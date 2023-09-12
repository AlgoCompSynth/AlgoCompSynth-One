#! /bin/bash

set -e

echo "Locating mambaforge"
source ./mamba-init.sh

echo "Activating r-reticulate"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Generating Jupyter configuration file"
jupyter server --generate-config

echo "Enter the same strong password twice"
jupyter server password

echo "Starting JupyterLab server - browse to localhost:8888"
SHELL=/bin/bash jupyter lab --no-browser --ip=0.0.0.0
