#! /bin/bash

set -e

echo "Activating r-reticulate"
source $WORKON_HOME/r-reticulate/bin/activate
export PATH=$PATH:/usr/local/cuda/bin
echo "PATH is now $PATH"

cd $SYNTH_PROJECTS

export CUSIGNAL_HOME=$(pwd)/cusignal
echo "Removing previous 'cusignal'"
rm -fr $CUSIGNAL_HOME
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
cd $CUSIGNAL_HOME
echo "Checking out version v$CUSIGNAL_VERSION"
git checkout v$CUSIGNAL_VERSION

echo "Installing build dependencies with pip"
pip install \
  "numpy<1.22,>=1.18" \
  "Jinja2<3.1,>=2.10" \
  numba>=0.49 \
  scipy>=1.5.0 \
  matplotlib \
  pytest \
  pytest-benchmark \
  sphinx \
  pydata-sphinx-theme \
  sphinx-copybutton \
  numpydoc \
  ipython

echo "Building 'cusignal' wheel"
sed -i.bak 's/python setup.py install/python setup.py bdist_wheel --universal/' ./build.sh
/usr/bin/time ./build.sh --allgpuarch

echo "Saving 'cusignal' wheel to $SYNTH_WHEELS"
cp python/dist/cusignal-*.whl $SYNTH_WHEELS/

echo "Installing 'cusignal' wheel"
pip install python/dist/cusignal-*.whl

echo "pip built a wheel for py-cpuinfo"
echo "Copying it to $SYNTH_WHEELS/"
cp `find $HOME -name 'py-cpuinfo-*.whl'` $SYNTH_WHEELS/

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

echo "Finished"