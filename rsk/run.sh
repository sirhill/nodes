#!/bin/bash
echo -e "================  VARIABLES  ===================
      DATA_DIR=${DATA_DIR:="/rsk"}
      RPC_USER=${RPC_USER:="rsk-testnet"}
      TESTNET=${TESTNET:=false}
      NODE_CONFIG=${NODE_CONFIG:="$DATA_DIR/node.conf"}
      LOG_CONFIG=${LOG_CONFIG:="$DATA_DIR/logback.xml"}"
echo "================================================="

if [ "x$DATA_DIR" == "x" ]; then
  echo "DATA_DIR is undefined !"
  echo "Exiting."
  exit -1;
fi

if [ ! -d $DATA_DIR ]; then
  mkdir $DATA_DIR
fi

if [ ! -f "$LOG_CONFIG" ]; then
  echo "Initializing LOG_CONFIG=$LOG_CONFIG"
  cp /root/logback.xml $LOG_CONFIG
fi

if [ ! -f "$NODE_CONFIG" ]; then
  echo "Initializing NODE_CONFIG=$NODE_CONFIG"
  if [ $TESTNET == true ]; then
    cp /root/node.TestNet.conf $NODE_CONFIG
  else
    cp /root/node.MainNet.conf $NODE_CONFIG
  fi
fi


if [ $TESTNET == true ]; then
  echo "Starting rsk testnet"
  /usr/bin/java -Dlogback.configurationFile=$LOG_CONFIG \
	-Drsk.conf.file=$NODE_CONFIG \
	-cp /usr/share/rsk/rsk.jar co.rsk.Start > /dev/null 2>&1
else
  echo "Starting rsk mainnet"
  /usr/bin/java -Dlogback.configurationFile=$LOG_CONFIG \
	-Drsk.conf.file=$NODE_CONFIG \
	-cp /usr/share/rsk/rsk.jar co.rsk.Start > /dev/null 2>&1
fi

