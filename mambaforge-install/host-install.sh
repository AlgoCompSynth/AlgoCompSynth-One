#! /bin/bash

set -e

echo "Getting environment variables from '00envars'"
source 00envars

echo "Creating fresh $SYNTH_HOME"
rm -fr $SYNTH_HOME
cp -rp Home $SYNTH_HOME

echo "Installing Linux dependencies"
$SYNTH_SCRIPTS/linux-dependencies.sh > $SYNTH_LOGS/linux-dependencies.log 2>&1

echo "Installing Mambaforge if needed"
$SYNTH_SCRIPTS/mambaforge.sh > $SYNTH_LOGS/mambaforge.log 2>&1

echo "Installing cusignal in fresh mamba environment 'r-reticulate'"
sed "s/PYTHON_VERSION/$PYTHON_VERSION/" $SYNTH_SCRIPTS/cusignal_jetson_base_template \
  > $SYNTH_ENV_FILE
/usr/bin/time $SYNTH_SCRIPTS/cusignal.sh > $SYNTH_LOGS/cusignal.log 2>&1

echo "Installing PyTorch"
/usr/bin/time $SYNTH_SCRIPTS/pytorch.sh > $SYNTH_LOGS/pytorch.log 2>&1
$SYNTH_SCRIPTS/test-pytorch.sh

echo "Installing torchaudio"
/usr/bin/time $SYNTH_SCRIPTS/torchaudio.sh #> $SYNTH_LOGS/torchaudio.log 2>&1
$SYNTH_SCRIPTS/test-torchaudio.sh

echo "Installing JupyterLab"
/usr/bin/time $SYNTH_SCRIPTS/jupyterlab.sh > $SYNTH_LOGS/jupyterlab.log 2>&1

echo "Installing R developer tools"
/usr/bin/time $SYNTH_SCRIPTS/R-devtools.sh > $SYNTH_LOGS/R-devtools.log 2>&1

echo "Installing R audio packages"
/usr/bin/time $SYNTH_SCRIPTS/R-audio.sh > $SYNTH_LOGS/R-audio.log 2>&1

echo "Finished!"
