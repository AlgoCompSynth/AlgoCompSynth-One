#! /bin/bash

set -e

echo "Activating JupyterLab environment"
source $HOME/mambaforge/etc/profile.d/conda.sh
conda activate JupyterLab

echo "Generating Jupyter configuration file"
jupyter server --generate-config

echo "Enter the same strong password twice"
jupyter server password

echo "Entering Projects directory"
mkdir --parents $HOME/Projects
cd $HOME/Projects

echo "Starting JupyterLab server - browse to localhost:8888"
sleep 10
SHELL=/bin/bash jupyter lab --no-browser --ip=127.0.0.1
