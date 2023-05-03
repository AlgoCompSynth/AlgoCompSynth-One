#! /bin/bash

set -e

export PKG_CPPFLAGS="-DHAVE_WORKING_LOG1P"
export PKG_CONFIG_PATH=$CONDA_PREFIX/lib/pkgconfig

source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh

echo "Creating fresh r-reticulate virtual environment"
cp $SYNTH_SCRIPTS/r-reticulate.template.$PYTHON_VERSION $SYNTH_SCRIPTS/r-reticulate.yml
/usr/bin/time mamba env create --file $SYNTH_SCRIPTS/r-reticulate.yml

echo "Activating r-reticulate"
mamba activate r-reticulate

echo "Updating existing R packages"
/usr/bin/time Rscript -e "update.packages(ask = FALSE, quiet = TRUE, repos = 'https://cloud.r-project.org/')"

echo "Installing 'caracas'"
/usr/bin/time Rscript -e "install.packages('caracas', repos = 'https://cloud.r-project.org/')"

echo "Installing 'tinytex'"
/usr/bin/time Rscript -e "tinytex::install_tinytex(force = TRUE)"

echo "Installing R sound packages"
/usr/bin/time Rscript -e "source('$SYNTH_SCRIPTS/sound.R')"

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
