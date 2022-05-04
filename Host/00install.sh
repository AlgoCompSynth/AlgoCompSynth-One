#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
export SYNTH_HOME=$PWD
source $SYNTH_HOME/jetpack-envars.sh

echo ""
echo "Creating virtual desktop"
mkdir --parents \
  $SYNTH_LOGS \
  $SYNTH_PROJECTS \
  $SYNTH_NOTEBOOKS \
  $SYNTH_WHEELS \
  $SYNTH_PACKAGES

echo "Installing command line conveniences"
$SYNTH_SCRIPTS/command-line.sh > $SYNTH_LOGS/command-line.log 2>&1

echo "Installing Mambaforge if necessary"
if [ ! -d $HOME/mambaforge ]
then
  /usr/bin/time $SYNTH_SCRIPTS/mambaforge.sh > $SYNTH_LOGS/mambaforge.log 2>&1
fi

echo "Enabling conda and mamba commands"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh

echo "Creating r-reticulate mamba environment if necessary"
if [ ! `mamba env list | grep "r-reticulate" | wc -l` -gt "0" ]
then
  /usr/bin/time $SYNTH_SCRIPTS/r-reticulate.sh > $SYNTH_LOGS/r-reticulate.log 2>&1
fi

echo "Activating r-reticulate"
mamba activate r-reticulate

echo "Installing PyTorch if necessary"
if [ ! `mamba list | grep "torch" | wc -l` -gt "0" ]
then
  /usr/bin/time $SYNTH_SCRIPTS/pytorch.sh > $SYNTH_LOGS/pytorch.log 2>&1
fi
$SYNTH_SCRIPTS/test-pytorch.sh 2>&1 | tee $SYNTH_LOGS/test-pytorch.log

echo "Installing torchaudio if necessary"
if [ ! `mamba list | grep "torchaudio" | wc -l` -gt "0" ]
then
  /usr/bin/time $SYNTH_SCRIPTS/torchaudio.sh > $SYNTH_LOGS/torchaudio.log 2>&1
fi
$SYNTH_SCRIPTS/test-torchaudio.sh 2>&1 | tee $SYNTH_LOGS/test-torchaudio.log

echo "Installing cusignal if necessary"
echo "This may take a long time if it needs to build CuPy from source!"
export CUSIGNAL_TEST="0" # Don't test by default
if [ ! `mamba list | grep "cusignal" | wc -l` -gt "0" ]
then
  /usr/bin/time $SYNTH_SCRIPTS/cusignal.sh > $SYNTH_LOGS/cusignal.log 2>&1
fi

echo "Finished!"
