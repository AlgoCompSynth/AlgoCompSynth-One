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
  absl-py \
  astor \
  Cython \
  'docutils<0.18,>=0.14' \
  fastrlock \
  gast \
  google-pasta \
  grpcio \
  h5py \
  ipython \
  'Jinja2<3.1,>=2.10' \
  jupyterlab \
  matplotlib \
  mock \
  'numba>=0.49' \
  'numpy<1.22,>=1.18' \
  numpydoc \
  onnx \
  pandas \
  portpicker \
  protobuf \
  psutil \
  py-cpuinfo \
  pybind11 \
  pycuda \
  pydata-sphinx-theme \
  pytest \
  pytest-benchmark \
  requests \
  scikit-learn \
  'scipy>=1.5.0' \
  six \
  sphinx \
  sphinx-copybutton \
  sympy \
  termcolor \
  testresources \
  wrapt

echo "Cleanup"
pip list

echo "Finished"
