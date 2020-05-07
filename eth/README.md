
# HowTo create a Proof of Authority network

1. Create the two nodes directory (on dedicated a volume ideally)

```
  sudo mkdir -p /data/ethereum/eth-poa-01
  sudo mkdir -p /data/ethereum/eth-poa-02
```

2. Create a mining accounts for each mining node (at least one)

```
  docker run -it -v '/data/ethereum/eth-poa-01:/ethereum' sirhill/node-eth geth --datadir=/ethereum --nousb account new
```

Create a `password.txt` file containing your password in each node directory.

Warning: Having the password for private key in a public network is strongly discouraged!
Warning: Backup the accounts and their private keys!!

3. Buld your network the docker-compose and adapt it to your needs.
You may add node either mining or not

In particular, check:
- the volume mapping
- The mining configuration (account to unlock and its the password)
- The network Id must be unique and not used 

More detail can be found here:
https://github.com/ethereum/go-ethereum/wiki/Command-Line-Options

4. Edit the genesis-poa.json template if needed and copy it in each node directory
You may run puppeth from within the docker to generate a new genesis from scratch
Otherwise, replace your network id and accounts which should receive initial funds in the alloc section

5. Init each node network

```
  docker run -it -v '/data/ethereum/eth-poa-01:/ethereum' sirhill/node-eth geth --datadir=/ethereum --nousb init genesis-poa.json
```

6. Edit the template static-nodes.json file with each of your nodes' enode

Enode can be obtain though the console:
```
  sudo docker run -it -v '/data/ethereum/eth-poa-02:/ethereum' sirhill/node-eth geth --datadir=/ethereum console
```

And using the commande `admin.nodeInfo`

Copy the the static-nodes.json file in each network directory
```
  cp ./static-nodes.json /data/ethereum/eth-poa-01/static-nodes.json
  cp ./static-nodes.json /data/ethereum/eth-poa-02/static-nodes.json
```

You will find the static IP and the port to use in the docker-compose file

7. Run your docker-compose scripts

```
sudo docker-compose -f ./docker-compose-poa.yml 
```
