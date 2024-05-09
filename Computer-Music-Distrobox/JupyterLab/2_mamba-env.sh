#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh

echo "PATH: $PATH"

echo "Creating JupyterLab virtual environment"
/usr/bin/time conda env create --yes --file mamba-env.yml > ../Logs/2_mamba-env.log 2>&1

echo "Finished"
