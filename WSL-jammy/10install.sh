#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
export SYNTH_HOME=$PWD
source $SYNTH_HOME/wsl-jammy-envars.sh
export MAKE="make $MAKEFLAGS"

echo ""
echo "Creating virtual desktop"
mkdir --parents \
  $SYNTH_LOGS \
  $SYNTH_PROJECTS \
  $SYNTH_NOTEBOOKS \
  $SYNTH_WHEELS

echo "Defining Mambaforge home"
source $SYNTH_HOME/mamba-init.sh
echo "MAMBAFORGE_HOME: $MAMBAFORGE_HOME"

echo "Enabling conda and mamba commands"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh

echo "Creating r-reticulate mamba environment if necessary"
if [ `mamba env list | grep "r-reticulate" | wc -l` -le "0" ]
then
  echo "..Creating r-reticulate"
  /usr/bin/time $SYNTH_SCRIPTS/r-reticulate.sh > $SYNTH_LOGS/r-reticulate.log 2>&1
fi

echo "Activating r-reticulate"
mamba activate r-reticulate

echo "Installing PyTorch, torchvision and torchaudio if necessary"
if [ `mamba env list | grep "torch" | wc -l` -le "0" ]
then
  echo "..Installing PyTorch, torchvision and torchaudio"
  mamba install --quiet --yes \
    pytorch \
    torchvision \
    torchaudio \
    pytorch-cuda=11.8 \
    --channel pytorch \
    --channel nvidia
fi
$SYNTH_SCRIPTS/test-pytorch.sh 2>&1 | tee $SYNTH_LOGS/test-pytorch.log
$SYNTH_SCRIPTS/test-torchaudio.sh 2>&1 | tee $SYNTH_LOGS/test-torchaudio.log

echo "Installing 'rTorch' R package"
/usr/bin/time $SYNTH_SCRIPTS/rTorch.sh > $SYNTH_LOGS/rTorch.log 2>&1

echo "Installing cusignal if necessary"
export CUSIGNAL_TEST="0" # Don't test by default
if [ `mamba list | grep "cusignal" | wc -l` -le "0" ]
then
  echo "..Installing cusignal"
  mamba install --quiet --yes \
    cusignal \
    --channel rapidsai \
    --channel conda-forge \
    --channel nvidia
fi

mamba list --name r-reticulate
echo "Finished!"
