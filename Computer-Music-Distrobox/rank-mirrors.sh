#! /bin/bash

sudo reflector \
  --latest 20 \
  --protocol https \
  --age 6 \
  --sort rate \
  --save /etc/pacman.d/mirrorlist \
  --country 'United States' \
  --verbose 2>&1 | grep -v rating | grep -v nan | sort -n -k 5
