#!/bin/bash +x

export HOST_ADDRESS=http://localhost
# The public IP of the machine and the port 8080 so the pattern is: http://xxx.xxx.xxx.xxx:8080
export CLOUDBREAK_PUBLIC_HOST_ADDRESS=""

$(dirname $BASH_SOURCE)/../start-cb.sh
