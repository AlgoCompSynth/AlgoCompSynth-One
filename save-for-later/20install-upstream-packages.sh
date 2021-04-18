#! /bin/bash

set -e

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.2/targets/aarch64-linux/lib:
export PATH=$PATH:/usr/local/cuda-10.2/bin
mkdir --parents $HOME/Downloads/Installers $HOME/Projects

# Visual Studio Code
host-scripts/vscode.sh

# Utility to get RAM size
sudo cp host-scripts/ram_kilobytes.sh /usr/local/bin/

# deviceQuery
host-scripts/deviceQuery.sh

# Miniforge
host-scripts/miniforge.sh

# JupyterLab / cusignal
export CUSIGNAL_VERSION="0.18.0"
host-scripts/cusignal.sh

export CMAKE_VERSION="3.20.0"
host-scripts/cmake.sh

export FLUIDSYNTH_VERSION="2.2.0"
host-scripts/fluidsynth.sh

export LLVM_VERSION="11.0.1"
host-scripts/llvm.sh

export XPRA_VERSION="4.1.2"
host-scripts/xpra.sh

# Pure data aka Pd
export PURE_DATA_VERSION="0.51-4"
host-scripts/pure-data.sh

export FAUST_VERSION="2.30.5"
host-scripts/faust.sh

export CHUCK_VERSION="1.4.0.1"
host-scripts/chuck.sh
