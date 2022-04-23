#! /bin/bash

set -e

echo "Creating fresh r-reticulate virtual environment"
/usr/bin/time python3 -m venv --symlinks --clear $WORKON_HOME/r-reticulate

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
echo "PATH is now $PATH"

echo "Installing data science / machine learning stack and cusignal dependencies"
pip install \
  Cython \
  ipython \
  jupyterlab \
  matplotlib \
  numba>=0.49 \
  numpy \
  numpydoc \
  onnx \
  pandas \
  pybind11 \
  pycuda \
  pydata-sphinx-theme \
  pytest \
  pytest-benchmark \
  scikit-learn \
  scipy>=1.5.0 \
  sphinx \
  sphinx-copybutton

echo "Cleanup"
pip list

echo "Finished"
