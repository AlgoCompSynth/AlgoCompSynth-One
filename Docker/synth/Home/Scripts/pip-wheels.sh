#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh

echo "Activating r-reticulate"
mamba activate r-reticulate

echo "Installing CuPy, cuSignal and torchaudio from wheels"
pip install $SYNTH_WHEELS/*.whl

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
