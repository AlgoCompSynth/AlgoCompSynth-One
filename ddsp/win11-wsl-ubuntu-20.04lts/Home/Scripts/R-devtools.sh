#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Installing mamba dependencies"
mamba install --quiet --yes \
  r-data.table \
  r-devtools \
  r-IRkernel \
  r-knitr \
  r-renv \
  r-remotes \
  r-reticulate \
  r-rmarkdown \
  r-tinytex
Rscript -e "IRkernel::installspec()"
Rscript -e "tinytex::install_tinytex()"

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
