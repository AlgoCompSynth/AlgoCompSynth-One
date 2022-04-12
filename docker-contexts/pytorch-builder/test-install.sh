#! /bin/bash

set -e
rm -f $SYNTH_LOGS/test-install.log
cd $SYNTH_PROJECTS

echo "Creating 'pytorch-test' conda environment"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
# pinning cmake version because of https://github.com/pytorch/pytorch/issues/74985
mamba create --force --quiet --yes --name pytorch-test \
  python=$PYTHON_VERSION \
  cmake=3.22 \
  ninja \
  numpy \
  jupyterlab \
  r-base \
  >> $SYNTH_LOGS/test-install.log 2>&1

echo "Activating 'pytorch-test' conda environment"
mamba activate pytorch-test

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

echo "Testing execution and GPU availability"
python $SYNTH_SCRIPTS/check_gpu.py \
  >> $SYNTH_LOGS/test-install.log 2>&1

echo "Cleanup"
mamba list \
  >> $SYNTH_LOGS/test-install.log 2>&1
mamba clean  --tarballs --yes \
  >> $SYNTH_LOGS/test-install.log 2>&1
