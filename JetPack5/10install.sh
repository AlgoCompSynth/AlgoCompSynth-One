#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
export SYNTH_HOME=$PWD
source $SYNTH_HOME/jetpack-envars.sh
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

echo "Installing PyTorch if necessary"
if [ `mamba list | grep "torch  " | wc -l` -le "0" ]
then
  echo "..Installing PyTorch from NVIDIA wheel"
  /usr/bin/time $SYNTH_SCRIPTS/pytorch.sh > $SYNTH_LOGS/pytorch.log 2>&1
fi
$SYNTH_SCRIPTS/test-pytorch.sh 2>&1 | tee $SYNTH_LOGS/test-pytorch.log

echo "Installing torchaudio if necessary"
if [ `mamba list | grep "torchaudio" | wc -l` -le "0" ]
then
  echo "..Installing torchaudio"
  /usr/bin/time $SYNTH_SCRIPTS/torchaudio.sh > $SYNTH_LOGS/torchaudio.log 2>&1
fi
$SYNTH_SCRIPTS/test-torchaudio.sh 2>&1 | tee $SYNTH_LOGS/test-torchaudio.log

echo "Installing torchvision if necessary"
if [ `mamba list | grep "torchvision" | wc -l` -le "0" ]
then
  echo "..Installing torchvision"
  /usr/bin/time $SYNTH_SCRIPTS/torchvision.sh > $SYNTH_LOGS/torchvision.log 2>&1
fi
$SYNTH_SCRIPTS/test-torchvision.sh 2>&1 | tee $SYNTH_LOGS/test-torchvision.log

echo "Installing 'rTorch' R package"
/usr/bin/time $SYNTH_SCRIPTS/rTorch.sh > $SYNTH_LOGS/rTorch.log 2>&1

echo "Installing CuPy if necessary"
if [ `mamba list | grep "cupy" | wc -l` -le "0" ]
then
  echo "..Installing CuPy"
  echo "..This can take a long time if the wheel isn't in the pip cache!"
  /usr/bin/time $SYNTH_SCRIPTS/cupy.sh > $SYNTH_LOGS/cupy.log 2>&1
fi

echo "Installing cusignal if necessary"
export CUSIGNAL_TEST="0" # Don't test by default
if [ `mamba list | grep "cusignal" | wc -l` -le "0" ]
then
  echo "..Installing cusignal"
  /usr/bin/time $SYNTH_SCRIPTS/cusignal.sh > $SYNTH_LOGS/cusignal.log 2>&1
fi

echo ""
echo "Python packages"
mamba list --name r-reticulate

echo ""
echo "R packages"
Rscript -e 'subset(installed.packages(), select = c("Version", "Built"))'

echo ""
echo "Finished!"
