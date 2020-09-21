export GOPATH=~/Code/go

if [[ -d /usr/local/opt/go/libexec/bin ]]; then
  export PATH=$PATH:/usr/local/opt/go/libexec/bin
fi

if [[ -d $GOPATH/bin ]]; then
  export PATH=$GOPATH/bin:$PATH
fi
