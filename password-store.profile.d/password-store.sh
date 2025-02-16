#!/bin/bash

__load_pass_autocomplete() {
  local files=(
    "/usr/share/bash-completion/completions/pass"
    "/home/linuxbrew/.linuxbrew/etc/bash_completion.d/pass"
  )
  for file in "${files[@]}"; do
    if [ -f "$file" ] ; then
      # shellcheck source=/dev/null
      . "$file"
    fi
  done
}

__load_pass_autocomplete
