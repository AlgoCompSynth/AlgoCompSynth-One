#! /usr/bin/env bash

echo "Installing Linux music tools"
yay --sync --refresh --needed \
  pipewire-jack
yay --sync --refresh --needed --noconfirm \
  chuck \
  csound-doc \
  csound-plugins \
  csoundqt \
  csound \
  faust \
  pd \
  pd-externals \
  sc3-plugins \
  supercollider \
  vim-csound

echo "Finished"
