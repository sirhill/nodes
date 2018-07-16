#!/bin/bash

echo -e "================  VARIABLES  ===================
      DATA_DIR=${DATA_DIR:="/ethereum/"}
      API_ALLOWED=${API_ALLOWED:="eth,miner,net,web3,personal,txpool"}
      MAX_PEERS=${MAX_PEERS:=25}
      VERBOSITY=${VERBOSITY:=1}
      TESTNET=${TESTNET:=false}"
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
  BOOTNODES="enode://20c9ad97c081d63397d7b685a412227a40e23c8bdc6688c6f37e97cfbc22d2b4d1db1510d8f61e6a8866ad7f0e17c02b14182d37ea7c3c8b9c2683aeb6b733a1@52.169.14.227:30303,enode://6ce05930c72abc632c58e2e4324f7c7ea478cec0ed4fa2528982cf34483094e9cbc9216e7aa349691242576d552a2a56aaeae426c5303ded677ce455ba1acd9d@13.84.180.240:30303,enode://13524b98776b3962791b7f9f7fcc8861f489d64e93e46a6793fb2924a6131942ee0d8753fc6c73208f0506c94f801b08ac9e54fca2d4a56e6c40bf194f28276e@104.131.38.234:30303,enode://145a93c5b1151911f1a232e04dd1a76708dd12694f952b8a180ced40e8c4d25a908a292bed3521b98bdd843147116a52ddb645d34fa51ae7668c39b4d1070845@188.166.147.175:30303,enode://26707157d3c9e2dc252d4acc7a4fde51af9e0107da60c9d55819831cc31e2689e05fe8d32d869d286c38407583619b2c82ece10db464914c9ae704a41bf7dd5c@188.138.33.235:30303,enode://30c1152e2dbabb27d1ae0d4fd9f2875a5dbe8d86e547cfaf973f3c756987509a2c0230a2472c46bedb25aa9a7a55f7fc7972e8ad225c33715206c05d3f406c76@203.189.228.3:30303,enode://3da9834077c10c08fc429b7457481bb4c04b9a26e1d0c095a6fb606e477cdf7e7be3b3a6a9e1cf94c6ce919fcff1a9952b412b3f59bc985dff6bf88bc909d7a0@5.189.136.236:30303,enode://55e34b13f1ddbed4b216f6436073ac30688c385e670bb59ed9ed4af51307f0f2dd16bec770d4871ae9448cde161f429490e1bc28fd1c2f1bce9912f313dcfe67@13.95.236.166:30303,enode://6b0237b54824e313e42d14bbb38d3d7f970275b0265dbb44a567188bc2a53191bc441caaa61193e760c2357f6ffc9d8b467d5ead2b8d6a7a05cac3f4e052654d@46.101.25.234:30303,enode://87e982a5b3c04326d74bb08bd811382d8f2f310892a076378a7d336e732e163bbfbe55f91a6b37980212de0b7f6258be8145abf10ea8fc89276ddf2857b871ae@165.227.159.206:30303,enode://ae38266a980c54c35abe7a1f3f09b7bdbd1fe3a1170e48b0353296df3ff1f6a815560e149fe113bcc1f7e9ca8422810e238dbb3e7e893e2b65a3ae19cbf01632@174.138.56.21:30303,enode://f0a2ca7144381ac0c14ff78b8c386f9d2751ef81c9e1d4570a6086239daed980e781586db1145fd275205388556b8c6343fc4d8caf3e24960f68015c5f86b315@165.227.124.59:30303"
  GETH_OPTS="$GETH_OPTS --bootnodes=$BOOTNODES --testnet --networkid=3 "
else 
  echo "Starting mainnet..."
  GETH_OPTS="$GETH_OPTS --networkid=1 "
fi

NODE_LOG="$DATADIR/node.log"

GETH_OPTS="$GETH_OPTS --syncmode=full
          --rpc --rpcaddr=0.0.0.0 --rpcapi=$API_ALLOWED --rpccorsdomain='*'
          --ws --wsaddr=0.0.0.0 --wsapi=$API_ALLOWED --wsorigins=*
          --maxpeers=$MAX_PEERS --cache=512
          --datadir=$DATA_DIR
          --verbosity=$VERBOSITY"
echo "geth $GETH_OPTS"
geth $GETH_OPTS 2>&1 >$NODE_LOG

