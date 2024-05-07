#! /bin/bash

set -e

echo "Generating Jupyter configuration file"
jupyter server --generate-config

echo "Enter the same strong password twice"
jupyter server password

echo "Entering Projects directory"
mkdir --parents $HOME/Projects
cd $HOME/Projects

echo "Starting JupyterLab server - browse to localhost:8888"
SHELL=/bin/bash jupyter lab --no-browser --ip=0.0.0.0
