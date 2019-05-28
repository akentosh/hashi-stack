#!/bin/bash
set -x

# Detect os version and set our working directory
source /etc/os-release
echo "Get working directory"
echo "Determine OS type"
WORKDIR="/home/centos/application"

#Login to vault and export the token
VAULT_TOKEN=`vault login -token-only -method=userpass username=vault password=vault`
export VAULT_TOKEN

#Create named Docker volume
docker volume create consul-template

#Start consul template
nohup consul-template -template "/tmp/files/config.ini.ctmpl:/var/lib/docker/volumes/consul-template/_data/config.ini" >/dev/null 2>&1 &

#Start Consul Proxy for the Profit service
nohup consul connect proxy -service web -upstream profitapp-connect:8181 > /dev/null 2>&1 &

#Build Container and Run it
docker build -t frontend:latest "$WORKDIR/.";docker run -d --network="host"  --rm -v consul-template:/usr/src/app/config -e VAULT_TOKEN=$VAULT_TOKEN -p 5000:5000 --name spork-frontend frontend:latest
