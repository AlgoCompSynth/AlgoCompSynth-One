#! /bin/bash

set -e
rm -f $LOGS/create-venv.log
cd $SOURCE_DIR

echo "Creating fresh 'pytorch-builder' conda environment"
source $HOME/mambaforge/etc/profile.d/conda.sh
conda create --force --quiet --yes --name pytorch-builder \
  python=3.9 \
  numpy=1.20.1 \
  >> $LOGS/create-venv.log 2>&1
conda list \
  >> $LOGS/create-venv.log 2>&1
