#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
export SYNTH_HOME=$PWD
source $SYNTH_HOME/set-envars.sh
source $SYNTH_HOME/mamba-init.sh

echo "Enabling conda and mamba commands"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh

echo "Activating $MAMBA_ENV_NAME"
mamba activate $MAMBA_ENV_NAME

echo "Setting R compile flags"
export PKG_CPPFLAGS="-DHAVE_WORKING_LOG1P"
export PKG_CONFIG_PATH=$CONDA_PREFIX/lib/pkgconfig
export MAKE="make $MAKEFLAGS"

echo ""
echo "Creating virtual desktop"
mkdir --parents \
  $SYNTH_LOGS \
  $SYNTH_PROJECTS \
  $SYNTH_NOTEBOOKS \
  $SYNTH_WHEELS

echo "Installing PyTorch if necessary"
if [ `mamba list | grep "torch  " | wc -l` -le "0" ]
then
  echo "..Installing PyTorch from NVIDIA wheel"
  /usr/bin/time $SYNTH_SCRIPTS/pytorch.sh > $SYNTH_LOGS/pytorch.log 2>&1
fi
$SYNTH_SCRIPTS/test-pytorch.sh 2>&1 | tee $SYNTH_LOGS/test-pytorch.log

echo "Installing torchaudio if necessary"
if [ `mamba list | grep "torchaudio" | wc -l` -le "0" ]
then
  echo "..Installing torchaudio"
  /usr/bin/time $SYNTH_SCRIPTS/torchaudio.sh > $SYNTH_LOGS/torchaudio.log 2>&1
fi
$SYNTH_SCRIPTS/test-torchaudio.sh 2>&1 | tee $SYNTH_LOGS/test-torchaudio.log

echo "Installing R sound packages"
/usr/bin/time Rscript -e "source('$SYNTH_SCRIPTS/sound.R')" > $SYNTH_LOGS/sound.log 2>&1

echo "Installing CuPy if necessary"
if [ `mamba list | grep "cupy" | wc -l` -le "0" ]
then
  echo "..Installing CuPy"
  echo "..This can take a long time if the wheel isn't in the pip cache!"
  /usr/bin/time $SYNTH_SCRIPTS/cupy.sh > $SYNTH_LOGS/cupy.log 2>&1
fi

echo "Installing cusignal if necessary"
export CUSIGNAL_TEST="0" # Don't test by default
if [ `mamba list | grep "cusignal" | wc -l` -le "0" ]
then
  echo "..Installing cusignal"
  /usr/bin/time $SYNTH_SCRIPTS/cusignal.sh > $SYNTH_LOGS/cusignal.log 2>&1
fi

echo ""
echo "Listing Mamba packages"
echo "# Mamba packages" > $SYNTH_LOGS/Mamba-packages.log
mamba list --name $MAMBA_ENV_NAME \
  >> $SYNTH_LOGS/Mamba-packages.log

echo ""
echo "Listing R packages"
echo "# R packages" > $SYNTH_LOGS/R-packages.log
Rscript -e 'subset(installed.packages(), select = c("Version", "Built"))' \
  >> $SYNTH_LOGS/R-packages.log

echo ""
echo "Finished!"
