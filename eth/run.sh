#!/bin/bash

echo -e "================  VARIABLES  ===================
      DATA_DIR=${DATA_DIR:="/ethereum/"}
      API_ALLOWED=${API_ALLOWED:="eth,miner,net,web3,personal,txpool"}
      MAX_PEERS=${MAX_PEERS:=25}
      VERBOSITY=${VERBOSITY:=1}
      TESTNET=${TESTNET:=false}
      GCMODE=${GCMODE:=full}
      SYNCMODE=${SYNCMODE:=fast}
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
  BOOTNODES="enode://6332792c4a00e3e4ee0926ed89e0d27ef985424d97b6a45bf0f23e51f0dcb5e66b875777506458aea7af6f9e4ffb69f43f3778ee73c81ed9d34c51c4b16b0b0f@52.232.243.152:30303,enode://94c15d1b9e2fe7ce56e458b9a3b672ef11894ddedd0c6f247e0f1d3487f52b66208fb4aeb8179fce6e3a749ea93ed147c37976d67af557508d199d9594c35f09@192.81.208.223:30303"
  GETH_OPTS="$GETH_OPTS --bootnodes=$BOOTNODES --testnet "
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
          --maxpeers=$MAX_PEERS --maxpendpeers=$MAX_PEERS --cache=2048 --nousb
          --datadir=$DATA_DIR
          --networkid=$NETWORK_ID
          --verbosity=$VERBOSITY"
echo "geth $GETH_OPTS"
geth $GETH_OPTS 2>&1 >$NODE_LOG

