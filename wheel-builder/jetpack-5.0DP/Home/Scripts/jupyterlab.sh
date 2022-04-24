#! /bin/bash

set -e


echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is now $PATH"

echo "Installing mamba dependencies"
# jupyter_server<1.13.2 workaround
# https://github.com/jupyterlab/jupyterlab/issues/12094
# need jupyterlab-git for git
# https://github.com/jupyterlab/jupyterlab-git/issues/419
mamba install --quiet --yes \
  "jupyter_server<1.13.2" \
  jupyterlab \
  jupyterlab-git

echo "Enabling R kernel"
Rscript -e "IRkernel::installspec()"

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
