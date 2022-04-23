#! /bin/bash

set -e

source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin

echo "Testing PyTorch execution and GPU availability"
python $SYNTH_SCRIPTS/test-pytorch.py
