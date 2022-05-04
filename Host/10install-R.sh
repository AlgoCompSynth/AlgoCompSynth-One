#! /bin/bash

set -e

echo ""
echo "Setting environment variables"
export SYNTH_HOME=$PWD
source $SYNTH_HOME/jetpack-envars.sh

/usr/bin/time $SYNTH_INSTALLERS/r-base-dev.sh #> $SYNTH_LOGS/r-base-dev.log 2>&1

echo "Finished!"
