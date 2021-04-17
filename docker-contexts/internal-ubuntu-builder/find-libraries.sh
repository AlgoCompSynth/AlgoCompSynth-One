#! /bin/bash

set -e

grep -h "^  " \
  audio.sh \
  chuck.sh \
  faust.sh \
  fluidsynth.sh \
  libinstpatch.sh \
  r-from-source.sh \
| grep '\\' \
| sort -u \
> edit-use-and-delete-me
