#! /usr/bin/env bash

yay --sync --refresh --needed --noconfirm \
  jupyterlab \
  python-matplotlib \
  python-pandas \
  python-scikit-learn \
  python-scipy \
  python-sympy

echo "Finished"
