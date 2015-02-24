#!/bin/bash

export CB_DIR=/usr/local/cloudbreak
export START_SCRIPT_NAME=start_cb.sh
export START_CB_SCRIPT=$CB_DIR/$START_SCRIPT_NAME
export HOST_ADDRESS=http://$(curl -s -m 5 http://169.254.169.254/latest/meta-data/public-ipv4)
export CLOUDBREAK_PUBLIC_HOST_ADDRESS=$HOST_ADDRESS:8080
# make start script executable
chmod +x $START_CB_SCRIPT

# deploy
cd $CB_DIR && ./$START_SCRIPT_NAME
