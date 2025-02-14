#!/usr/bin/env bash

if [ -d "/home/linuxbrew/.linuxbrew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  export LDFLAGS="-L$(brew --prefix)/lib -Wl,-rpath,$(brew --prefix)/lib"
  export CPPFLAGS="-I$(brew --prefix)/include"
  export CFLAGS="-I$(brew --prefix)/include"
fi
