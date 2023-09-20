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

echo "Activating $MAMBA_ENV_NAME"
mamba activate $MAMBA_ENV_NAME

echo "Installing PyTorch and torchaudio if necessary"
if [ `mamba list | grep "torch" | wc -l` -le "0" ]
then
  echo "..Installing PyTorch and torchaudio"

  # We have to do this in two steps to make sure both pytorch and
  # torchaudio come from the 'pytorch' channel! If we don't,
  # tests fail!
  mamba install --quiet --yes \
    pytorch \
    pytorch-cuda=$CUDA_VERSION \
    --channel pytorch \
    --channel nvidia
    $SYNTH_SCRIPTS/test-pytorch.sh 2>&1 | tee $SYNTH_LOGS/test-pytorch.log

  mamba install --quiet --yes \
    torchaudio \
    --channel pytorch \
    --channel nvidia
    $SYNTH_SCRIPTS/test-torchaudio.sh 2>&1 | tee $SYNTH_LOGS/test-torchaudio.log
fi

echo "Installing 'rTorch' R package"
/usr/bin/time $SYNTH_SCRIPTS/rTorch.sh > $SYNTH_LOGS/rTorch.log 2>&1

echo "Installing cusignal if necessary"
export CUSIGNAL_TEST="0" # Don't test by default
if [ `mamba list | grep "cusignal" | wc -l` -le "0" ]
then
  echo "..Installing cusignal"
  mamba install --quiet --yes \
    cusignal=$CUSIGNAL_VERSION \
    --channel rapidsai \
    --channel conda-forge \
    --channel nvidia
  echo "..Installing cusignal notebooks"
  $SYNTH_SCRIPTS/cusignal-notebooks.sh > $SYNTH_LOGS/cusignal-notebooks.log 2>&1
fi

echo ""
echo "Listing Mamba packages"
echo "# Mamba packages" > $SYNTH_LOGS/Mamba-packages.log
mamba list --name $MAMBA_ENV_NAME \
  >> $SYNTH_LOGS/Mamba-packages.log

echo ""
echo "Listing R packages"
echo "# R packages" > $SYNTH_LOGS/R-packages.log
Rscript -e 'subset(installed.packages(), select = c("Version", "Built"))' \
  >> $SYNTH_LOGS/R-packages.log

echo ""
echo "Finished!"
