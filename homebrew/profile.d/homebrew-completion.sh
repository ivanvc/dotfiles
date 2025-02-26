#!/usr/bin/env bash

if [ -d /home/linuxbrew/.linuxbrew/etc/bash_completion.d ]; then
  for file in "$HOME"/home/linuxbrew/.linuxbrew/etc/bash_completion/*.sh; do
    # shellcheck source=/dev/null
    [[ -e "$file" ]] && . "$file"
  done
fi
