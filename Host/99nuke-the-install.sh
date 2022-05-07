#! /bin/bash

set -e

echo ""
echo "WARNING! THIS SCRIPT IS FOR TESTING ONLY!"
echo "IT WILL REMOVE EVERYTHING YOU MAY HAVE"
echo "SPENT HOURS INSTALLING. PLEASE BE SURE"
echo "YOU WANT TO RUN THIS AND START OVER!"
echo ""
echo "DO YOU WANT TO NUKE THE INSTALL?"
echo "IF SO, ENTER THE TEXT 'nUkE iT!!' BELOW."
read -p "Nuke it?"

if [ "$REPLY" != "nUkE iT!!" ]
then
  echo "Exiting without touching the install!"
  exit
else
  echo ""
  echo "You have decided to remove the AlgoCompSynth-One"
  echo "installation. If you change your mind, you have"
  echo "30 seconds to hit 'CTL-C' before the uninstall"
  echo "happens."
fi

echo ""
echo "Beginning 30 second sleep - press 'CTL-C' to abort"
echo "this uninstall script."
sleep 30

echo ""
echo "Setting environment variables"
export SYNTH_HOME=$PWD
source $SYNTH_HOME/jetpack-envars.sh

echo ""
echo "Removing the virtual desktop"
echo "..$SYNTH_LOGS"
rm -fr $SYNTH_LOGS
echo "..$SYNTH_PROJECTS"
rm -fr $SYNTH_PROJECTS
echo "..$SYNTH_NOTEBOOKS"
rm -fr $SYNTH_NOTEBOOKS
echo "..$SYNTH_WHEELS"
rm -fr $SYNTH_WHEELS

echo ""
echo "Removing r-reticulate virtual environment"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
mamba env remove --name r-reticulate --yes

echo ""
echo "Note: some things have not been removed:"
echo "1. Linux packages installed via 'apt-get',"
echo "2. The 'mambaforge' installation,"
echo "3. The pip cache, which includes the 'CuPy' wheel."

echo "Finished!"
