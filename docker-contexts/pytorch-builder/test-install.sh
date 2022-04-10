#! /bin/bash

set -e
rm -f $SYNTH_LOGS/test-install.log
cd $SYNTH_PROJECTS

echo "Activating 'pytorch-builder' conda environment"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate pytorch-builder

pip install $PACKAGES/torch*.whl \
  >> $SYNTH_LOGS/test-install.log 2>&1
mamba list \
  >> $SYNTH_LOGS/test-install.log 2>&1
