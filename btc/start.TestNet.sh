#!/bin/bash

CURRENT_DIR=`pwd`
echo $CURRENT_DIR
sudo docker run -d \
        -h btc-testnet-01 \
        -p 8332:8332 -p 8333:8333 -p 18332:18332 -p 18333:18333 \
        -v /data/mtpelerin/bitcoin/btc-testnet-01:/bitcoin \
        -e TESTNET=true \
        mtpelerin/node-bitcoin

