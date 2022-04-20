#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PATH=$PATH:/usr/local/cuda/bin

echo "Testing PyTorch execution, GPU availability, and torchaudio import"
python $SYNTH_SCRIPTS/r-reticulate-test.py
