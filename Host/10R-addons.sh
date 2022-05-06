#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
export SYNTH_HOME=$PWD
source $SYNTH_HOME/jetpack-envars.sh

echo "Activating r-reticulate"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba activate r-reticulate

echo "Installing R if necessary"
if [ `R --version 2>/dev/null | wc -l` -le "0" ]
then
  echo "Installing R"
  /usr/bin/time $SYNTH_SCRIPTS/R-mambaforge.sh > $SYNTH_LOGS/R-mambaforge.log 2>&1
fi
R --version

echo "Updating existing packages"
Rscript -e "update.packages(ask = FALSE, quiet = TRUE, repos = 'https://cloud.r-project.org/')"

echo "Installing IRkernel"
Rscript -e "install.packages('IRkernel', quiet = TRUE, repos = 'https://cloud.r-project.org/')"
echo "Activating R Jupyter kernel"
Rscript -e "IRkernel::installspec()"

echo "Installing data.table, renv, and reticulate"
Rscript -e "install.packages('data.table', quiet = TRUE, repos = 'https://cloud.r-project.org/')"
Rscript -e "install.packages('renv', quiet = TRUE, repos = 'https://cloud.r-project.org/')"
Rscript -e "install.packages('reticulate', quiet = TRUE, repos = 'https://cloud.r-project.org/')"

echo "Installed R packages"
Rscript -e "print(rownames(installed.packages()))"

echo "Finished!"
