#!/bin/bash

# Available APIs eth,miner,net,web3,personal,txpool
echo -e "================  VARIABLES  ===================
      DATA_DIR=${DATA_DIR:="/ethereum/"}
      FREEZER_DIR=${FREEZER_DIR:="/ethereum/freezer"}
      AUTHORIZED_IP=${AUTHORIZED_IP:="0.0.0.0"}
      API_ALLOWED=${API_ALLOWED:="eth,net,web3"}
      MAX_PEERS=${MAX_PEERS:=50}
      VERBOSITY=${VERBOSITY:=1}
      NETWORK=${NETWORK:=mainnet}
      GCMODE=${GCMODE:=full}
      SYNCMODE=${SYNCMODE:=fast}
      CACHE=${CACHE:=2048}
      DEV_MODE=${DEV_MODE:=false}"

if [ $NETWORK == "ropsten" ]; then
  echo "Using ropsten config..."
  GETH_OPTS="$GETH_OPTS --testnet "
  echo -e "      NETWORK_ID=${NETWORK_ID:=3}"
elif [ $NETWORK == "rinkeby" ]; then
  echo "Using rinkeby config..."
  GETH_OPTS="$GETH_OPTS --rinkeby "
  echo -e "      NETWORK_ID=${NETWORK_ID:=4}"
elif [ $NETWORK == "goerli" ]; then
  echo "Using goerli config..."
  GETH_OPTS="$GETH_OPTS --goerli "
  echo -e "      NETWORK_ID=${NETWORK_ID:=5}"
else
  echo "Using mainnet config..."
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

if [ $DEV_MODE == true ]; then
  GETH_OPTS="$GETH_OPTS --dev "
fi

if [ "x$BOOT_NODES" != "x" ]; then
  echo -e "      BOOT_NODES=${BOOT_NODES}"
  GETH_OPTS="$GETH_OPTS --bootnodes='$BOOT_NODES'"
fi

NODE_LOG="$DATA_DIR/node.log"

GETH_OPTS="$GETH_OPTS --syncmode=$SYNCMODE --gcmode=$GCMODE
          --rpc --rpcaddr=$AUTHORIZED_IP --rpcapi=$API_ALLOWED --rpccorsdomain='*'
          --ws --wsaddr=$AUTHORIZED_IP --wsapi=$API_ALLOWED --wsorigins=*
          --maxpeers=$MAX_PEERS --maxpendpeers=$MAX_PEERS --cache=$CACHE --nousb
          --lightpeers=0 --nousb
          --datadir=$DATA_DIR --datadir.ancient=$FREEZER_DIR
          --networkid=$NETWORK_ID
          --verbosity=$VERBOSITY"
echo "geth $GETH_OPTS"
geth $GETH_OPTS 2>&1 >$NODE_LOG

