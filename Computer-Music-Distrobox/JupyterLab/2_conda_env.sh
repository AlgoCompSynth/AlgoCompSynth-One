#! /bin/bash

set -e

echo "There are two COMPUTE_MODE settings: CUDA for an NVIDIA"
echo "GPU and CPU for any other system. CUDA is the default."
echo ""
echo "To select CPU mode, enter any non-empty string, To stay"
echo "with the default CUDA, simply press 'Enter'."
read -p "COMPUTE_MODE?"

if [ "${#REPLY}" -gt "0" ]
then
  echo "..Setting COMPUTE_MODE to CPU"
  export COMPUTE_MODE=CPU
else
  echo "..Setting COMPUTE_MODE to CUDA"
  export COMPUTE_MODE=CUDA
fi
echo "COMPUTE_MODE: $COMPUTE_MODE"

source $HOME/mambaforge/etc/profile.d/conda.sh

echo "Creating new 'JupyterLab' virtual environment"
/usr/bin/time conda env create --quiet --yes --file conda-env-$COMPUTE_MODE.yml > ../Logs/2_conda$COMPUTE_MODE.log 2>&1

echo "Activating 'JupyterLab' virtual environment"
conda activate JupyterLab

echo "Listing virtual environment to JupyterLab-list.log"
conda list > JupyterLab-list.log

echo "Testing PyTorch, torchaudio and torchvision"
python ./test-pytorch-$COMPUTE_MODE.py
python ./test-torchaudio.py
python ./test-torchvision.py

echo "Installing R package 'IRkernel'"
Rscript -e "install.packages('IRkernel', quiet = TRUE)"

echo "Installing kernel"
Rscript -e "IRkernel::installspec()"

echo "Finished"
