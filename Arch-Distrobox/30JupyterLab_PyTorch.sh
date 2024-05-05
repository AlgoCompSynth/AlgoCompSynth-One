#! /usr/bin/env bash

echo "Installing JupyterLab stack"
sudo pacman --sync --refresh --needed --noconfirm \
  jupyterlab \
  python-matplotlib \
  python-numba \
  python-pandas \
  python-pytorch-opt-cuda \
  python-scikit-learn \
  python-scipy \
  python-sympy \
  torchvision-cuda

echo "Testing PyTorch"
./test-pytorch.py

echo "Installing R kernel"
Rscript -e "install.packages('IRkernel', quiet = TRUE)"
Rscript -e "IRkernel::installspec()"

echo "Finished"
  #python-kaldi-io \
  #python-torchaudio
