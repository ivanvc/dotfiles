#!/bin/bash

if command asdf &> /dev/null && asdf where golang &>/dev/null; then
  GOPATH=$(asdf where golang)/packages
  export GOPATH
  PATH=$GOPATH/bin:$PATH
fi
