#! /bin/bash

set -e

export SYNTH_HOME=$HOME/AlgoCompSynth-One
export SYNTH_LOGS=$SYNTH_HOME/Logs
export SYNTH_PROJECTS=$SYNTH_HOME/Projects
export SYNTH_NOTEBOOKS=$SYNTH_HOME/Notebooks

export PYTHON_VERSION="3.6"
export CUSIGNAL_VERSION="22.04.00"
export CUSIGNAL_TEST="0"
export PYTORCH_WHEEL_URL="https://nvidia.box.com/shared/static/h1z9sw4bb1ybi0rm3tu8qdj8hs05ljbm.whl"
export PYTORCH_WHEEL_FILE="torch-1.9.0-cp36-cp36m-linux_aarch64.whl"
export TORCHAUDIO_VERSION="0.9.0"
export PATH=$PATH:/usr/local/cuda/bin

echo "Creating $SYNTH_HOME"
mkdir --parents \
  $SYNTH_LOGS \
  $SYNTH_PROJECTS \
  $SYNTH_NOTEBOOKS

echo "Installing Linux dependencies"
./linux-dependencies.sh > $SYNTH_LOGS/linux-dependencies.log 2>&1

echo "Installing Mambaforge if needed"
./mambaforge.sh

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
export SYNTH_ENV_FILE=$PWD/cusignal_jetson_base.yml
sed "s/PYTHON_VERSION/$PYTHON_VERSION/" cusignal_jetson_base_template > $SYNTH_ENV_FILE
./cusignal.sh > $SYNTH_LOGS/cusignal.log 2>&1

echo "Installing R developer tools"
./R-devtools.sh > $SYNTH_LOGS/R-devtools.log 2>&1

echo "Installing R audio packages"
./R-audio.sh > $SYNTH_LOGS/R-audio.log 2>&1

echo "Installing PyTorch"
./pytorch.sh > $SYNTH_LOGS/pytorch.log 2>&1
./test-pytorch.sh

echo "Installing torchaudio"
./torchaudio.sh > $SYNTH_LOGS/torchaudio.log 2>&1
./test-torchaudio.sh

echo "Installing command line tools"
cp \
  set-vim-background.sh \
  edit-me-then-run-4-git-config.sh \
  start-jupyter-lab.sh \
  $SYNTH_HOME/
