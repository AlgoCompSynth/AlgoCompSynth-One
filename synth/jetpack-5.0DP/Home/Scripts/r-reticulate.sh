#! /bin/bash

set -e

echo "Creating fresh r-reticulate virtual environment"
python3 -m venv --symlinks --clear $WORKON_HOME/r-reticulate

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
echo "PATH is now $PATH"

echo "Installing Python data science / machine learning stack and cusignal dependencies"
/usr/bin/time pip install \
  Cython \
  fastrlock \
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
  sphinx-copybutton \
  sympy

echo "Cleanup"
pip list

echo "Finished"
