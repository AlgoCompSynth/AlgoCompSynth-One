#! /bin/bash

set -e

if [ -d "$HOME/mambaforge" ]
then
  echo "$HOME/mambaforge exists - will not clobber!"
  exit
fi

export ARCH=`uname -m`
pushd /tmp

  echo "Downloading latest Mambaforge installer"
  rm -fr Mambaforge*
  wget -q \
    https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-$ARCH.sh
  chmod +x Mambaforge-Linux-$ARCH.sh

  echo "Installing Mambaforge to '$HOME/mambaforge' ..."
  ./Mambaforge-Linux-$ARCH.sh -b

  echo "Updating base packages"
  source $HOME/mambaforge/etc/profile.d/conda.sh
  source $HOME/mambaforge/etc/profile.d/mamba.sh
  mamba update --name base --all --yes --quiet

  echo "Initializing 'bash' and 'zsh' command lines"
  conda init bash
  conda init zsh
  mamba init bash
  mamba init zsh
  conda config --set auto_activate_base false

  popd
