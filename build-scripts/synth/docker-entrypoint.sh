#! /usr/bin/env bash

set -e

if [ ${#SYNTH_PASSWORD} -lt 12 ]
then
  echo "New 'synth' password must be at least 12 characters!"
  echo "Exiting!"
  exit -255
fi
echo "Resetting 'synth' password"
echo "synth:${SYNTH_PASSWORD}" | chpasswd
