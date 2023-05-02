#! /bin/bash

set -e

echo "Activating r-reticulate"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PATH=$PATH:/usr/local/cuda/bin

if [ `find $SYNTH_WHEELS -name 'pytorch-*.whl' | wc -l` = "0" ]
then
  echo "Building PyTorch wheel"

  cd $SYNTH_PROJECTS
  echo "Removing previous 'pytorch'"
  rm -fr pytorch*
  git clone --recursive https://github.com/pytorch/pytorch.git
  cd pytorch
  echo "Checking out v$PYTORCH_VERSION"
  git checkout v$PYTORCH_VERSION
  echo "Installing from source"
  export USE_NCCL=0
  export USE_QNNPACK=0
  export USE_PYTORCH_QNNPACK=0
  export TORCH_CUDA_ARCH_LIST="$CUDA_CAPABILITY_WITH_DOT"   # or "7.2;8.7" for JetPack 5 wheels for Xavier/Orin
  pip install -r requirements.txt
  /usr/bin/time python setup.py bdist_wheel
  echo "Saving pytorch wheel"
  cp dist/torchpytorch-*.whl $SYNTH_WHEELS/
fi
echo "Installing pytorch wheel"
pip install $SYNTH_WHEELS/pytorch-*.whl

echo "Cleanup"
echo "..Removing pytorch project repository"
rm -fr $SYNTH_PROJECTS/pytorch
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

mamba list

echo "Finished"
