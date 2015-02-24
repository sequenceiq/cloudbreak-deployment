#!/bin/bash +x

export HOST_ADDRESS=http://localhost
cd .. && sed "s|HOST_ADDRESS|"$HOST_ADDRESS"|" uaa.tmp.yml > uaa.yml && ./konzul-cb.sh
