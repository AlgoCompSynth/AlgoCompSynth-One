#! /bin/bash

set -e

echo "Creating fresh r-reticulate virtual environment"
/usr/bin/time python3 -m venv --symlinks --clear $WORKON_HOME/r-reticulate

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
echo "PATH is now $PATH"

echo "Installing cusignal build dependencies"
pip install \
  scipy>=1.5.0 \
  numpy \
  matplotlib \
  numba>=0.49 \
  pytest \
  pytest-benchmark \
  sphinx \
  pydata-sphinx-theme \
  sphinx-copybutton \
  numpydoc \
  ipython \
  jupyterlab

echo "Cleanup"
pip list

echo "Finished"
