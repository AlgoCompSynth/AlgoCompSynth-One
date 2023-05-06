#! /bin/bash

set -e

source ../mamba-init.sh
echo "MAMBAFORGE_HOME=$MAMBAFORGE_HOME"
source ./envname-init.sh
echo "Activating $ENVNAME"
source $MAMBAFORGE_HOME/etc/profile.d/conda.sh
source $MAMBAFORGE_HOME/etc/profile.d/mamba.sh
mamba activate $ENVNAME

echo "Installing PyTorch"
export "LD_LIBRARY_PATH=/usr/lib/llvm-8/lib:$LD_LIBRARY_PATH"
python -m pip install --upgrade protobuf
python -m pip install --no-cache pytorch/dist/torch-*.whl
echo "Testing PyTorch execution and GPU availability"
python ./test-pytorch.py
echo "Copying PyTorch wheel"
cp pytorch/dist/torch-*.whl .
echo "Finished"
