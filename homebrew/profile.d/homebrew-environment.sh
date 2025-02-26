#!/usr/bin/env bash

function __homebrew_load_env {
  local brew_prefix
  brew_prefix=$(brew --prefix)
  if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/homebrew/Brewfile"
    export BREWFILE="${HOMEBREW_BUNDLE_FILE}"

    # Compilation environment variables
    export LDFLAGS="-L${brew_prefix}/lib -Wl,-rpath,${brew_prefix}/lib ${LDFLAGS}"
    export CPPFLAGS="-I${brew_prefix}/include ${CPPFLAGS}"
    export CFLAGS="-I${brew_prefix}/include ${CFLAGS}"
    export LD_LIBRARY_PATH="${brew_prefix}/lib:${LD_LIBRARY_PATH}"
  fi
}

__homebrew_load_env
