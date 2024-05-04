#! /usr/bin/env bash

set -e

echo "Ranking mirrors"
./rank-mirrors.sh

echo "Initializing pacman key"
sudo pacman-key --init

echo "Updating packages"
sudo pacman -Syu

if [ ! -x /usr/sbin/yay ]
then
  echo "Installing yay"
  pushd /tmp
  rm -fr yay
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  yay --version
  popd
fi

echo "Setting makepkg.conf make jobs to `nproc`"
diff makepkg.conf /etc/makepkg.conf || true
sudo cp makepkg.conf /etc/makepkg.conf

echo "Updating package search databases"
sudo pacman -Fy
yay -Fy

echo "Installing command line conveniences"
yay --sync --refresh --needed --noconfirm \
  python-pygments \
  ttf-meslo-nerd-font-powerlevel10k \
  zsh \
  zsh-autosuggestions \
  zsh-completions \
  zshdb \
  zsh-doc \
  zsh-history-substring-search \
  zsh-lovers \
  zsh-syntax-highlighting \
  zsh-theme-powerlevel10k

echo "Setting shell control files"
cp bashrc $HOME/.bashrc
cp bash_aliases $HOME/.bash_aliases
cp vimrc-dark $HOME/.vimrc
sudo cp vimrc-dark /root/.vimrc
cp zshrc $HOME/.zshrc
cp p10k.zsh $HOME/.p10k.zsh

echo "Setting default shell for $USER to zsh"
sudo usermod --shell /usr/bin/zsh $USER

echo "Creating $HOME/.local/bin and $HOME/bin"
mkdir --parents $HOME/.local/bin
mkdir --parents $HOME/bin

echo "Finished"
