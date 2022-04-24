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
  Cython \
  'docutils<0.18,>=0.14' \
  fastrlock \
  ipython \
  'Jinja2<3.1,>=2.10' \
  jupyterlab \
  matplotlib \
  'numba>=0.49' \
  'numpy<1.22,>=1.18' \
  numpydoc \
  onnx \
  pandas \
  pybind11 \
  pycuda \
  pydata-sphinx-theme \
  pytest \
  pytest-benchmark \
  scikit-learn \
  'scipy>=1.5.0' \
  sphinx \
  sphinx-copybutton \
  sympy

echo "Cleanup"
pip list

echo "Finished"
