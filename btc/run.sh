#!/bin/bash

echo -e "================  VARIABLES  ===================
      DATA_DIR=${DATA_DIR:="/bitcoin/"}
      RPC_USER=${RPC_USER:="btc-testnet"}
      RPC_PASSWORD=${RPC_PASSWORD:="btc-testnet-pwd"}
      TESTNET=${TESTNET:=false}"
echo "================================================="

if [ "x$DATA_DIR" == "x" ]; then
  echo "DATA_DIR is undefined !"
  echo "Exiting."
  exit -1;
fi

if [ ! -d $DATA_DIR ]; then
  mkdir -p $DATA_DIR/
fi

if [ $TESTNET == true ]; then
  echo "Starting bitcoin testnet"
  bitcoind -datadir=$DATA_DIR -testnet -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD
else
  echo "Starting bitcoin mainnet"
  bitcoind -datadir=$DATA_DIR -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD
fi

