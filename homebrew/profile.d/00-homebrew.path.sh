#!/usr/bin/env bash

__initialize_homebrew() {
  local paths=(
    "/home/linuxbrew/.linuxbrew"
    "/opt/homebrew"
  )
  for path in "${paths[@]}"; do
    if [ -d "$path" ]; then
      eval "$("$path"/bin/brew shellenv)"
    fi
  done
}

__initialize_homebrew
