#! /bin/bash

set -e

echo "Installing micromamba"
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)
$HOME/.local/bin/micromamba shell init --shell bash
if [ -x $HOME/.zshrc ]
then
  $HOME/.local/bin/micromamba shell init --shell zsh
fi

echo "Finished"
