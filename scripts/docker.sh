#!/usr/bin/env bash

echo ">>> Installing Docker"

# Add Key
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

# Add Repository
sudo sh -c "echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
sudo apt-get update

# Install Docker
# -qq implies -y --force-yes
sudo apt-get install -qq lxc-docker

# Make the vagrant user able to interact with docker without sudo
if [ ! -z "$1" ]; then
	if [ "$1" == "permissions" ]; then
		echo ">>> Adding vagrant user to docker group"

		sudo usermod -a -G docker vagrant

	fi # permissions
fi # arg check

# aliyun speed up docker image download
sudo mkdir -p /etc/docker
#sudo curl --silent -L $github_url/helpers/docker.json > /etc/docker/daemon.json
sudo echo "{" > /etc/docker/daemon.json
sudo echo '  "registry-mirrors": ["https://ht6aappv.mirror.aliyuncs.com"]' >> /etc/docker/daemon.json
sudo echo "}" >> /etc/docker/daemon.json

sudo systemctl daemon-reload
sudo systemctl restart docker
# install docker-compose
DOCKER_COMPOSE=/usr/local/bin/docker-compose
if [ ! -f $DOCKER_COMPOSE ]; then
    sudo curl -sSL -o $DOCKER_COMPOSE https://code.aliyun.com/k9kdqvbb/files/raw/master/docker-compose-Linux-x86_64
    sudo chmod +x $DOCKER_COMPOSE 
fi
# clean
sudo apt-get autoremove -yqq --purge
sudo apt-get clean && apt-get autoclean
