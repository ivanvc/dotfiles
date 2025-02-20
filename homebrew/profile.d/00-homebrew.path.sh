#!/usr/bin/env bash

if [ -d "/home/linuxbrew/.linuxbrew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  # shellcheck disable=SC2155 # These variables are not being defined here.
  export LDFLAGS="-L$(brew --prefix)/lib -Wl,-rpath,$(brew --prefix)/lib ${LDFLAGS}"
  # shellcheck disable=SC2155
  export CPPFLAGS="-I$(brew --prefix)/include ${CPPFLAGS}"
  # shellcheck disable=SC2155
  export CFLAGS="-I$(brew --prefix)/include ${CFLAGS}"
fi
