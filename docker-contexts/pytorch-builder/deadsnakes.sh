#! /bin/bash

set -e
rm -f $LOGS/deadsnakes.log

#https://tecadmin.net/how-to-install-python-3-9-on-ubuntu-18-04/
echo "Installing 'deadsnakes' Python 3.9"
add-apt-repository ppa:deadsnakes/ppa -y \
  >> $LOGS/deadsnakes.log 2>&1
apt-get install -qqy --no-install-recommends \
  python3.8 \
  python3.8-dev \
  python3.8-distutils \
  python3.8-venv \
  >> $LOGS/deadsnakes.log 2>&1
apt-get clean
