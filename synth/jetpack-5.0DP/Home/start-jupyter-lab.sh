#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate
# https://forums.developer.nvidia.com/t/error-importerror-usr-lib-aarch64-linux-gnu-libgomp-so-1-cannot-allocate-memory-in-static-tls-block-i-looked-through-available-threads-already/166494/3
export LD_PRELOAD=/usr/lib/aarch64-linux-gnu/libgomp.so.1

echo "Generating Jupyter configuration file"
jupyter notebook --generate-config
echo "Enter the same strong password twice"
jupyter server password
echo "If running remotely, browse to port 8888 on this host instead of 'localhost'"
SHELL=/bin/bash jupyter lab --no-browser --ip=0.0.0.0
