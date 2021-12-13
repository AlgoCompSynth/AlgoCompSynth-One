#! /bin/bash

set -e
rm -f $LOGS/create-venv.log
cd $SOURCE_DIR

echo "Creating fresh 'gnash' conda environment"
source $HOME/miniconda3/etc/profile.d/conda.sh
conda create --force --quiet --yes --name gnash \
  python=3.9 \
  >> $LOGS/create-venv.log 2>&1
conda clean --all \
  >> $LOGS/create-venv.log 2>&1
conda list \
  >> $LOGS/create-venv.log 2>&1
