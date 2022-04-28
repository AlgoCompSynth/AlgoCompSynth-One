#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Installing JupyterLab data science stack"
# jupyter_server<1.13.2 workaround
# https://github.com/jupyterlab/jupyterlab/issues/12094
# need jupyterlab-git for git
# https://github.com/jupyterlab/jupyterlab-git/issues/419
mamba install --quiet --yes \
  "jupyter_server<1.13.2" \
  jupyterlab \
  jupyterlab-git \
  pandas \
  scikit-learn \
  sympy

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
