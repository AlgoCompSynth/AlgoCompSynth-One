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
  echo "  Installing R and recommended library packages"
  /usr/bin/time $SYNTH_SCRIPTS/R-mambaforge.sh > $SYNTH_LOGS/R-mambaforge.log 2>&1
fi
R --version

# Why we have to pin the 'r-base' version:
# We want to install the R 'devtools' package.
# 'devtools' depends on a package called 'gert'.
#
# 'gert' in turn depends on a system package
# called 'libgit2'. On Python 3.6, if we just
# install 'libgit2' after we installed 'r-base',
# conda / mamba will try to downgrade R from
# 4.0.2 to 3.6.3. But if we pin 'r-base', the
# constraint solver finds a version of 'libgit2'
# that doesn't need to downgrade 'r-base'!
export R_VERSION=`R --version | head -n 1 | sed "s;^R version ;;" | sed "s; .*$;;"`
echo "Pinning r-base to $R_VERSION"
echo "r-base ==$R_VERSION" >> $CONDA_PREFIX/conda-meta/pinned
cat $CONDA_PREFIX/conda-meta/pinned

echo "Installing libgit2 for R 'gert' package"
mamba install --quiet --force \
  libgit2

echo "Updating existing packages"
Rscript -e "update.packages(ask = FALSE, quiet = TRUE, repos = 'https://cloud.r-project.org/')"

echo "Installing IRkernel"
Rscript -e "install.packages('IRkernel', quiet = TRUE, repos = 'https://cloud.r-project.org/')"
echo "Activating R Jupyter kernel"
Rscript -e "IRkernel::installspec()"

echo "Installing caracas, data.table, devtools, renv, and reticulate"
Rscript -e "install.packages('caracas', quiet = TRUE, repos = 'https://cloud.r-project.org/')"
Rscript -e "install.packages('data.table', quiet = TRUE, repos = 'https://cloud.r-project.org/')"
Rscript -e "install.packages('devtools', quiet = TRUE, repos = 'https://cloud.r-project.org/')"
Rscript -e "install.packages('renv', quiet = TRUE, repos = 'https://cloud.r-project.org/')"
Rscript -e "install.packages('reticulate', quiet = TRUE, repos = 'https://cloud.r-project.org/')"

echo "Installed R packages"
Rscript -e "print(rownames(installed.packages()))"

echo "Finished!"
