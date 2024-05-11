#! /bin/bash

set -e

export HOSTNAME=`hostname`
echo "HOSTNAME: $HOSTNAME"

if [[ "$HOSTNAME" =~ "CPU" ]]
then
  echo "..Setting COMPUTE_MODE to CPU"
  export COMPUTE_MODE=CPU
elif [[ "$HOSTNAME" =~ "CUDA" ]]
then
  echo "..Setting COMPUTE_MODE to CUDA"
  export COMPUTE_MODE=CUDA
else 
  echo "Exit -1024: Cannot determine COMPUTE_MODE from hostname "$HOSTNAME""
  exit -1024
fi

echo "COMPUTE_MODE: $COMPUTE_MODE"

source $HOME/mambaforge/etc/profile.d/conda.sh

echo "Creating new 'JupyterLab' virtual environment"
/usr/bin/time conda env create --quiet --yes --file conda-env-$COMPUTE_MODE.yml > Logs/2_conda$COMPUTE_MODE.log 2>&1

echo "Activating 'JupyterLab' virtual environment"
conda activate JupyterLab

echo "Listing virtual environment to JupyterLab-list.log"
conda list > JupyterLab-list.log

echo "Testing PyTorch, torchaudio and torchvision"
python ./test-pytorch-$COMPUTE_MODE.py
python ./test-torchaudio.py
python ./test-torchvision.py

echo "Testing for R installation"
if [ -x /usr/bin/Rscript ]
then
  echo "R is installed"
  echo "Installing R package 'caracas'"
  Rscript -e "install.packages('caracas', quiet = TRUE)" \
  >> Logs/2_conda$COMPUTE_MODE.log 2>&1

  echo "Installing R package 'IRkernel'"
  Rscript -e "install.packages('IRkernel', quiet = TRUE)" \
  >> Logs/2_conda$COMPUTE_MODE.log 2>&1

  echo "Installing R kernel"
  Rscript -e "IRkernel::installspec()" \
  >> Logs/2_conda$COMPUTE_MODE.log 2>&1
else
  echo "R is not installed"
fi

echo "Finished"
