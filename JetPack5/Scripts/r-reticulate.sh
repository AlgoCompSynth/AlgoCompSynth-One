#! /bin/bash

set -e

source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh

echo "Creating fresh r-reticulate virtual environment"
cp $SYNTH_SCRIPTS/r-reticulate.template.$PYTHON_VERSION $SYNTH_SCRIPTS/r-reticulate.yml
/usr/bin/time mamba env create --file $SYNTH_SCRIPTS/r-reticulate.yml

echo "Activating r-reticulate"
mamba activate r-reticulate

echo "Updating existing packages"
/usr/bin/time Rscript -e "update.packages(ask = FALSE, quiet = TRUE, repos = 'https://cloud.r-project.org/')"

echo "Installing 'caracas'"
/usr/bin/time Rscript -e "install.packages('caracas', repos = 'https://cloud.r-project.org/')"

echo "Installing 'tinytex'"
/usr/bin/time Rscript -e "tinytex::install_tinytex(force = TRUE)"

echo "Activating R Jupyter kernel"
Rscript -e "IRkernel::installspec()"

echo "Installed R packages"
Rscript -e "print(rownames(installed.packages()))"

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Defining r-reticulate and deac aliases"
if [ ! `grep -e "alias r-reticulate" $HOME/.bash_aliases | wc -l` -gt "0" ]
then
  cat $SYNTH_SCRIPTS/r-reticulate-aliases >> $HOME/.bash_aliases
fi

if [ -e $HOME/.zshrc ]
then
  if [ ! `grep -e "alias r-reticulate" $HOME/.zshrc | wc -l` -gt "0" ]
  then
    cat $SYNTH_SCRIPTS/r-reticulate-aliases >> $HOME/.zshrc
  fi
fi

echo "Finished"
