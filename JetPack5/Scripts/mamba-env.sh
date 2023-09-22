#! /bin/bash

set -e

export PKG_CPPFLAGS="-DHAVE_WORKING_LOG1P"
export PKG_CONFIG_PATH=$CONDA_PREFIX/lib/pkgconfig

source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh

echo "Creating fresh $MAMBA_ENV_NAME virtual environment"
sed "s/PYTHON_VERSION/$PYTHON_VERSION/" $SYNTH_SCRIPTS/mamba-env.template \
  | sed "s/MAMBA_ENV_NAME/$MAMBA_ENV_NAME/" \
  > $SYNTH_SCRIPTS/mamba-env.yml
/usr/bin/time mamba env create --force --file $SYNTH_SCRIPTS/mamba-env.yml

echo "Activating $MAMBA_ENV_NAME"
mamba activate $MAMBA_ENV_NAME

echo "Installing 'tinytex'"
/usr/bin/time Rscript -e "tinytex::install_tinytex(force = TRUE)"

echo "Activating R Jupyter kernel"
Rscript -e "IRkernel::installspec()"

echo "Cleanup"
mamba clean --tarballs --yes

echo "Defining \'$MAMBA_ENV_NAME\' and deac aliases"
grep -v "alias $MAMBA_ENV_NAME" $HOME/.bash_aliases \
  | grep -v "alias deac" > zzwork.txt
mv zzwork.txt $HOME/.bash_aliases
echo "alias $MAMBA_ENV_NAME=\"mamba activate $MAMBA_ENV_NAME\"" >> $HOME/.bash_aliases
echo "alias deac=\"mamba deactivate\"" >> $HOME/.bash_aliases

if [ -e $HOME/.zshrc ]
then
  grep -v "alias $MAMBA_ENV_NAME" $HOME/.zshrc \
    | grep -v "alias deac" > zzwork.txt
  mv zzwork.txt $HOME/.zshrc
  echo "alias $MAMBA_ENV_NAME=\"mamba activate $MAMBA_ENV_NAME\"" >> $HOME/.zshrc
  echo "alias deac=\"mamba deactivate\"" >> $HOME/.zshrc
fi

echo "Finished"
