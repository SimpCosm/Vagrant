#!/usr/bin/env bash

if [[ -z $1 ]]; then
    github_url="https://raw.githubusercontent.com/SimpCosm/Vagrant/master"
else
    github_url="$1"
fi

export DEBIAN_FRONTEND=noninteractive
USER_HOME=/home/vagrant
mkdir -p /home/vagrant/workspace

echo "Setting Timezone & Locale to $2 & en_US.UTF-8"

sudo ln -sf /usr/share/zoneinfo/$2 /etc/localtime
sudo apt-get install -qq language-pack-en
sudo locale-gen en_US
sudo update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8

echo ">>> Installing Base Packages"

# Update
sudo apt-get update

# Install base packages
# -qq implies -y --force-yes
sudo apt-get install -qq curl unzip git-core ack-grep software-properties-common build-essential cachefilesd
sudo apt-get install -yqq --no-install-recommends gcc apt-utils rsync netcat procps libssl-dev
sudo apt-get install -yqq --no-install-recommends vim htop tree pv

# Grab .gitconfig and set owner
curl --silent -L $github_url/helpers/gitconfig > /home/vagrant/.gitconfig
sudo chown vagrant:vagrant /home/vagrant/.gitconfig

# configure ssh
sudo ed -i "s/PasswordAuthentication no/PasswordAuthentication yes/" /etc/ssh/sshd_config
sudo systemctl restart sshd.service

# set bashrc
grep -q -F "HISTSIZE=1000" $USER_HOME/.bashrc && sed -i 's/^HISTSIZE=1000/HISTSIZE=100000/' $USER_HOME/.bashrc
grep -q -F "HISTFILESIZE=2000" $USER_HOME/.bashrc && sed -i 's/^HISTFILESIZE=2000/HISTFILESIZE=200000/' $USER_HOME/.bashrc
# set prefix sensitive command prompt
echo '"\\e[A": history-search-backward' > $USER_HOME/.inputrc
echo '"\\e[B": history-search-forward' >> $USER_HOME/.inputrc
chown vagrant: $USER_HOME/.inputrc
