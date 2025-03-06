#!/usr/bin/env bash

if [ -d /home/linuxbrew/.linuxbrew/etc/bash_completion.d ]; then
  for file in /home/linuxbrew/.linuxbrew/etc/bash_completion.d/*; do
    # shellcheck source=/dev/null
    [[ -e "$file" ]] && . "$file"
  done
fi
