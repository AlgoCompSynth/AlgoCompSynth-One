#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
export SYNTH_HOME=$PWD
source $SYNTH_HOME/wsl-jammy-envars.sh
export MAKE="make $MAKEFLAGS"

echo ""
echo "Creating virtual desktop"
mkdir --parents \
  $SYNTH_LOGS \
  $SYNTH_PROJECTS \
  $SYNTH_NOTEBOOKS \
  $SYNTH_WHEELS

echo "Defining Mambaforge home"
source $SYNTH_HOME/mamba-init.sh
echo "MAMBAFORGE_HOME: $MAMBAFORGE_HOME"

echo "Enabling conda and mamba commands"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh

echo "Checking for Mamba environment"
if [ "${#MAMBA_ENV_NAME}" -gt "0" -a `mamba env list | grep "$MAMBA_ENV_NAME" | wc -l` -gt "0" ]
then
  echo "Using existing Mamba environment $MAMBA_ENV_NAME"
else
  echo "No Mamba environment found - creating a new empty one!"

  export MAMBA_ENV_NAME="acs-1"
  echo "..Default Mamba environment name is $MAMBA_ENV_NAME"
  echo "..If that's OK press 'Enter' to accept it."
  echo "..Otherwise enter a different name."
  read -p "..Mamba environment name?"

  # change name if one was given
  if [ "${#REPLY}" -gt "0" ]
  then
    echo "..Setting MAMBA_ENV_NAME to $REPLY"
    export MAMBA_ENV_NAME=$REPLY
  fi

  echo "..Mamba environment name is $MAMBA_ENV_NAME"
  echo "..Updating $SYNTH_HOME/mamba-init.sh"
  grep -v "MAMBA_ENV_NAME" $SYNTH_HOME/mamba-init.sh > zzwork.txt
  mv -f zzwork.txt $SYNTH_HOME/mamba-init.sh
  echo "export MAMBA_ENV_NAME=\"$MAMBA_ENV_NAME\"" >> $SYNTH_HOME/mamba-init.sh

  echo "..Creating new $MAMBA_ENV_NAME mamba environment"
  echo "..This can take some time!"
  /usr/bin/time $SYNTH_SCRIPTS/mamba-env.sh > $SYNTH_LOGS/mamba-env.log 2>&1

fi
echo ""
echo ""
echo "Mamba aliases:"
grep "alias $MAMBA_ENV_NAME" $HOME/.bash_aliases
grep "alias deac" $HOME/.bash_aliases
echo ""
echo ""

echo ""
echo "Finished!"
