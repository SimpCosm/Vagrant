#!/usr/bin/env bash

# check if a go version is set
if [[ -z $1 ]]; then
        GO_VERSION="latest"
else
        GO_VERSION=$1
fi

# Check if gvm is installed
gvm version > /dev/null 2>&1
GVM_IS_INSTALLED=$?

if [ $GVM_IS_INSTALLED -eq 0 ]; then
    echo "Gvm Already Installed"
else
    # Installing dependencies
    echo "Installing Go version manager"
    sudo apt-get install -qq curl git mercurial make binutils bison build-essential
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    source /home/vagrant/.gvm/scripts/gvm

    if [[ $GO_VERSION -eq "latest" ]]; then
        GO_VERSION=`curl -L 'https://golang.org/' | grep 'Build version' | awk '{print $3}' | awk -F\< '{ print $1 }' | rev | cut -c 2- | rev`
    fi
    echo "Installing Go version "$GO_VERSION
    echo "This will also be the default version"

    gvm install $GO_VERSION --prefer-binary
    gvm use $GO_VERSION --default
fi

# install golang
mkdir -p $GO_HOME
if [ ! -d $GO_HOME/go ]; then
    curl -sSL -o /tmp/golang.tar.gz https://code.aliyun.com/k9kdqvbb/files/raw/master/go1.10.3.linux-amd64.tar.gz
    tar -C $GO_HOME -xzf /tmp/golang.tar.gz
fi
grep -q -F "export GOROOT=$GO_HOME/go" $USER_HOME/.profile || echo "export GOROOT=$GO_HOME/go" >> $USER_HOME/.profile
grep -q -F 'export PATH=$GOROOT/bin:$PATH' $USER_HOME/.profile || echo 'export PATH=$GOROOT/bin:$PATH' >> $USER_HOME/.profile
grep -q -F "export GOPATH=~/workspace/go" $USER_HOME/.profile || echo "export GOPATH=~/workspace/go" >> $USER_HOME/.profile
grep -q -F 'export PATH=$GOPATH/bin:$PATH' $USER_HOME/.profile || echo 'export PATH=$GOPATH/bin:$PATH' >> $USER_HOME/.profile
chown -R vagrant: $GO_HOME
rm -rf /tmp/golang.tar.gz
