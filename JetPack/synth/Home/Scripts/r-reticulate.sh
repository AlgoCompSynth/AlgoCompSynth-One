#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh

if [ ! -e /usr/lib/aarch64-linux-gnu/libcudnn.so.8 ]
then
  echo "cudnn library missing - installing!"
  sudo apt-get install -qqy --no-install-recommends \
    cuda-nvtx-11-4 \
    cuda-runtime-11-4 \
    libcudnn8
fi

echo "Creating fresh r-reticulate virtual environment"
sed "s/PYTHON_VERSION/$PYTHON_VERSION/" $SYNTH_SCRIPTS/r-reticulate.template > $SYNTH_SCRIPTS/r-reticulate.yml
/usr/bin/time mamba env create --force --file $SYNTH_SCRIPTS/r-reticulate.yml

echo "Activating r-reticulate"
mamba activate r-reticulate

echo "Configuring widgets"
jupyter nbextension install --py widgetsnbextension --user
jupyter nbextension enable --py widgetsnbextension

echo "Installing CuPy, cuSignal, PyTorch and torchaudio from wheels"
pip install $SYNTH_WHEELS/*.whl

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
