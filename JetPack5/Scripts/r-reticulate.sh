#! /bin/bash

set -e

export PKG_CPPFLAGS="-DHAVE_WORKING_LOG1P"
export PKG_CONFIG_PATH=$CONDA_PREFIX/lib/pkgconfig

source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh

echo "Creating fresh $MAMBA_ENV_NAME virtual environment"
#cp $SYNTH_SCRIPTS/$MAMBA_ENV_NAME.template.$PYTHON_VERSION $SYNTH_SCRIPTS/$MAMBA_ENV_NAME.yml
sed "s/PYTHON_VERSION/$PYTHON_VERSION/" $SYNTH_SCRIPTS/$MAMBA_ENV_NAME.template > $SYNTH_SCRIPTS/$MAMBA_ENV_NAME.yml
/usr/bin/time mamba env create --file $SYNTH_SCRIPTS/$MAMBA_ENV_NAME.yml

echo "Activating $MAMBA_ENV_NAME"
mamba activate $MAMBA_ENV_NAME

echo "Installing 'caracas'"
/usr/bin/time Rscript -e "install.packages('caracas', quiet = TRUE, repos = 'https://cloud.r-project.org/')"

echo "Installing 'tinytex'"
/usr/bin/time Rscript -e "tinytex::install_tinytex(force = TRUE)"

echo "Installing R sound packages"
/usr/bin/time Rscript -e "source('$SYNTH_SCRIPTS/sound.R')"

echo "Activating R Jupyter kernel"
Rscript -e "IRkernel::installspec()"

echo "Cleanup"
mamba clean --tarballs --yes

echo "Defining $MAMBA_ENV_NAME and deac aliases"
if [ ! `grep -e "alias $MAMBA_ENV_NAME" $HOME/.bash_aliases | wc -l` -gt "0" ]
then
  cat $SYNTH_SCRIPTS/$MAMBA_ENV_NAME-aliases >> $HOME/.bash_aliases
fi

if [ -e $HOME/.zshrc ]
then
  if [ ! `grep -e "alias $MAMBA_ENV_NAME" $HOME/.zshrc | wc -l` -gt "0" ]
  then
    cat $SYNTH_SCRIPTS/$MAMBA_ENV_NAME-aliases >> $HOME/.zshrc
  fi
fi

echo "Finished"
