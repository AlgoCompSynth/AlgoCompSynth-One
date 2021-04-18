#! /bin/bash

set -e

echo "Configuring R"
/sbin/ldconfig --verbose
R CMD javareconf
