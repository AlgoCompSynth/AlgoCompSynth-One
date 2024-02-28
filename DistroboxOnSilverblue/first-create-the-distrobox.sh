#! /bin/bash

set -e

rm -fr $HOME/AlgoCompSynthOneDistrobox
distrobox rm -f AlgoCompSynthOne
distrobox create \
  --image quay.io/toolbx-images/ubuntu-toolbox:22.04 \
  --name AlgoCompSynthOne \
  --home $HOME/AlgoCompSynthOneDistrobox \
  --init \
  --additional-packages \
    "systemd libpam-systemd apt-file git git-lfs mlocate time tree vim-nox" \
  --nvidia
cp -rp $HOME/.ssh $HOME/AlgoCompSynthOneDistrobox

distrobox list
distrobox enter AlgoCompSynthOne
