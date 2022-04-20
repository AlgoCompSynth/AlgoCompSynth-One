#! /bin/bash

set -e
rm -f $SYNTH_LOGS/create-venv.log
cd $SYNTH_PROJECTS

echo "Creating fresh 'pytorch-builder' conda environment"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba create --force --quiet --yes --name pytorch-builder \
  python=$PYTHON_VERSION \
  cmake \
  ninja \
  setuptools=59.5.0 \
  >> $SYNTH_LOGS/create-venv.log 2>&1
mamba list \
  >> $SYNTH_LOGS/create-venv.log 2>&1
