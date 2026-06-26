#!/usr/bin/env bash

__load_bash_completion() {
  local paths=(
    "/home/linuxbrew/.linuxbrew"
    "/opt/homebrew"
  )
  for path in "${paths[@]}"; do
    local full_path="${path}/etc/profile.d/bash_completion.sh"
    if [ -r "$full_path" ]; then
      # shellcheck disable=SC1091
      # disable linting the sourced file.
      . "$full_path"
    fi
  done
}

__load_bash_completion
