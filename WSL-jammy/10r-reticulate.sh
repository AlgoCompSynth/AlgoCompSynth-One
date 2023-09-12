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

echo "Installing PyTorch and torchaudio if necessary"
if [ `mamba env list | grep "torch" | wc -l` -le "0" ]
then
  echo "..Installing PyTorch and torchaudio"

  # We have to do this in two steps to make sure both pytorch and
  # torchaudio come from the 'pytorch' channel! If we don't,
  # tests fail!
  mamba install --quiet --yes \
    pytorch \
    pytorch-cuda=$CUDA_VERSION \
    --channel pytorch \
    --channel nvidia
    $SYNTH_SCRIPTS/test-pytorch.sh 2>&1 | tee $SYNTH_LOGS/test-pytorch.log

  mamba install --quiet --yes \
    torchaudio \
    --channel pytorch \
    --channel nvidia
    $SYNTH_SCRIPTS/test-torchaudio.sh 2>&1 | tee $SYNTH_LOGS/test-torchaudio.log
fi

echo "Installing 'rTorch' R package"
/usr/bin/time $SYNTH_SCRIPTS/rTorch.sh > $SYNTH_LOGS/rTorch.log 2>&1

echo "Installing cusignal if necessary"
export CUSIGNAL_TEST="0" # Don't test by default
if [ `mamba list | grep "cusignal" | wc -l` -le "0" ]
then
  echo "..Installing cusignal"
  mamba install --quiet --yes \
    cusignal=$CUSIGNAL_VERSION \
    --channel rapidsai \
    --channel conda-forge \
    --channel nvidia
  echo "..Installing cusignal notebooks"
  $SYNTH_SCRIPTS/cusignal-notebooks.sh > $SYNTH_LOGS/cusignal-notebooks.log 2>&1
fi

echo ""
echo "Python packages"
mamba list --name r-reticulate

echo ""
echo "R packages"
Rscript -e 'subset(installed.packages(), select = c("Version", "Built"))'

echo ""
echo "Finished!"
