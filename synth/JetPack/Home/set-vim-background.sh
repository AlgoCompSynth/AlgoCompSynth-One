#! /bin/bash

set -e

echo "Setting 'vim' editor background"
echo "If your terminal background is light, enter any non-empty text string."
read -p "If it's dark, just press 'Enter':"

if [ ${#REPLY} == "0" ]
then
  echo "set bg=dark" >> $HOME/.vimrc
else
  echo "set bg=light" >> $HOME/.vimrc
fi

echo "'vim' background is set"
