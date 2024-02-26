#! /bin/bash

set -e

echo "Activating $MAMBA_ENV_NAME"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate $MAMBA_ENV_NAME

echo "Installing torchaudiol"
mamba install --quiet --yes \
  torchaudio \
  --channel pytorch \
  --channel nvidia

echo "Cleanup"
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

echo "Finished"
