#! /bin/bash

set -e
rm -f $LOGS/test-install.log
cd $SOURCE_DIR

echo "Activating 'pytorch-builder' conda environment"
source $HOME/mambaforge/etc/profile.d/conda.sh
conda activate pytorch-builder

pip install $PACKAGES/torch*.whl \
  >> $LOGS/test-install.log 2>&1
conda list \
  >> $LOGS/test-install.log 2>&1
