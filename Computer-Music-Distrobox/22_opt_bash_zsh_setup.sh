#! /usr/bin/env bash

set -e

echo "Installing command line conveniences"
sudo pacman --sync --refresh --needed --noconfirm \
  python-pygments \
  zsh \
  zsh-autosuggestions \
  zsh-completions \
  zshdb \
  zsh-doc \
  zsh-history-substring-search \
  zsh-lovers \
  zsh-syntax-highlighting \
  > Logs/powerlevel10k.log 2>&1
/usr/bin/time yay --sync --refresh --needed --noconfirm \
  ttf-meslo-nerd-font-powerlevel10k \
  zsh-theme-powerlevel10k \
  >> Logs/powerlevel10k.log 2>&1

echo "Setting shell control files"
cp misc/bashrc $HOME/.bashrc
cp misc/bash_aliases $HOME/.bash_aliases
cp misc/vimrc-dark $HOME/.vimrc
sudo cp misc/vimrc-dark /root/.vimrc
cp misc/zshrc $HOME/.zshrc
cp misc/p10k.zsh $HOME/.p10k.zsh

echo "Setting default shell for $USER to zsh"
sudo usermod --shell /usr/bin/zsh $USER

echo "Creating $HOME/.local/bin and $HOME/bin"
mkdir --parents $HOME/.local/bin
mkdir --parents $HOME/bin

echo "Finished"