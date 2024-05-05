#! /usr/bin/env bash

set -e

yay --sync --refresh --needed \
  python-kaldi-io \
  python-torchaudio \
  > torchaudio.log 2>&1
