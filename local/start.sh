#!/bin/bash +x

export HOST_ADDRESS=http://localhost
export CLOUDBREAK_PUBLIC_HOST_ADDRESS=""

$(dirname $BASH_SOURCE)/../start-cb.sh
