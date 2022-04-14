#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Testing torchaudio import"
python $SYNTH_SCRIPTS/check_torchaudio.py
