#!/bin/bash

set -x

# Get system dependencies
apt-get update
apt-get install -y make gcc

# Build the demo.
#
# TODO: change to 'demo build' which knows
# this directory
cd /root/src
/demo/build/default.sh
