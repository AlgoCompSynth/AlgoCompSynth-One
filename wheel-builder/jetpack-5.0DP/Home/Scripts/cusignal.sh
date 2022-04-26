#! /bin/bash

set -e

echo "Activating mamba commands"
source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh
export PATH=$PATH:/usr/local/cuda/bin

cd $SYNTH_PROJECTS

export CUSIGNAL_HOME=$(pwd)/cusignal
echo "Removing previous cuSignal"
rm -fr $CUSIGNAL_HOME

echo "Cloning cuSignal"
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
cd $CUSIGNAL_HOME

echo "Checking out version v$CUSIGNAL_VERSION"
git checkout v$CUSIGNAL_VERSION

echo "Creating mamba environment for build / install"
echo "This takes a long time; it's building CuPy with pip"
sed -i.bak "s/PYTHON_VERSION/$PYTHON_VERSION/" $SYNTH_SCRIPTS/cusignal_jetson_base.yml
/usr/bin/time mamba env create --file $SYNTH_SCRIPTS/cusignal_jetson_base.yml

echo "Activating cusignal-dev"
mamba activate cusignal-dev
echo "PATH is now $PATH"

echo "Building 'cusignal' wheel"
sed -i.bak 's/python setup.py install/python setup.py bdist_wheel --universal/' ./build.sh
/usr/bin/time ./build.sh --allgpuarch

echo "Saving 'cusignal' wheel to $SYNTH_WHEELS"
cp python/dist/cusignal-*.whl $SYNTH_WHEELS/

echo "Installing 'cusignal' wheel"
pip install python/dist/cusignal-*.whl

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
mamba list

echo "Finished"
