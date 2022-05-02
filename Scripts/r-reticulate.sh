#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh

if [ ! -d $HOME/mambaforge/envs/r-reticulate ]
then
  echo "Creating fresh r-reticulate virtual environment"
  cp $SYNTH_SCRIPTS/r-reticulate.template.$PYTHON_VERSION $SYNTH_SCRIPTS/r-reticulate.yml
  /usr/bin/time mamba env create --file $SYNTH_SCRIPTS/r-reticulate.yml
fi

echo "Activating r-reticulate"
mamba activate r-reticulate

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Defining r-reticulate and deac aliases"
if [ ! `grep -e "alias r-reticulate" $HOME/.bash_aliases | wc -l` -gt "0" ]
then
  cat $SYNTH_SCRIPTS/r-reticulate-aliases >> $HOME/.bash_aliases
fi

if [ -e $HOME/.zshrc ]
then
  if [ ! `grep -e "alias r-reticulate" $HOME/.zshrc | wc -l` -gt "0" ]
  then
    cat $SYNTH_SCRIPTS/r-reticulate-aliases >> $HOME/.zshrc
  fi
fi

echo "Finished"
