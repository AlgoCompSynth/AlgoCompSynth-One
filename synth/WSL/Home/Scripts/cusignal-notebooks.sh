#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh

mamba activate r-reticulate

cd $SYNTH_PROJECTS

export CUSIGNAL_HOME=$(pwd)/cusignal
echo "Removing previous 'cusignal'"
rm -fr $CUSIGNAL_HOME
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
cd $CUSIGNAL_HOME

echo "Discovering cusignal version"
export CUSIGNAL_VERSION=`mamba list | grep cusignal | sed 's/cusignal  *//' | sed 's/  *.*$//'`
echo "Checking out version v$CUSIGNAL_VERSION"
git checkout v$CUSIGNAL_VERSION

echo "Copying '$CUSIGNAL_HOME/notebooks' to '$SYNTH_NOTEBOOKS'"
rm -rf $SYNTH_NOTEBOOKS/cusignal-notebooks
cp -rp $CUSIGNAL_HOME/notebooks $SYNTH_NOTEBOOKS/cusignal-notebooks

echo "Cleanup"
mamba list
mamba clean --tarballs --yes
rm -fr $SYNTH_PROJECTS/cusignal

echo "Finished"
