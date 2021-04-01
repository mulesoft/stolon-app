#!/bin/sh
# -*- mode: sh; -*-

# set -o xtrace
set -o nounset
set -o errexit
set -o pipefail

/usr/bin/stolonctl server
