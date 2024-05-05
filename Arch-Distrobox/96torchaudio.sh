#! /usr/bin/env bash

set -e

yay torchaudio

yay --sync --refresh --needed \
  torchaudio
