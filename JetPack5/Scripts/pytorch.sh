#! /bin/bash

set -e

source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate r-reticulate
export PATH=$PATH:/usr/local/cuda/bin

pushd $SYNTH_WHEELS
rm -f torch-*.whl
echo "Downloading PyTorch wheel"
wget --quiet $PYTORCH_WHEEL_URL --output-document=$PYTORCH_WHEEL_FILE
popd

echo "Installing PyTorch"
export "LD_LIBRARY_PATH=/usr/lib/llvm-8/lib:$LD_LIBRARY_PATH"
python -m pip install --upgrade protobuf
python -m pip install --no-cache $SYNTH_WHEELS/$PYTORCH_WHEEL_FILE

echo "Cleanup"
echo "..Removing downloaded tarballs"
mamba clean --tarballs --yes

echo "Finished"
