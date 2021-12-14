#! /bin/bash

set -e
rm -f $LOGS/create-venv.log
cd $SOURCE_DIR

echo "Creating fresh 'gnash' conda environment"
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba create --force --quiet --yes --name gnash \
  python=3.9 \
  numpy=1.20.1 \
  >> $LOGS/create-venv.log 2>&1
mamba list \
  >> $LOGS/create-venv.log 2>&1
