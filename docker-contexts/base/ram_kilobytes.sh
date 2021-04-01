#! /bin/bash

set -e

# The Nano only has 4 GB of RAM. As a result, some builds swamp the available
# RAM and multi-job makes / Ninja builds are problematic - they swap and the
# system appears unresponsive, or the out-of-memory killer crashes them.
#
# This script returns the installed RAM in kilobytes. Other scripts can
# use it to adjust build job limits accordingly.
echo `grep MemTotal /proc/meminfo | sed 's/^MemTotal:  *//' | sed 's/ .*$//'`
