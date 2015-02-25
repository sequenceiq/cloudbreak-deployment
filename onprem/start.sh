#!/bin/bash +x

#the internal address of the host
export HOST_ADDRESS=""
#external/public address of the host
export CLOUDBREAK_PUBLIC_HOST_ADDRESS=""

$(dirname $BASH_SOURCE)/../start-cb.sh
