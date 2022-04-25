#! /bin/bash

set -e

echo "Creating fresh r-reticulate virtual environment"
python3 -m venv --symlinks --clear $WORKON_HOME/r-reticulate

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is now $PATH"

echo "Installing wheel"
pip install wheel

echo "Installing Python data science / machine learning stack and cusignal dependencies"
/usr/bin/time pip install \
  jupyterlab \
  matplotlib \
  'numba>=0.49' \
  'numpy<1.22,>=1.18' \
  onnx \
  pandas \
  pycuda \
  scikit-learn \
  'scipy>=1.5.0' \
  sympy \
  $SYNTH_WHEELS/*.whl

echo "Cleanup"
pip list

echo "Finished"
