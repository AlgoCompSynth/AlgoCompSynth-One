#! /bin/bash

set -e

echo "Activating r-reticulate"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate r-reticulate

if [ `find $SYNTH_WHEELS -name 'torchvision-*.whl' | wc -l` = "0" ]
then
  echo "Building torchvision wheel"

  cd $SYNTH_PROJECTS
  echo "Removing previous 'vision'"
  rm -fr vision*
  git clone --branch=v$TORCHVISION_VERSION https://github.com/pytorch/vision.git
  cd vision
  echo "Installing from source"
  export FORCE_CUDA=1
  /usr/bin/time python setup.py bdist_wheel
  echo "Saving torchvision wheel"
  cp dist/torchvision-*.whl $SYNTH_WHEELS/
fi
echo "Installing torchvision wheel - dependencies built into r-reticulate"
pip install --no-deps $SYNTH_WHEELS/torchvision-*.whl

echo "Cleanup"
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

mamba list

echo "Finished"
