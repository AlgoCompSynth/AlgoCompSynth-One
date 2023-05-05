#! /bin/bash

set -e

source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh

echo "Activating r-reticulate"
mamba activate r-reticulate

echo "Installing 'rTorch'"
/usr/bin/time Rscript -e "install.packages('rTorch', repos = 'https://cloud.r-project.org/')"

echo "Finished"
