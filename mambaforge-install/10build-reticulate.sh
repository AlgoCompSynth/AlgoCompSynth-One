#! /bin/bash

set -e

export SYNTH_HOME=$HOME/AlgoCompSynth-One
export SYNTH_LOGS=$SYNTH_HOME/Logs
export SYNTH_PROJECTS=$SYNTH_HOME/Projects
export SYNTH_NOTEBOOKS=$SYNTH_HOME/Notebooks

export PYTHON_VERSION="3.6"
export CUSIGNAL_VERSION="22.04.00"
export CUSIGNAL_TEST="0"
export PYTORCH_WHEEL_URL="https://developer.download.nvidia.com/compute/redist/jp/v461/pytorch"
export PYTORCH_WHEEL_FILE="torch-1.11.0a0+17540c5+nv22.01-cp36-cp36m-linux_aarch64.whl"
export TORCHAUDIO_VERSION="0.11.0"

echo "Creating $SYNTH_HOME"
mkdir --parents \
  $SYNTH_LOGS \
  $SYNTH_PROJECTS \
  $SYNTH_NOTEBOOKS

echo "Installing /usr/bin/time"
sudo apt-get update
sudo apt-get install -y \
  time

echo "Installing Mambaforge if needed"
./mambaforge.sh

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
echo "Creating fresh r-reticulate mamba env with cusignal"
export SYNTH_ENV_FILE=$PWD/cusignal_jetson_base.yml
sed "s/PYTHON_VERSION/$PYTHON_VERSION/" cusignal_jetson_base_template > $SYNTH_ENV_FILE
./cusignal.sh #> $SYNTH_LOGS/cusignal.log 2>&1

echo "Installing PyTorch"
cp pytorch.sh ./
./pytorch.sh #> $SYNTH_LOGS/pytorch.log 2>&1
cp test-install.sh check_gpu.py ./
./test-install.sh

echo "Installing JupyterLab and R"
cp R-base.sh base.R ./
./R-base.sh #> $SYNTH_LOGS/R-base.log 2>&1

echo "Installing R audio tools"
cp R-audio.sh audio.R ./
./R-audio.sh #> $SYNTH_LOGS/R-audio.log 2>&1

echo "Installing command line tools"
cp \
  set-vim-background.sh \
  edit-me-then-run-4-git-config.sh \
  start-jupyter-lab.sh \
  $SYNTH_HOME/
