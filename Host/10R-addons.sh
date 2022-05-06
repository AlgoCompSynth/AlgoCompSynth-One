#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
export SYNTH_HOME=$PWD
source $SYNTH_HOME/jetpack-envars.sh

echo "Installing R in /usr/local from source if necessary"
if [ `R --version 2>/dev/null | wc -l` -le "0" ]
then
  /usr/bin/time $SYNTH_SCRIPTS/R.sh > $SYNTH_LOGS/R.log 2>&1
fi

echo "Creating user library 'R_LIBS_USER' if necessary"
$SYNTH_SCRIPTS/R_LIBS_USER.R > $SYNTH_LOGS/R_LIBS_USER.log 2>&1

echo "Updating system packages"
sudo Rscript -e "update.packages(ask = FALSE, quiet = TRUE, repos = 'https://cloud.r-project.org/')"

echo "Activating r-reticulate"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Activating R Jupyter kernel"
Rscript -e "if(!require(IRkernel)) {install.packages('IRkernel', quiet = TRUE, repos = 'https://cloud.r-project.org/')}"
Rscript -e "IRkernel::installspec()"

echo "Installing data.table, renv, and reticulate"
Rscript -e "if(!require(data.table)) {install.packages('data.table', quiet = TRUE, repos = 'https://cloud.r-project.org/')}"
Rscript -e "if(!require(renv)) {install.packages('renv', quiet = TRUE, repos = 'https://cloud.r-project.org/')}"
Rscript -e "if(!require(reticulate)) {install.packages('reticulate', quiet = TRUE, repos = 'https://cloud.r-project.org/')}"
echo "Finished!"
