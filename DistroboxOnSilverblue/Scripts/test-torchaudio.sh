#! /bin/bash

set -e

source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate $MAMBA_ENV_NAME
export PATH=$PATH:/usr/local/cuda/bin

echo "Testing torchaudio import"
python $SYNTH_SCRIPTS/test-torchaudio.py
