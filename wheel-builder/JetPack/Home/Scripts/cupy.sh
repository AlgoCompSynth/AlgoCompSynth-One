#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is now $PATH"

if [ ! -x /usr/local/cuda/bin/nvcc ]
then
  echo "CUDA toolkit missing - installing!"
  sudo apt-get install -qqy --no-install-recommends \
    cuda-toolkit-11-4 \
    libcudnn8-dev
fi

echo "Installing CuPy - this takes a long time!"
/usr/bin/time pip install cupy

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
