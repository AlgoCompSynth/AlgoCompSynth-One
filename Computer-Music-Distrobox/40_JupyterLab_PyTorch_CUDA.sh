#! /usr/bin/env bash

echo "Installing JupyterLab PyTorch stack"
/usr/bin/time sudo pacman --sync --refresh --needed --noconfirm \
  jupyterlab \
  python-matplotlib \
  python-numba \
  python-pandas \
  python-pytorch-opt-cuda \
  python-scikit-learn \
  python-scipy \
  python-sympy \
  python-torchvision-cuda \
  > Logs/40_JupyterLab_PyTorch_CUDA.log 2>&1

echo "Testing PyTorch"
./test-pytorch-torchvision-CUDA.py

echo "Installing R kernel"
Rscript -e "install.packages('IRkernel', quiet = TRUE)"
Rscript -e "IRkernel::installspec()"

echo "Installing Kaldi and torchaudio"
/usr/bin/time yay --sync --refresh --needed --noconfirm \
  python-kaldi-io \
  python-torchaudio \
  >> Logs/40_JupyterLab_PyTorch_CUDA.log 2>&1

echo "Testing torchaudio"
./test-torchaudio.py
