#! /bin/bash

set -e

rm -fr $HOME/AlgoCompSynth-OneDistrobox
distrobox rm -f AlgoCompSynth-One
distrobox create \
  --image quay.io/toolbx-images/ubuntu-toolbox:22.04 \
  --name AlgoCompSynth-One \
  --home $HOME/AlgoCompSynth-OneDistrobox \
  --init \
  --additional-packages \
    "systemd libpam-systemd apt-file git git-lfs mlocate time tree vim-nox" \
  --nvidia
cp -rp $HOME/.ssh $HOME/AlgoCompSynth-OneDistrobox

distrobox list
