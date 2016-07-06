#!/bin/bash

if [ "$(docker ps -a |awk '{print $2}'| grep dns-gen)" == "jderusse/dns-gen" ];then
  echo "DNS-gen is already running, restarting container now!"
  docker restart $(docker ps -a |grep dns-gen | awk '{print $1}') 
  exit 0
fi

# get docker0 IP address
DOCKER0_IP=$(/sbin/ifconfig docker0 | grep "inet" | head -n1 | awk '{ print $2}' | cut -d: -f2)

# get latest version
docker pull jderusse/dns-gen
docker run --detach \
  --name dns-gen \
  --restart always \
  --publish $DOCKER0_IP:53:53/udp \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  jderusse/dns-gen

# Add nameserver to /etc/resolv.conf
echo "nameserver $DOCKER0_IP" | sudo tee --append /etc/resolvconf/resolv.conf.d/head
# Add search .docker to resolv.conf

SEARCH=$(grep search /etc/resolv.conf)
if [ "$SEARCH" != "" ];then
  SEARCH=$(echo "$SEARCH docker")
else
  SEARCH="search docker"
fi
echo "$SEARCH" | sudo tee --append /etc/resolvconf/resolv.conf.d/tail

# reconfigure resolv.conf
sudo resolvconf -u


