#!/bin/bash

echo -e "================  VARIABLES  ===================
      DATA_DIR=${DATA_DIR:="/ethereum/"}
      FREEZER_DIR=${FREEZER_DIR:="/ethereum/freezer"}
      API_ALLOWED=${API_ALLOWED:="eth,miner,net,web3,personal,txpool"}
      MAX_PEERS=${MAX_PEERS:=50}
      VERBOSITY=${VERBOSITY:=1}
      TESTNET=${TESTNET:=false}
      GCMODE=${GCMODE:=full}
      SYNCMODE=${SYNCMODE:=fast}
      CACHE=${CACHE:=2048}
      DEV_MODE=${DEV_MODE:=false}"

if [ $TESTNET == true ]; then
  echo -e "      NETWORK_ID=${NETWORK_ID:=3}"
else
  echo -e "      NETWORK_ID=${NETWORK_ID:=1}"
fi

echo "================================================="

if [ "x$DATA_DIR" == "x" ]; then
  echo "DATA_DIR is undefined !"
  echo "Exiting."
  exit -1;
fi

if [ ! -d $DATA_DIR ]; then
  mkdir $DATA_DIR
fi

if [ $TESTNET == true ]; then
  echo "Starting ropsten..."

  GETH_OPTS="$GETH_OPTS --testnet "
else 
  echo "Starting mainnet..."
  GETH_OPTS="$GETH_OPTS "
fi

if [ $DEV_MODE == true ]; then
  GETH_OPTS="$GETH_OPTS --dev "
fi

NODE_LOG="$DATA_DIR/node.log"

GETH_OPTS="$GETH_OPTS --syncmode=$SYNCMODE --gcmode=$GCMODE
          --rpc --rpcaddr=0.0.0.0 --rpcapi=$API_ALLOWED --rpccorsdomain='*'
          --ws --wsaddr=0.0.0.0 --wsapi=$API_ALLOWED --wsorigins=*
          --maxpeers=$MAX_PEERS --maxpendpeers=$MAX_PEERS --cache=$CACHE --nousb
          --lightpeers=0 --nousb
          --datadir=$DATA_DIR --datadir.ancient=$FREEZER_DIR
          --networkid=$NETWORK_ID
          --verbosity=$VERBOSITY"
echo "geth $GETH_OPTS"
geth $GETH_OPTS 2>&1 >$NODE_LOG

