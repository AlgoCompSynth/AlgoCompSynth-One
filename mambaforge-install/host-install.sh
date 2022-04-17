#! /bin/bash

set -e

echo "Getting environment variables from '00envars'"
source 00envars

echo "Creating fresh $SYNTH_HOME"
rm -fr $SYNTH_HOME
mkdir --parents \
  $SYNTH_SCRIPTS \
  $SYNTH_LOGS \
  $SYNTH_NOTEBOOKS \
  $SYNTH_PROJECTS

echo "Installing Linux dependencies"
cp Home/Scripts/linux-dependencies.sh $SYNTH_SCRIPTS/
$SYNTH_SCRIPTS/linux-dependencies.sh > $SYNTH_LOGS/linux-dependencies.log 2>&1

echo "Installing Mambaforge if needed"
cp Home/Scripts/mambaforge.sh $SYNTH_SCRIPTS/
$SYNTH_SCRIPTS/mambaforge.sh > $SYNTH_LOGS/mambaforge.log 2>&1

echo "Installing cusignal in fresh mamba environment 'r-reticulate'"
cp Home/Scripts/cusignal*.sh $SYNTH_SCRIPTS/
/usr/bin/time $SYNTH_SCRIPTS/cusignal.sh > $SYNTH_LOGS/cusignal.log 2>&1

echo "Installing PyTorch"
cp Home/Scripts/*pytorch* $SYNTH_SCRIPTS/
/usr/bin/time $SYNTH_SCRIPTS/pytorch.sh > $SYNTH_LOGS/pytorch.log 2>&1
$SYNTH_SCRIPTS/test-pytorch.sh

echo "Installing torchaudio"
cp Home/Scripts/*torchaudio* $SYNTH_SCRIPTS/
/usr/bin/time $SYNTH_SCRIPTS/torchaudio.sh > $SYNTH_LOGS/torchaudio.log 2>&1
$SYNTH_SCRIPTS/test-torchaudio.sh

echo "Installing R developer tools"
cp Home/Scripts/*devtools* $SYNTH_SCRIPTS/
/usr/bin/time $SYNTH_SCRIPTS/R-devtools.sh > $SYNTH_LOGS/R-devtools.log 2>&1

echo "Installing R sound packages"
cp Home/Scripts/*sound* $SYNTH_SCRIPTS/
/usr/bin/time $SYNTH_SCRIPTS/R-sound.sh > $SYNTH_LOGS/R-sound.log 2>&1

echo "Installing JupyterLab"
cp Home/Scripts/jupyterlab.sh $SYNTH_SCRIPTS/
/usr/bin/time $SYNTH_SCRIPTS/jupyterlab.sh > $SYNTH_LOGS/jupyterlab.log 2>&1

echo "Installing home directory scripts"
cp \
  Home/edit-me-then-run-4-git-config.sh \
  Home/set-vim-background.sh \
  Home/start-jupyter-lab.sh \
  $SYNTH_HOME/

echo "Finished!"
