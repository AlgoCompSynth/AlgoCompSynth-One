#! /bin/bash

set -e

export SYNTH_HOME=$PWD

echo "..Checking for existing Mambaforge installation"
export MAMBAFORGE_HOME=""

if [ `find $HOME -path '*/bin/mamba' | wc -l` -gt "0" ]
then
  export MAMBAFORGE_HOME=`find $HOME -path '*/bin/mamba' | grep -v "pkgs" | sed 's;/bin/mamba;;'`
  echo "..Found $MAMBAFORGE_HOME - normal exit"
  echo "..Updating $SYNTH_HOME/mamba-init.sh"
  echo "export MAMBAFORGE_HOME=\"$MAMBAFORGE_HOME\"" > $SYNTH_HOME/mamba-init.sh
  echo "..Exiting normally"
  exit
fi

# we either couldn't find it or the user removed an existing one
echo "..Creating a new Mambaforge installation"

pushd /tmp
export ARCH=`uname -m`
rm -fr Mambaforge*
echo ""
echo "..Downloading latest Mambaforge installer"
wget -q \
  https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-$ARCH.sh
chmod +x Mambaforge-Linux-$ARCH.sh

echo ""
echo "..Mambaforge and its virtual environments can"
echo "..use many gigabytes of disk space. Enter a"
echo "..directory where you can write that has"
echo "..enough space for Mambaforge and all the"
echo "..virtual environments you plan to create."
echo "..The directory will be removed if it exists."
echo ""

export MAMBAFORGE_HOME=$HOME/mambaforge
echo "..Default Mambaforge directory is $MAMBAFORGE_HOME"
echo "..If that's OK press 'Enter' to accept it."
echo "..Otherwise enter a different directory."
read -p "..Mambaforge directory?"

# a real directory name must be at least "/home"
if [ "${#REPLY}" -gt "5" ]
then
  echo "..Setting MAMBAFORGE_HOME to $REPLY"
  export MAMBAFORGE_HOME=$REPLY
fi

echo "..Removing $MAMBAFORGE_HOME if it exists"
if [ -d $MAMBAFORGE_HOME ]
then
  rm -fr $MAMBAFORGE_HOME
fi
echo "..Installing Mambaforge to $MAMBAFORGE_HOME"
./Mambaforge-Linux-$ARCH.sh -b -p $MAMBAFORGE_HOME
echo "..Updating $SYNTH_HOME/mamba-init.sh"
echo "export MAMBAFORGE_HOME=\"$MAMBAFORGE_HOME\"" > $SYNTH_HOME/mamba-init.sh
popd

echo ""
echo "..Enabling 'conda' and 'mamba'"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh

echo "..Activating 'base'"
mamba activate base

echo "..Disabling auto-activation of 'base' environment"
conda config --set auto_activate_base false

echo "..Setting default threads to number of processors"
conda config --set default_threads `nproc`

echo "..Updating base packages"
mamba update --name base --all --yes --quiet

echo "..Setting up bash command line"
mamba init bash

if [ -e $HOME/.zshrc ]
then
  echo "..Setting up zsh command line"
  mamba init zsh
fi

echo "..Finished!"
