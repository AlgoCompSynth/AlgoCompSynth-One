#! /bin/bash

set -e

mkdir --parents /tmp/Installers
cd /tmp/Installers
echo "Downloading Mambaforge installer"
wget -q \
  https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-aarch64.sh
chmod +x Mambaforge-Linux-aarch64.sh

echo "Installing a fresh copy to '$HOME/miniconda3' ..."
rm -fr $HOME/mambaforge* $HOME/miniforge* $HOME/miniconda*
./Mambaforge-Linux-aarch64.sh -b -p $HOME/miniconda3 \
  && rm ./Mambaforge-Linux-aarch64.sh

echo "Updating base environment"
source $HOME/miniconda3/etc/profile.d/conda.sh
mamba update --all --quiet --yes --name base

echo "Initializing conda for 'bash'"
conda init bash
conda config --set auto_activate_base false
