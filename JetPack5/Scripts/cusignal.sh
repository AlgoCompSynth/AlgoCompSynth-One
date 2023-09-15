#! /bin/bash

set -e

source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
export PATH=$PATH:/usr/local/cuda/bin

echo "Activating r-reticulate"
mamba activate r-reticulate

if [ `find $SYNTH_WHEELS -name "cusignal-*.whl" | wc -l` -gt "0" ]
then
  echo "cusignal wheel found - installing and exiting normally"

  # cupy is cached!
  pip install cupy
  pip install $SYNTH_WHEELS/cusignal-*.whl
  exit
fi

echo "cusignal build required - deactivating r-reticulate"
mamba deactivate

cd $SYNTH_PROJECTS

export CUSIGNAL_HOME=$(pwd)/cusignal
echo "Removing previous 'cusignal'"
rm -fr $CUSIGNAL_HOME
echo "Cloning cuSignal source"
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
cd $CUSIGNAL_HOME
echo "Checking out version v$CUSIGNAL_VERSION"
git checkout v$CUSIGNAL_VERSION

echo "Patching environment file for Python version $PYTHON_VERSION"
export NEW_LINE="- python=$PYTHON_VERSION"
sed -i.bak "/dependencies:/a $NEW_LINE" conda/environments/cusignal_jetson_base.yml
sed -i "s/^-/  -/" conda/environments/cusignal_jetson_base.yml

echo "Creating fresh cusignal-dev environment"
/usr/bin/time mamba env create --quiet --force --file conda/environments/cusignal_jetson_base.yml

echo "Activating cusignal-dev"
mamba activate cusignal-dev

echo "Building cuSignal wheel"
sed -i.bak "s/python setup.py install/python setup.py bdist_wheel/" ./build.sh
/usr/bin/time ./build.sh

echo "Saving cuSignal wheel"
cp python/dist/cusignal-*.whl $SYNTH_WHEELS/

echo "Test installing cuSignal wheel"
pip install $SYNTH_WHEELS/cusignal-*.whl

if [ $CUSIGNAL_TEST -gt "0" ]
then
  set +e
  echo "Testing 'cusignal'"
  /usr/bin/time pytest -v
  set -e
fi

echo "Copying $CUSIGNAL_HOME/notebooks to $SYNTH_NOTEBOOKS/cusignal-notebooks"
rm -rf $SYNTH_NOTEBOOKS/cusignal-notebooks
cp -rp $CUSIGNAL_HOME/notebooks $SYNTH_NOTEBOOKS/cusignal-notebooks

echo "Copying E2E test notebooks to $SYNTH_NOTEBOOKS"
cp $SYNTH_SCRIPTS/E2E*ipynb $SYNTH_NOTEBOOKS/

echo "Deactivating cusignal-dev"
mamba deactivate

echo "Activating r-reticulate"
mamba activate r-reticulate
echo "Installing cuSignal wheel in r-reticulate"
# cupy is cached!
pip install cupy
pip install $SYNTH_WHEELS/cusignal-*.whl

echo "Cleanup"
echo "..Removing cusignal-dev virtual environment"
mamba env remove --name cusignal-dev --yes
echo "..Removing cusignal project repository"
rm -fr $SYNTH_PROJECTS/cusignal
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

echo "Finished"
