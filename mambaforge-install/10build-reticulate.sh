#! /bin/bash

set -e

echo "Getting environment variables from '00envars'"
source 00envars

export SYNTH_HOME=$HOME/AlgoCompSynth-One
export SYNTH_SCRIPTS=$SYNTH_HOME/Scripts
export SYNTH_LOGS=$SYNTH_HOME/Logs
export SYNTH_PROJECTS=$SYNTH_HOME/Projects
export SYNTH_NOTEBOOKS=$SYNTH_HOME/Notebooks

export PATH=$PATH:/usr/local/cuda/bin

echo "Creating $SYNTH_HOME"
cp -rp Home/* $SYNTH_HOME/

echo "Installing Linux dependencies"
$SYNTH_SCRIPTS/linux-dependencies.sh > $SYNTH_LOGS/linux-dependencies.log 2>&1

echo "Installing Mambaforge if needed"
$SYNTH_SCRIPTS/mambaforge.sh

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
echo "Creating fresh r-reticulate mamba env:"
echo "  Python $PYTHON_VERSION"
echo "  JupyterLab"
echo "  R"
echo "  libgit2"
echo "  fftw"
echo "  portaudio"
echo "  CMake"
echo "  Ninja"
echo "  cuSignal"
export SYNTH_ENV_FILE=$SYNTH_SCRIPTS/cusignal_jetson_base.yml
sed "s/PYTHON_VERSION/$PYTHON_VERSION/" $SYNTH_SCRIPTS/cusignal_jetson_base_template > $SYNTH_ENV_FILE
/usr/bin/time $SYNTH_SCRIPTS/cusignal.sh > $SYNTH_LOGS/cusignal.log 2>&1

echo "Installing R developer tools"
/usr/bin/time $SYNTH_SCRIPTS/R-devtools.sh > $SYNTH_LOGS/R-devtools.log 2>&1

echo "Installing R audio packages"
/usr/bin/time $SYNTH_SCRIPTS/R-audio.sh > $SYNTH_LOGS/R-audio.log 2>&1

echo "Installing PyTorch"
/usr/bin/time $SYNTH_SCRIPTS/pytorch.sh > $SYNTH_LOGS/pytorch.log 2>&1
$SYNTH_SCRIPTS/test-pytorch.sh

echo "Installing torchaudio"
/usr/bin/time $SYNTH_SCRIPTS/torchaudio.sh > $SYNTH_LOGS/torchaudio.log 2>&1
$SYNTH_SCRIPTS/test-torchaudio.sh

echo "Finished!"
