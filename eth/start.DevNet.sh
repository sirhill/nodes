#!/bin/bash

CURRENT_DIR=`pwd`
#ARGS_OPTS="-e VERBOSITY=6"

echo $CURRENT_DIR
sudo docker run -d \
        -h eth-devnet-01 \
        -p 30303:30303 -p 30303:30303/udp -p 8545:8545 -p 8546:8546 \
        -v /data/mtpelerin/ethereum/eth-devnet-01:/ethereum \
        -v ~/scripts/:/scripts \
        -e DEV_MODE=true -e NETWORK_ID=20180909 $ARGS_OPTS \
        -t mtpelerin/node-eth

