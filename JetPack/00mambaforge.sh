#! /bin/bash

set -e

if [ -d "$HOME/mambaforge" ]
then
  echo ""
  echo "Default Mambaforge exists at $HOME/mambaforge."
  echo "If you want to replace it, enter the text"
  echo "'rEpLaCe It!!' below."
  echo ""
  read -p "Replace it?"

  if [ "$REPLY" != "rEpLaCe It!!" ]
  then
    echo "Exiting without touching $HOME/mambaforge!"
    exit
  else
    echo ""
    echo "You have decided to replace $HOME/mambaforge."
    echo "If you change your mind, you have 30 seconds"
    echo "to hit 'CTL-C' before the removal happens."
  fi

  echo ""
  echo "Beginning 30 second sleep - press 'CTL-C' to abort"
  echo "this script."
  sleep 30

  echo ""
  echo "Removing $HOME/mambaforge"
  rm -rf $HOME/mambaforge
fi

echo "Downloading latest Mambaforge installer"
export ARCH=`uname -m`
pushd /tmp
  rm -fr Mambaforge*
  wget -q \
    https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-$ARCH.sh
  chmod +x Mambaforge-Linux-$ARCH.sh

  echo ""
  echo "Mambaforge and its virtual environments can"
  echo "use many gigabytes of disk space. Enter a"
  echo "directory where you can write that has"
  echo "enough space for Mambaforge and all the"
  echo "virtual environments you plan to create."
  echo "The directory will be removed if it exists."
  read -p "Mambaforge directory?"

  export MAMBAFORGE_HOME=$REPLY
  echo "Removing $MAMBAFORGE_HOME if it exists"
  rm -fr $MAMBAFORGE_HOME
  echo "Installing Mambaforge to $MAMBAFORGE_HOME"
  ./Mambaforge-Linux-$ARCH.sh -b -p $MAMBAFORGE_HOME
popd

echo ""
echo "Enabling 'conda' and 'mamba'"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh

echo "Activating 'base'"
mamba activate base

echo "Disabling auto-activation of 'base' environment"
conda config --set auto_activate_base false

echo "Setting default threads to number of processors"
conda config --set default_threads `nproc`

echo "Updating base packages"
mamba update --name base --all --yes --quiet

echo "Setting up bash command line"
mamba init bash

if [ -e $HOME/.zshrc ]
then
  echo "Setting up zsh command line"
  mamba init zsh
fi

echo "Creating 'mamba-init.sh'"
echo ". $MAMBAFORGE_HOME/etc/profile.d/conda.sh" > mamba-init.sh
echo ". $MAMBAFORGE_HOME/etc/profile.d/mamba.sh" >> mamba-init.sh

echo "Finished!"
