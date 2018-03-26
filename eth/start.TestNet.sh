#!/bin/bash

CURRENT_DIR=`pwd`
echo $CURRENT_DIR
sudo docker run -d \
        -h eth-testnet-01 \
        -p 30303:30303 -p 30303:30303/udp -p 8545:8545 -p 8546:8546 \
        -v /data/mtpelerin/ethereum/eth-testnet-01:/ethereum \
        -e TESTNET=true \
#        -e VERBOSITY=6 \
        mtpelerin/node-eth

