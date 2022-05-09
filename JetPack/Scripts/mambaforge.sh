#! /bin/bash

set -e

echo "..Checking for existing Mambaforge installation"
export MAMBAFORGE_HOME=""

# first check for mamba-init.sh pointing to an existing directory
echo "....Checking $SYNTH_HOME/mamba-init.sh"
if [ -f "$SYNTH_HOME/mamba-init.sh" ] && \
   [ `grep -e "export MAMBAFORGE_HOME=" $SYNTH_HOME/mamba-init.sh | wc -l` -gt "0" ]
then
  # file exists and defines MAMBAFORGE_HOME
  echo "....$SYNTH_HOME/mamba-init.sh defines MAMBAFORGE_HOME"
  source $SYNTH_HOME/mamba-init.sh

  if [ ! -d "$MAMBAFORGE_HOME/condabin" ]
  then
    # unfortunately it's not a directory
    echo "....$MAMBAFORGE_HOME/condabin is not a directory"
    export MAMBAFORGE_HOME=""
  else
    echo "....Mambaforge installation found at $MAMBAFORGE_HOME"
  fi
fi

# if that failed, try the default
if [ "$MAMBAFORGE_HOME" == "" ] && [ -d "$HOME/mambaforge/condabin" ]
then
  echo "....Default Mambaforge installation found at $HOME/mambaforge"
  export MAMBAFORGE_HOME=$HOME/mambaforge
fi

# if it's there, offer to leave it alone
if [ "$MAMBAFORGE_HOME" != "" ]
then
  echo ""
  echo "..A Mambaforge installation exists at $MAMBAFORGE_HOME."
  read -p "..Do you want to keep it as is? (Y/n)"

  # require explicit "n" to remove it
  if [ ${#REPLY} == "0" ] || [ $REPLY != "n" ]
  then
    echo "..Updating $SYNTH_HOME/mamba-init.sh"
    echo "export MAMBAFORGE_HOME=\"$MAMBAFORGE_HOME\"" > $SYNTH_HOME/mamba-init.sh
    echo "..Exiting without touching $MAMBAFORGE_HOME!"
    exit
  else
    echo "..Removing $MAMBAFORGE_HOME" 
    rm -rf $MAMBAFORGE_HOME
  fi
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
read -p "..New Mambaforge directory?"

export MAMBAFORGE_HOME=$REPLY
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
