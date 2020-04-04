#!/usr/bin/env bash

GO_HOME=/home/vagrant/software
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
