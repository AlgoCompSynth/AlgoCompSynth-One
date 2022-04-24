#! /bin/bash

set -e

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is now $PATH"

echo "Testing PyTorch execution and GPU availability"
python $SYNTH_SCRIPTS/test-pytorch.py
