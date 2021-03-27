#! /bin/bash

export DEBIAN_FRONTEND=noninteractive

export SOURCE_DIR=/usr/local/src
export LOGS=$SOURCE_DIR/logs
export SCRIPTS=$SOURCE_DIR/scripts
export RUN_HOME=$PWD
mkdir --parents $LOGS $SCRIPTS

pushd $SOURCE_DIR

echo "set bg=dark" >> /root/.vimrc
cp $RUN_HOME/scripts/10base.sh $SCRIPTS/
$SCRIPTS/10base.sh || true

# install libmusicxml early because it takes 50 minutes
export LIBMUSICXML_VERSION="v3.18"
cp $RUN_HOME/scripts/15libmusicxml.sh $SCRIPTS/
$SCRIPTS/15libmusicxml.sh || true

export SUPERCOLLIDER_VERSION="Version-3.11.1"
export SC3_PLUGINS_VERSION="Version-3.11.1"
cp $RUN_HOME/scripts/20supercollider.sh $SCRIPTS/
$SCRIPTS/20supercollider.sh || true

export SONIC_PI_VERSION="v3.3.1"
cp $RUN_HOME/scripts/21sonic-pi.sh $SCRIPTS/
$SCRIPTS/21sonic-pi.sh || true

export FLUIDSYNTH_VERSION="v2.1.8"
cp $RUN_HOME/scripts/22fluidsynth.sh $SCRIPTS
$SCRIPTS/22fluidsynth.sh || true

export FAUST_VERSION="2.30.5"
cp $RUN_HOME/scripts/23faust.sh $SCRIPTS
$SCRIPTS/23faust.sh || true

export PD_VERSION="0.51-4"
cp $RUN_HOME/scripts/24pure-data.sh $SCRIPTS
$SCRIPTS/24pure-data.sh || true

export CSOUND_VERSION="6.15.0"
cp $RUN_HOME/scripts/25csound.sh $SCRIPTS
$SCRIPTS/25csound.sh || true

export CHUCK_VERSION="1.4.0.1"
cp $RUN_HOME/scripts/26chuck.sh $SCRIPTS
$SCRIPTS/26chuck.sh || true

export XPRA_VERSION="v4.1.1"
cp $RUN_HOME/scripts/27xpra.sh $SCRIPTS
$SCRIPTS/27xpra.sh || true

cp $RUN_HOME/scripts/28tidal.sh $SCRIPTS
$SCRIPTS/28tidal.sh || true

popd
