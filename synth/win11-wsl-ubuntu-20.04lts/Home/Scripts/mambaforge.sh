#! /bin/bash

set -e

if [ ! -d "$HOME/mambaforge" ]
then
  echo "$HOME/mambaforge doesn't exist"
  echo "Installing mambaforge"

  export ARCH=`uname -m`
  pushd /tmp

    echo "Downloading latest Mambaforge installer"
    rm -fr Mambaforge*
    wget -q \
      https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-$ARCH.sh
    chmod +x Mambaforge-Linux-$ARCH.sh

    echo "Installing Mambaforge to '$HOME/mambaforge' ..."
    ./Mambaforge-Linux-$ARCH.sh -b

    popd
fi

echo "Enabling 'conda' and 'mamba'"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh

echo "Activating 'base'"
mamba activate base

echo "Lengthening connection timeout"
conda config --set remote_connect_timeout_secs 60.0

echo "Disabling auto-activation of 'base' environment"
conda config --set auto_activate_base false

echo "Setting default threads to number of processors"
conda config --set default_threads `nproc`

echo "Updating base packages"
mamba update --name base --all --yes --quiet

echo "Setting up bash command line"
mamba init bash
