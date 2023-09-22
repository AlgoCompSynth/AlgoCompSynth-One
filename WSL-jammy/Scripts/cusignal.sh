#! /bin/bash

set -e

source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate $MAMBA_ENV_NAME
export PATH=$PATH:/usr/local/cuda/bin

echo "Installing cusignal"
mamba install --quiet --yes \
  cusignal=$CUSIGNAL_VERSION \
  --channel rapidsai \
  --channel conda-forge \
  --channel nvidia

echo "Installing cusignal notebooks"
pushd $SYNTH_PROJECTS

export CUSIGNAL_HOME=$(pwd)/cusignal
echo "..Removing previous 'cusignal'"
rm -fr $CUSIGNAL_HOME
echo "..Cloning cuSignal source"
git clone --branch v$CUSIGNAL_VERSION https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
cd $CUSIGNAL_HOME

echo "..Copying $CUSIGNAL_HOME/notebooks to $SYNTH_NOTEBOOKS/cusignal-notebooks"
rm -rf $SYNTH_NOTEBOOKS/cusignal-notebooks
cp -rp $CUSIGNAL_HOME/notebooks $SYNTH_NOTEBOOKS/cusignal-notebooks

echo "..Copying E2E test notebooks to $SYNTH_NOTEBOOKS"
cp $SYNTH_SCRIPTS/E2E*ipynb $SYNTH_NOTEBOOKS/

echo "..Removing cusignal project repository"
rm -fr $SYNTH_PROJECTS/cusignal

popd

echo "Cleanup"
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

echo "Finished"
