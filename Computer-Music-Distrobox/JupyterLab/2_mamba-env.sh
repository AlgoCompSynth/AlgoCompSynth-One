#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh

echo "Creating JupyterLab virtual environment"
/usr/bin/time conda env create --yes --file mamba-env.yml > ../Logs/2_mamba-env.log 2>&1

echo "Activating JupyterLab virtual environment"
conda activate JupyterLab

echo "Testing PyTorch, torchaudio and torchvision"
python ./test-pytorch.py
python ./test-torchaudio.py
python ./test-torchvision.py

echo "Installing R package 'IRkernel'"
Rscript -e "install.packages('IRkernel')"

echo "Installing kernel"
Rscript -e "IRkernel::installspec()"

echo "Finished"
