#! /bin/bash

echo "Edit before running!"
git config --global user.email ""
git config --global user.name ""

echo "Time in seconds to cache your credentials"
git config --global credential.helper 'cache --timeout=7200'
