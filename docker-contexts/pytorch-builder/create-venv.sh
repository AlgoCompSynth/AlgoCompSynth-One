#! /bin/bash

set -e
rm -f $LOGS/create-venv.log
cd $SOURCE_DIR

echo "Creating fresh 'pytorch-builder' conda environment"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba create --force --quiet --yes --name pytorch-builder \
  python=$PYTHON_VERSION \
  cmake \
  ninja \
  setuptools=59.5.0 \
  >> $LOGS/create-venv.log 2>&1
mamba list \
  >> $LOGS/create-venv.log 2>&1
