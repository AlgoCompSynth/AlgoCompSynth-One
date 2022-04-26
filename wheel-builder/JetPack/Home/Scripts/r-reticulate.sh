#! /bin/bash

set -e

echo "Creating fresh r-reticulate virtual environment"
python3 -m venv --system-site-packages --clear $WORKON_HOME/r-reticulate

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
echo "PATH is now $PATH"
pip install --upgrade pip setuptools wheel

echo "Cleanup"
pip list

echo "Finished"
