#! /bin/bash

set -e

echo "Activating r-reticulate"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PATH=$PATH:/usr/local/cuda/bin

if [ `find $SYNTH_WHEELS -name 'torchvision-*.whl' | wc -l` = "0" ]
then
  echo "Building torchvision wheel"

  cd $SYNTH_PROJECTS
  echo "Removing previous 'vision'"
  rm -fr vision*
  git clone --recurse-submodules https://github.com/pytorch/vision.git
  cd vision
  echo "Checking out v$TORCHVISION_VERSION"
  git checkout v$TORCHVISION_VERSION
  echo "Installing from source"
  export FORCE_CUDA=1
  /usr/bin/time python setup.py bdist_wheel
  echo "Saving torchvision wheel"
  cp dist/torchvision-*.whl $SYNTH_WHEELS/
fi
echo "Installing torchvision wheel"
pip install $SYNTH_WHEELS/torchvision-*.whl

echo "Cleanup"
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

mamba list

echo "Finished"
