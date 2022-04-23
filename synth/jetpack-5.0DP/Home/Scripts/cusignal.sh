#! /bin/bash

set -e

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin
echo $PATH

cd $SYNTH_PROJECTS

export CUSIGNAL_HOME=$(pwd)/cusignal
echo "Removing previous 'cusignal'"
rm -fr $CUSIGNAL_HOME
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
cd $CUSIGNAL_HOME
echo "Checking out version v$CUSIGNAL_VERSION"
git checkout v$CUSIGNAL_VERSION

echo "Building 'cusignal'"
/usr/bin/time ./build.sh --allgpuarch

if [ $CUSIGNAL_TEST -gt "0" ]
then
  set +e
  echo "Testing 'cusignal'"
  /usr/bin/time pytest -v
  set -e
fi

echo "Copying '$CUSIGNAL_HOME/notebooks' to '$SYNTH_NOTEBOOKS'"
rm -rf $SYNTH_NOTEBOOKS/cusignal-notebooks
cp -rp $CUSIGNAL_HOME/notebooks $SYNTH_NOTEBOOKS/cusignal-notebooks

echo "Cleanup"
pip list
rm -fr $SYNTH_PROJECTS/cusignal

echo "Finished"
