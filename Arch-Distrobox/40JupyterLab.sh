#! /usr/bin/env bash

echo "Installing JupyterLab stack"
yay --sync --refresh --needed --noconfirm \
  jupyterlab \
  python-kaldi-io \
  python-matplotlib \
  python-numba \
  python-pandas \
  python-pytorch-opt-cuda \
  python-scikit-learn \
  python-scipy \
  python-sympy \
  python-torchaudio

echo "Testing PyTorch"
./test-pytorch.py

echo "Installing R kernel"
Rscript -e "IRkernel::installspec()"

echo "Finished"
