#!/bin/bash

CURRENT_DIR=`pwd`
echo $CURRENT_DIR
sudo docker run -d \
        -h rsk-testnet-01 \
        -p 5050:5050 -p 5050:5050/udp -p 4443:4444 \
        -v /data/mtpelerin/rsk/rsk-testnet-01:/rsk \
        -e TESTNET=true \
        mtpelerin/node-rsk

