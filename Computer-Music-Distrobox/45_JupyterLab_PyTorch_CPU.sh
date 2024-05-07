#! /usr/bin/env bash

echo "Installing JupyterLab PyTorch stack"
/usr/bin/time sudo pacman --sync --refresh --needed --noconfirm \
  jupyterlab \
  python-matplotlib \
  python-numba \
  python-pandas \
  python-pytorch-opt \
  python-scikit-learn \
  python-scipy \
  python-sympy \
  python-torchvision \
  > Logs/45_JupyterLab_PyTorch_CPU.log 2>&1

echo "Testing PyTorch"
misc/test-pytorch-torchvision-CPU.py

echo "Installing R kernel"
Rscript -e "install.packages('IRkernel', quiet = TRUE)"
Rscript -e "IRkernel::installspec()"

echo "Installing torchaudio"
/usr/bin/time yay --sync --refresh --needed --noconfirm \
  python-torchaudio \
  >> Logs/45_JupyterLab_PyTorch_CPU.log 2>&1

echo "Testing torchaudio"
misc/test-torchaudio.py
