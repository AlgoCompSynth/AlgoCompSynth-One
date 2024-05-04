#! /usr/bin/env bash

echo "Installing JupyterLab stack"
yay --sync --refresh --needed --noconfirm \
  jupyterlab \
  python-kaldi-io \
  python-matplotlib \
  python-pandas \
  python-pytorch-opt-cuda \
  python-scikit-learn \
  python-scipy \
  python-sympy \
  python-torchaudio \
  python-torchvision-cuda

echo "Testing PyTorch"
./test-pytorch.py

echo "Finished"
