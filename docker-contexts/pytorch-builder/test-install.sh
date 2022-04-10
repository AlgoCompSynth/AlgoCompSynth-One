#! /bin/bash

set -e
rm -f $LOGS/test-install.log
cd $SOURCE_DIR

echo "Activating 'pytorch-builder' conda environment"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate pytorch-builder

pip install $PACKAGES/torch*.whl \
  >> $LOGS/test-install.log 2>&1
mamba list \
  >> $LOGS/test-install.log 2>&1
