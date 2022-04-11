#! /bin/bash

set -e
rm -f $SYNTH_LOGS/test-install.log
cd $SYNTH_PROJECTS

echo "Activating 'pytorch-builder' conda environment"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate pytorch-builder

echo "Installing PyTorch wheel"
pip install $PACKAGES/torch*.whl \
  >> $SYNTH_LOGS/test-install.log 2>&1

echo "Cloning 'torchaudio'"
rm -fr audio*
git clone --recurse-submodules https://github.com/pytorch/audio.git \
  >> $SYNTH_LOGS/test-install.log 2>&1
cd audio
git checkout v$TORCHAUDIO_VERSION \
  >> $SYNTH_LOGS/test-install.log 2>&1

echo "Installing 'torchaudio'"
/usr/bin/time python setup.py install \
  >> $SYNTH_LOGS/test-install.log 2>&1

echo "Cleanup"
mamba list \
  >> $SYNTH_LOGS/test-install.log 2>&1
mamba clean  --all --yes \
  >> $SYNTH_LOGS/test-install.log 2>&1
rm -fr /tmp/audio
