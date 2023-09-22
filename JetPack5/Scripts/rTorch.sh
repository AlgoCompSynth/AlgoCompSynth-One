#! /bin/bash

set -e

source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh

echo "Activating $MAMBA_ENV_NAME"
mamba activate $MAMBA_ENV_NAME

echo "Installing 'rTorch'"
/usr/bin/time Rscript -e "install.packages('rTorch', repos = 'https://cloud.r-project.org/')"

echo "Finished"
